import {
  createHash,
  randomBytes,
} from "node:crypto";
import assert from "node:assert/strict";
import test from "node:test";

import {
  TutorBackendResponse,
} from "../contracts/types";
import {
  IdempotencyService,
} from "./IdempotencyService";
import {
  IDEMPOTENCY_TTL_MS,
  IdempotencyClaim,
  IdempotencyClaimResult,
  IdempotencyKey,
  IdempotencyStore,
} from "./idempotencyTypes";

interface MemoryRecord {
  status: "processing" | "completed";
  claimToken: string;
  expiresAt: Date;
  response?: TutorBackendResponse;
}

/**
 * In-memory store for idempotency unit tests.
 */
class MemoryIdempotencyStore
implements IdempotencyStore {
  private readonly records =
    new Map<string, MemoryRecord>();

  /**
   * Builds the logical record id.
   *
   * @param {IdempotencyKey} key Logical key.
   * @return {string} Record id.
   */
  private recordId(
    key: IdempotencyKey,
  ): string {
    return createHash("sha256")
      .update(
        `${key.uid}:${key.clientRequestId}`,
        "utf8",
      )
      .digest("hex");
  }

  /**
   * Claims an idempotency record.
   *
   * @param {IdempotencyKey} key Logical key.
   * @param {Date} now Backend time.
   * @return {Promise<IdempotencyClaimResult>} Result.
   */
  async claim(
    key: IdempotencyKey,
    now: Date,
  ): Promise<IdempotencyClaimResult> {
    const recordId =
      this.recordId(key);

    const existing =
      this.records.get(recordId);

    if (
      existing &&
      existing.expiresAt.getTime() >
      now.getTime()
    ) {
      if (
        existing.status ===
        "completed" &&
        existing.response
      ) {
        return {
          status: "completed",
          response:
            existing.response,
        };
      }

      return {
        status: "processing",
      };
    }

    const claimToken =
      randomBytes(24)
        .toString("base64url");

    const expiresAt =
      new Date(
        now.getTime() +
        IDEMPOTENCY_TTL_MS,
      );

    this.records.set(
      recordId,
      {
        status: "processing",
        claimToken,
        expiresAt,
      },
    );

    return {
      status: "acquired",
      claim: {
        recordId,
        claimToken,
        expiresAt,
      },
    };
  }

  /**
   * Completes a claimed record.
   *
   * @param {IdempotencyClaim} claim Claim.
   * @param {TutorBackendResponse} response Response.
   * @param {Date} now Backend time.
   * @return {Promise<void>} Completion promise.
   */
  async complete(
    claim: IdempotencyClaim,
    response: TutorBackendResponse,
    now: Date,
  ): Promise<void> {
    void now;

    const record =
      this.records.get(
        claim.recordId,
      );

    if (
      !record ||
      record.status !== "processing" ||
      record.claimToken !==
      claim.claimToken
    ) {
      throw new Error(
        "Invalid claim",
      );
    }

    this.records.set(
      claim.recordId,
      {
        ...record,
        status: "completed",
        response,
      },
    );
  }
}

const key: IdempotencyKey = {
  uid: "uid_a",
  clientRequestId:
    "550e8400-e29b-41d4-a716-446655440000",
};

const successResponse:
TutorBackendResponse = {
  schemaVersion: "1.0",
  status: "ok",
  interactionId: "int_1",
  tutorSessionId: "sess_1",
  contentFormat: "plain_text",
  responseType: "hint",
  title: "Pista",
  message: "Observe a fatoração.",
  steps: [],
  checkQuestion: "",
  references: [],
  suggestedAction: "continue",
  error: null,
};

test("first request acquires the key", async () => {
  const service =
    new IdempotencyService(
      new MemoryIdempotencyStore(),
    );

  const result =
    await service.claim(
      key,
      new Date(
        "2026-08-26T12:00:00Z",
      ),
    );

  assert.equal(
    result.status,
    "acquired",
  );
});

test("concurrent duplicate stays processing", async () => {
  const service =
    new IdempotencyService(
      new MemoryIdempotencyStore(),
    );

  const now =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  const first =
    await service.claim(
      key,
      now,
    );

  assert.equal(
    first.status,
    "acquired",
  );

  const second =
    await service.claim(
      key,
      now,
    );

  assert.deepEqual(
    second,
    {
      status: "processing",
    },
  );
});

test("completed duplicate returns previous response", async () => {
  const service =
    new IdempotencyService(
      new MemoryIdempotencyStore(),
    );

  const now =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  const first =
    await service.claim(
      key,
      now,
    );

  assert.equal(
    first.status,
    "acquired",
  );

  if (
    first.status !==
    "acquired"
  ) {
    return;
  }

  await service.complete(
    first.claim,
    successResponse,
    now,
  );

  const repeated =
    await service.claim(
      key,
      new Date(
        now.getTime() + 1000,
      ),
    );

  assert.equal(
    repeated.status,
    "completed",
  );

  if (
    repeated.status ===
    "completed"
  ) {
    assert.deepEqual(
      repeated.response,
      successResponse,
    );
  }
});

test("same request id for another uid is independent", async () => {
  const service =
    new IdempotencyService(
      new MemoryIdempotencyStore(),
    );

  const now =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  const first =
    await service.claim(
      key,
      now,
    );

  assert.equal(
    first.status,
    "acquired",
  );

  const otherUser =
    await service.claim(
      {
        uid: "uid_b",
        clientRequestId:
          key.clientRequestId,
      },
      now,
    );

  assert.equal(
    otherUser.status,
    "acquired",
  );
});

test("expired records can be claimed again", async () => {
  const service =
    new IdempotencyService(
      new MemoryIdempotencyStore(),
    );

  const now =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  const first =
    await service.claim(
      key,
      now,
    );

  assert.equal(
    first.status,
    "acquired",
  );

  const afterExpiry =
    await service.claim(
      key,
      new Date(
        now.getTime() +
        IDEMPOTENCY_TTL_MS,
      ),
    );

  assert.equal(
    afterExpiry.status,
    "acquired",
  );

  if (
    first.status === "acquired" &&
    afterExpiry.status ===
    "acquired"
  ) {
    assert.notEqual(
      first.claim.claimToken,
      afterExpiry.claim.claimToken,
    );
  }
});

test("wrong claim token cannot complete a request", async () => {
  const store =
    new MemoryIdempotencyStore();

  const service =
    new IdempotencyService(store);

  const now =
    new Date(
      "2026-08-26T12:00:00Z",
    );

  const first =
    await service.claim(
      key,
      now,
    );

  assert.equal(
    first.status,
    "acquired",
  );

  if (
    first.status !==
    "acquired"
  ) {
    return;
  }

  await assert.rejects(
    () =>
      service.complete(
        {
          ...first.claim,
          claimToken:
            "invalid-token",
        },
        successResponse,
        now,
      ),
    /Invalid claim/,
  );
});

test("idempotency lifetime is exactly 24 hours", () => {
  assert.equal(
    IDEMPOTENCY_TTL_MS,
    24 * 60 * 60 * 1000,
  );
});
