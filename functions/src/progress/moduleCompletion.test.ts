import assert from "node:assert/strict";
import test, {
  after,
  before,
  beforeEach,
} from "node:test";

import {
  applicationDefault,
  getApps,
  initializeApp,
} from "firebase-admin/app";

import {
  Firestore,
  getFirestore,
} from "firebase-admin/firestore";

import {
  ModuleCompletionService,
} from "./moduleCompletion";

const TEST_PROJECT_ID =
  "calculo-trivial-security-test";

let firestore: Firestore;
let service: ModuleCompletionService;

/**
 * Fails closed if somebody tries to run these tests
 * without the local Firestore Emulator.
 *
 * @return {void}
 */
function requireFirestoreEmulator(): void {
  const emulatorHost =
    process.env.FIRESTORE_EMULATOR_HOST;

  if (
    typeof emulatorHost !== "string" ||
    emulatorHost.trim().length === 0
  ) {
    throw new Error(
      "FIRESTORE_EMULATOR_HOST is required. " +
      "Refusing to run against a real Firestore project.",
    );
  }
}

/**
 * Clears all emulator documents between tests.
 *
 * @return {Promise<void>} Completion.
 */
async function clearFirestore(): Promise<void> {
  const emulatorHost =
    process.env.FIRESTORE_EMULATOR_HOST;

  if (!emulatorHost) {
    throw new Error(
      "Firestore Emulator is required.",
    );
  }

  const response =
    await fetch(
      `http://${emulatorHost}/emulator/v1/projects/` +
      `${TEST_PROJECT_ID}/databases/(default)/documents`,
      {
        method: "DELETE",
      },
    );

  if (!response.ok) {
    throw new Error(
      `Failed to clear Firestore Emulator: ${response.status}`,
    );
  }
}

/**
 * Reads the trusted progress document.
 *
 * @param {string} uid User identifier.
 * @return {Promise<Record<string, unknown>>} Stored progress.
 */
async function readProgress(
  uid: string,
): Promise<Record<string, unknown>> {
  const snapshot =
    await firestore
      .collection("users")
      .doc(uid)
      .collection("progress")
      .doc("current")
      .get();

  assert.equal(
    snapshot.exists,
    true,
  );

  return snapshot.data() ?? {};
}

before(async () => {
  requireFirestoreEmulator();

  if (getApps().length === 0) {
    initializeApp({
      credential:
        applicationDefault(),
      projectId:
        TEST_PROJECT_ID,
    });
  }

  firestore =
    getFirestore();

  service =
    new ModuleCompletionService(
      firestore,
    );

  await clearFirestore();
});

beforeEach(async () => {
  await clearFirestore();
});

after(async () => {
  if (
    process.env.FIRESTORE_EMULATOR_HOST
  ) {
    await clearFirestore();
  }
});

test(
  "first verified Algebra pass awards canonical reward",
  async () => {
    const result =
      await service.awardAfterVerifiedPass(
        "uid_a",
        "algebra-fundamental",
        "550e8400-e29b-41d4-a716-446655440000",
      );

    assert.deepEqual(
      result,
      {
        moduleId:
          "algebra-fundamental",
        alreadyCompleted: false,
        xpAwarded: 60,
        goldAwarded: 25,
      },
    );

    const progress =
      await readProgress(
        "uid_a",
      );

    assert.deepEqual(
      progress.completedLessonIds,
      ["algebra-fundamental"],
    );

    assert.equal(
      progress.totalXp,
      60,
    );

    assert.equal(
      progress.totalGold,
      25,
    );

    assert.equal(
      progress
        .algebraFundamentalCompleted,
      true,
    );
  },
);

