import assert from "node:assert/strict";
import test from "node:test";

import {
  HttpsError,
} from "firebase-functions/v2/https";

import {
  AccountDeletionExecutor,
  createTutorOwnerHash,
  handleDeleteAccount,
} from "./accountDeletion";

class FakeDeletionExecutor
implements AccountDeletionExecutor {
  deletedUids: string[] = [];
  shouldFail = false;

  async delete(
    uid: string,
  ): Promise<void> {
    if (this.shouldFail) {
      throw new Error(
        "simulated failure",
      );
    }

    this.deletedUids.push(uid);
  }
}

test("rejects unauthenticated account deletion", async () => {
  const executor =
    new FakeDeletionExecutor();

  await assert.rejects(
    () =>
      handleDeleteAccount(
        {
          authUid: null,
          data: {},
        },
        executor,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof HttpsError,
      );
      assert.equal(
        error.code,
        "unauthenticated",
      );
      return true;
    },
  );

  assert.deepEqual(
    executor.deletedUids,
    [],
  );
});

test("rejects client-controlled account fields", async () => {
  const executor =
    new FakeDeletionExecutor();

  await assert.rejects(
    () =>
      handleDeleteAccount(
        {
          authUid: "uid_a",
          data: {
            uid: "uid_b",
          },
        },
        executor,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof HttpsError,
      );
      assert.equal(
        error.code,
        "invalid-argument",
      );
      return true;
    },
  );
});

test("deletes only the authenticated account", async () => {
  const executor =
    new FakeDeletionExecutor();

  const result =
    await handleDeleteAccount(
      {
        authUid: "uid_a",
        data: {},
      },
      executor,
    );

  assert.deepEqual(
    result,
    {
      status: "ok",
    },
  );

  assert.deepEqual(
    executor.deletedUids,
    ["uid_a"],
  );
});

test("maps internal deletion failures to a generic error", async () => {
  const executor =
    new FakeDeletionExecutor();

  executor.shouldFail = true;

  await assert.rejects(
    () =>
      handleDeleteAccount(
        {
          authUid: "uid_a",
          data: null,
        },
        executor,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof HttpsError,
      );
      assert.equal(
        error.code,
        "internal",
      );
      assert.equal(
        error.message,
        "Não foi possível excluir a conta. Tente novamente.",
      );
      return true;
    },
  );
});

test("owner hash is stable without exposing the uid", () => {
  const first =
    createTutorOwnerHash(
      "uid_a",
    );
  const second =
    createTutorOwnerHash(
      "uid_a",
    );

  assert.equal(
    first,
    second,
  );
  assert.equal(
    first.length,
    64,
  );
  assert.equal(
    first.includes("uid_a"),
    false,
  );
});
