import assert from "node:assert/strict";
import test from "node:test";

import {
  HttpsError,
} from "firebase-functions/v2/https";

import {
  TutorBackendResponse,
  TutorRequest,
} from "../contracts/types";
import {
  TutorOrchestratorError,
} from "./TutorOrchestrator";
import {
  TutorExecutor,
  handleTutorCallable,
} from "./tutorCallableHandler";

const validRequest = {
  schemaVersion: "1.0",
  clientRequestId:
    "550e8400-e29b-41d4-a716-446655440000",
  actionType: "request_hint",
  lessonId:
    "limites_indeterminacao_01",
  questionId: "q014",
} as const;

const response:
TutorBackendResponse = {
  schemaVersion: "1.0",
  status: "ok",
  interactionId: "int_test",
  tutorSessionId: "sess_test",
  contentFormat: "plain_text",
  responseType: "hint",
  title: "Pista",
  message:
    "Observe a fatoração.",
  steps: [],
  checkQuestion: "",
  references: [],
  suggestedAction: "continue",
  error: null,
};

/**
 * Creates one fake tutor executor.
 *
 * @param {Function} implementation Execute implementation.
 * @return {TutorExecutor} Fake executor.
 */
function createExecutor(
  implementation: (
    uid: string,
    request: TutorRequest,
  ) => Promise<TutorBackendResponse>,
): TutorExecutor {
  return {
    execute:
      implementation,
  };
}

test("rejects unauthenticated callable requests", async () => {
  const executor =
    createExecutor(async () =>
      response,
    );

  await assert.rejects(
    () =>
      handleTutorCallable(
        {
          auth: null,
          data: validRequest,
        },
        executor,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof
          HttpsError,
      );

      assert.equal(
        error.code,
        "unauthenticated",
      );

      return true;
    },
  );
});

test("rejects invalid callable payloads", async () => {
  const executor =
    createExecutor(async () =>
      response,
    );

  await assert.rejects(
    () =>
      handleTutorCallable(
        {
          auth: {
            uid: "uid_a",
          },
          data: {
            ...validRequest,
            unexpected:
              "client data",
          },
        },
        executor,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof
          HttpsError,
      );

      assert.equal(
        error.code,
        "invalid-argument",
      );

      return true;
    },
  );
});

test("invalid payload never reaches the tutor executor", async () => {
  let executeCalls = 0;

  const executor =
    createExecutor(async () => {
      executeCalls += 1;

      throw new Error(
        "executor must not run",
      );
    });

  await assert.rejects(
    () =>
      handleTutorCallable(
        {
          auth: {
            uid: "uid_a",
          },
          data: {
            ...validRequest,
            unexpected:
              "client data",
          },
        },
        executor,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof
          HttpsError,
      );

      assert.equal(
        error.code,
        "invalid-argument",
      );

      return true;
    },
  );

  assert.equal(
    executeCalls,
    0,
  );
});

test("uses authenticated uid instead of client identity", async () => {
  let receivedUid = "";

  const executor =
    createExecutor(
      async (
        uid: string,
      ) => {
        receivedUid = uid;

        return response;
      },
    );

  const result =
    await handleTutorCallable(
      {
        auth: {
          uid: "uid_server",
        },
        data: validRequest,
      },
      executor,
    );

  assert.equal(
    receivedUid,
    "uid_server",
  );

  assert.deepEqual(
    result,
    response,
  );
});

test("maps rate limiting to resource-exhausted", async () => {
  const executor =
    createExecutor(async () => {
      throw new TutorOrchestratorError(
        "RATE_LIMITED",
        5000,
      );
    });

  await assert.rejects(
    () =>
      handleTutorCallable(
        {
          auth: {
            uid: "uid_a",
          },
          data: validRequest,
        },
        executor,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof
          HttpsError,
      );

      assert.equal(
        error.code,
        "resource-exhausted",
      );

      assert.deepEqual(
        error.details,
        {
          retryAfterMs: 5000,
        },
      );

      return true;
    },
  );
});

test("unknown internal errors stay generic", async () => {
  const executor =
    createExecutor(async () => {
      throw new Error(
        "provider-secret-detail",
      );
    });

  await assert.rejects(
    () =>
      handleTutorCallable(
        {
          auth: {
            uid: "uid_a",
          },
          data: validRequest,
        },
        executor,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof
          HttpsError,
      );

      assert.equal(
        error.code,
        "internal",
      );

      assert.equal(
        error.message.includes(
          "provider-secret-detail",
        ),
        false,
      );

      return true;
    },
  );
});