test(
  "replaying the same trusted session never duplicates reward",
  async () => {
    const requestId =
      "550e8400-e29b-41d4-a716-446655440001";

    const first =
      await service.awardAfterVerifiedPass(
        "uid_a",
        "algebra-fundamental",
        requestId,
      );

    const repeated =
      await service.awardAfterVerifiedPass(
        "uid_a",
        "algebra-fundamental",
        requestId,
      );

    assert.equal(
      first.xpAwarded,
      60,
    );

    assert.equal(
      first.goldAwarded,
      25,
    );

    assert.deepEqual(
      repeated,
      {
        moduleId:
          "algebra-fundamental",
        alreadyCompleted: true,
        xpAwarded: 0,
        goldAwarded: 0,
      },
    );

    const progress =
      await readProgress(
        "uid_a",
      );

    assert.equal(
      progress.totalXp,
      60,
    );

    assert.equal(
      progress.totalGold,
      25,
    );

    assert.deepEqual(
      progress.completedLessonIds,
      ["algebra-fundamental"],
    );
  },
);

test(
  "a completed module cannot be rewarded again with another session",
  async () => {
    await service.awardAfterVerifiedPass(
      "uid_a",
      "algebra-fundamental",
      "550e8400-e29b-41d4-a716-446655440002",
    );

    const repeated =
      await service.awardAfterVerifiedPass(
        "uid_a",
        "algebra-fundamental",
        "550e8400-e29b-41d4-a716-446655440003",
      );

    assert.deepEqual(
      repeated,
      {
        moduleId:
          "algebra-fundamental",
        alreadyCompleted: true,
        xpAwarded: 0,
        goldAwarded: 0,
      },
    );

    const progress =
      await readProgress(
        "uid_a",
      );

    assert.equal(
      progress.totalXp,
      60,
    );

    assert.equal(
      progress.totalGold,
      25,
    );
  },
);

test(
  "trusted request id cannot be reused for another module",
  async () => {
    const requestId =
      "550e8400-e29b-41d4-a716-446655440004";

    await service.awardAfterVerifiedPass(
      "uid_a",
      "algebra-fundamental",
      requestId,
    );

    await assert.rejects(
      () =>
        service.awardAfterVerifiedPass(
          "uid_a",
          "equacoes-inequacoes",
          requestId,
        ),
      /Trusted request already used/,
    );

    const progress =
      await readProgress(
        "uid_a",
      );

    assert.equal(
      progress.totalXp,
      60,
    );

    assert.equal(
      progress.totalGold,
      25,
    );

    assert.deepEqual(
      progress.completedLessonIds,
      ["algebra-fundamental"],
    );
  },
);

test(
  "different users have independent trusted rewards",
  async () => {
    const requestId =
      "550e8400-e29b-41d4-a716-446655440005";

    const userA =
      await service.awardAfterVerifiedPass(
        "uid_a",
        "algebra-fundamental",
        requestId,
      );

    const userB =
      await service.awardAfterVerifiedPass(
        "uid_b",
        "algebra-fundamental",
        requestId,
      );

    assert.equal(
      userA.xpAwarded,
      60,
    );

    assert.equal(
      userB.xpAwarded,
      60,
    );

    const progressA =
      await readProgress(
        "uid_a",
      );

    const progressB =
      await readProgress(
        "uid_b",
      );

    assert.equal(
      progressA.totalXp,
      60,
    );

    assert.equal(
      progressB.totalXp,
      60,
    );
  },
);

test(
  "canonical totals ignore forged existing XP and gold",
  async () => {
    await firestore
      .collection("users")
      .doc("uid_a")
      .collection("progress")
      .doc("current")
      .set({
        completedLessonIds: [],
        totalXp: 999999,
        totalGold: 999999,
      });

    const result =
      await service.awardAfterVerifiedPass(
        "uid_a",
        "algebra-fundamental",
        "550e8400-e29b-41d4-a716-446655440006",
      );

    assert.equal(
      result.xpAwarded,
      60,
    );

    assert.equal(
      result.goldAwarded,
      25,
    );

    const progress =
      await readProgress(
        "uid_a",
      );

    assert.equal(
      progress.totalXp,
      60,
    );

    assert.equal(
      progress.totalGold,
      25,
    );
  },
);
