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
  Timestamp,
  getFirestore,
} from "firebase-admin/firestore";

import {
  getAlgebraFinalTestQuestion,
} from "./algebraFinalTestCatalog";

import {
  getEquationsFinalTestQuestion,
} from "./equationsFinalTestCatalog";
import {
  getFunctionsFinalTestQuestion,
} from "./functionsFinalTestCatalog";
import {
  getLimitsFinalTestQuestion,
} from "./limitsFinalTestCatalog";
import {
  getContinuityFinalTestQuestion,
} from "./continuityFinalTestCatalog";

import {
  FinalTestSessionResult,
  FinalTestSessionService,
} from "./finalTestSession";

import {
  FinalTestAnswer,
  FinalTestSubmissionService,
} from "./finalTestSubmission";

import {
  ModuleCompletionService,
} from "../progress/moduleCompletion";

const TEST_PROJECT_ID =
  "calculo-trivial-security-test";

let firestore: Firestore;
let sessionService: FinalTestSessionService;
let submissionService: FinalTestSubmissionService;

/**
 * Refuses to run without the local Firestore Emulator.
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
 * Creates trusted answers with an exact number correct.
 *
 * This helper reads the answer key directly from the backend catalog
 * because the test executes inside the trusted Functions environment.
 *
 * @param {FinalTestSessionResult} session Trusted test session.
 * @param {number} correctCount Number of answers that should be correct.
 * @return {FinalTestAnswer[]} Generated answers.
 */
function buildAnswers(
  session: FinalTestSessionResult,
  correctCount: number,
): FinalTestAnswer[] {
  if (
    !Number.isInteger(correctCount) ||
    correctCount < 0 ||
    correctCount > session.questions.length
  ) {
    throw new Error(
      "Invalid requested correct-answer count.",
    );
  }

  return session.questions.map(
    (publicQuestion, index) => {
      const trustedQuestion =
        getAlgebraFinalTestQuestion(
          publicQuestion.id,
        );

      if (!trustedQuestion) {
        throw new Error(
          "Trusted test question not found.",
        );
      }

      if (index < correctCount) {
        return {
          questionId:
            publicQuestion.id,
          optionId:
            trustedQuestion.correctOptionId,
        };
      }

      const wrongOption =
        trustedQuestion.options.find(
          (option) =>
            option.id !==
            trustedQuestion.correctOptionId,
        );

      if (!wrongOption) {
        throw new Error(
          "Question has no wrong option for testing.",
        );
      }

      return {
        questionId:
          publicQuestion.id,
        optionId:
          wrongOption.id,
      };
    },
  );
}

/**
 * Creates trusted Equations answers with an exact number correct.
 *
 * This helper reads the answer key only inside the trusted test
 * environment.
 *
 * @param {FinalTestSessionResult} session Trusted test session.
 * @param {number} correctCount Number of correct answers.
 * @return {FinalTestAnswer[]} Generated answers.
 */
function buildEquationsAnswers(
  session: FinalTestSessionResult,
  correctCount: number,
): FinalTestAnswer[] {
  if (
    !Number.isInteger(correctCount) ||
    correctCount < 0 ||
    correctCount > session.questions.length
  ) {
    throw new Error(
      "Invalid requested correct-answer count.",
    );
  }

  return session.questions.map(
    (publicQuestion, index) => {
      const trustedQuestion =
        getEquationsFinalTestQuestion(
          publicQuestion.id,
        );

      if (!trustedQuestion) {
        throw new Error(
          "Trusted Equations test question not found.",
        );
      }

      if (index < correctCount) {
        return {
          questionId:
            publicQuestion.id,
          optionId:
            trustedQuestion.correctOptionId,
        };
      }

      const wrongOption =
        trustedQuestion.options.find(
          (option) =>
            option.id !==
            trustedQuestion.correctOptionId,
        );

      if (!wrongOption) {
        throw new Error(
          "Question has no wrong option for testing.",
        );
      }

      return {
        questionId:
          publicQuestion.id,
        optionId:
          wrongOption.id,
      };
    },
  );
}

/**
 * Creates trusted Equations answers with an exact number correct.
 *
 * This helper reads the answer key only inside the trusted test
 * environment.
 *
 * @param {FinalTestSessionResult} session Trusted test session.
 * @param {number} correctCount Number of correct answers.
 * @return {FinalTestAnswer[]} Generated answers.
 */
function buildFunctionsAnswers(
  session: FinalTestSessionResult,
  correctCount: number,
): FinalTestAnswer[] {
  if (
    !Number.isInteger(correctCount) ||
    correctCount < 0 ||
    correctCount > session.questions.length
  ) {
    throw new Error(
      "Invalid requested correct-answer count.",
    );
  }

  return session.questions.map(
    (publicQuestion, index) => {
      const trustedQuestion =
        getFunctionsFinalTestQuestion(
          publicQuestion.id,
        );

      if (!trustedQuestion) {
        throw new Error(
          "Trusted Functions test question not found.",
        );
      }

      if (index < correctCount) {
        return {
          questionId:
            publicQuestion.id,
          optionId:
            trustedQuestion.correctOptionId,
        };
      }

      const wrongOption =
        trustedQuestion.options.find(
          (option) =>
            option.id !==
            trustedQuestion.correctOptionId,
        );

      if (!wrongOption) {
        throw new Error(
          "Question has no wrong option for testing.",
        );
      }

      return {
        questionId:
          publicQuestion.id,
        optionId:
          wrongOption.id,
      };
    },
  );
}

/**
 * Reads trusted progress when it exists.
 *
 * @param {string} uid User identifier.
 * @return {Promise<Record<string, unknown> | null>} Progress data.
 */
async function readProgress(
  uid: string,
): Promise<Record<string, unknown> | null> {
  const snapshot =
    await firestore
      .collection("users")
      .doc(uid)
      .collection("progress")
      .doc("current")
      .get();

  if (!snapshot.exists) {
    return null;
  }

  return snapshot.data() ?? {};
}

/**
 * Reads one stored final-test session.
 *
 * @param {string} uid User identifier.
 * @param {string} sessionId Session identifier.
 * @return {Promise<Record<string, unknown>>} Stored session.
 */
async function readStoredSession(
  uid: string,
  sessionId: string,
): Promise<Record<string, unknown>> {
  const snapshot =
    await firestore
      .collection("users")
      .doc(uid)
      .collection("final_test_sessions")
      .doc(sessionId)
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

  const completionService =
    new ModuleCompletionService(
      firestore,
    );

  sessionService =
    new FinalTestSessionService(
      firestore,
    );

  submissionService =
    new FinalTestSubmissionService(
      firestore,
      completionService,
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

/**
 * Builds trusted Continuity answers for integration tests.
 *
 * @param {FinalTestSessionResult} session Trusted test session.
 * @param {number} correctCount Number of correct answers.
 * @return {FinalTestAnswer[]} Generated answers.
 */
function buildContinuityAnswers(
  session: FinalTestSessionResult,
  correctCount: number,
): FinalTestAnswer[] {
  if (
    !Number.isInteger(correctCount) ||
    correctCount < 0 ||
    correctCount > session.questions.length
  ) {
    throw new Error(
      "Invalid Continuity correct-answer count.",
    );
  }

  return session.questions.map(
    (publicQuestion, index) => {
      const trustedQuestion =
        getContinuityFinalTestQuestion(
          publicQuestion.id,
        );

      if (!trustedQuestion) {
        throw new Error(
          "Trusted Continuity test question not found.",
        );
      }

      if (index < correctCount) {
        return {
          questionId: publicQuestion.id,
          optionId: trustedQuestion.correctOptionId,
        };
      }

      const wrongOption =
        trustedQuestion.options.find(
          (option) =>
            option.id !==
            trustedQuestion.correctOptionId,
        );

      if (!wrongOption) {
        throw new Error(
          "Continuity question has no wrong option.",
        );
      }

      return {
        questionId: publicQuestion.id,
        optionId: wrongOption.id,
      };
    },
  );
}
test(
  "started session exposes ten unique questions without answer keys",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    assert.equal(
      session.questions.length,
      10,
    );

    const questionIds =
      session.questions.map(
        (question) =>
          question.id,
      );

    assert.equal(
      new Set(questionIds).size,
      10,
    );

    for (
      const question
      of session.questions
    ) {
      assert.equal(
        "correctOptionId" in question,
        false,
      );
    }

    const stored =
      await readStoredSession(
        "uid_a",
        session.sessionId,
      );

    assert.equal(
      stored.uid,
      "uid_a",
    );

    assert.equal(
      stored.moduleId,
      "algebra-fundamental",
    );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "seven of ten is rejected and awards nothing",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    const result =
      await submissionService
        .processAlgebraFinalTest(
          "uid_a",
          session.sessionId,
          buildAnswers(
            session,
            7,
          ),
        );

    assert.equal(
      result.submission.correctAnswers,
      7,
    );

    assert.equal(
      result.submission.accuracy,
      0.7,
    );

    assert.equal(
      result.submission.approved,
      false,
    );

    assert.equal(
      result.reward,
      null,
    );

    assert.equal(
      await readProgress(
        "uid_a",
      ),
      null,
    );

    const stored =
      await readStoredSession(
        "uid_a",
        session.sessionId,
      );

    assert.equal(
      stored.consumed,
      true,
    );

    assert.equal(
      stored.approved,
      false,
    );

    assert.equal(
      stored.rewardApplied,
      false,
    );
  },
);

test(
  "eight of ten is approved and awards canonical Algebra reward",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    const result =
      await submissionService
        .processAlgebraFinalTest(
          "uid_a",
          session.sessionId,
          buildAnswers(
            session,
            8,
          ),
        );

    assert.equal(
      result.submission.correctAnswers,
      8,
    );

    assert.equal(
      result.submission.accuracy,
      0.8,
    );

    assert.equal(
      result.submission.approved,
      true,
    );

    assert.deepEqual(
      result.reward,
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

    assert.ok(progress);

    assert.equal(
      progress.totalXp,
      60,
    );

    assert.equal(
      progress.totalGold,
      25,
    );

    const stored =
      await readStoredSession(
        "uid_a",
        session.sessionId,
      );

    assert.equal(
      stored.rewardApplied,
      true,
    );
  },
);

test(
  "ten of ten is approved",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    const result =
      await submissionService
        .processAlgebraFinalTest(
          "uid_a",
          session.sessionId,
          buildAnswers(
            session,
            10,
          ),
        );

    assert.equal(
      result.submission.correctAnswers,
      10,
    );

    assert.equal(
      result.submission.accuracy,
      1,
    );

    assert.equal(
      result.submission.approved,
      true,
    );

    assert.ok(
      result.reward,
    );

    assert.equal(
      result.reward.xpAwarded,
      60,
    );

    assert.equal(
      result.reward.goldAwarded,
      25,
    );
  },
);

test(
  "replaying an approved session never duplicates reward",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    const answers =
      buildAnswers(
        session,
        8,
      );

    const first =
      await submissionService
        .processAlgebraFinalTest(
          "uid_a",
          session.sessionId,
          answers,
        );

    const replay =
      await submissionService
        .processAlgebraFinalTest(
          "uid_a",
          session.sessionId,
          answers,
        );

    assert.equal(
      first.submission.alreadySubmitted,
      false,
    );

    assert.equal(
      replay.submission.alreadySubmitted,
      true,
    );

    assert.ok(
      replay.reward,
    );

    assert.equal(
      replay.reward.alreadyCompleted,
      true,
    );

    assert.equal(
      replay.reward.xpAwarded,
      0,
    );

    assert.equal(
      replay.reward.goldAwarded,
      0,
    );

    const progress =
      await readProgress(
        "uid_a",
      );

    assert.ok(progress);

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
  "another user cannot submit a session owned by someone else",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    await assert.rejects(
      () =>
        submissionService
          .processAlgebraFinalTest(
            "uid_b",
            session.sessionId,
            buildAnswers(
              session,
              10,
            ),
          ),
      /Final-test session not found/,
    );

    assert.equal(
      await readProgress(
        "uid_b",
      ),
      null,
    );

    const stored =
      await readStoredSession(
        "uid_a",
        session.sessionId,
      );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "expired session is rejected without reward",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    const sessionRef =
      firestore
        .collection("users")
        .doc("uid_a")
        .collection(
          "final_test_sessions",
        )
        .doc(session.sessionId);

    await sessionRef.update({
      expiresAt:
        Timestamp.fromMillis(
          Date.now() - 60_000,
        ),
    });

    await assert.rejects(
      () =>
        submissionService
          .processAlgebraFinalTest(
            "uid_a",
            session.sessionId,
            buildAnswers(
              session,
              10,
            ),
          ),
      /Final-test session expired/,
    );

    assert.equal(
      await readProgress(
        "uid_a",
      ),
      null,
    );
  },
);

test(
  "invalid session id is rejected before Firestore lookup",
  async () => {
    await assert.rejects(
      () =>
        submissionService
          .processAlgebraFinalTest(
            "uid_a",
            "client-forged-session",
            [],
          ),
      /Invalid final-test session ID/,
    );

    assert.equal(
      await readProgress(
        "uid_a",
      ),
      null,
    );
  },
);

test(
  "invalid option is rejected without consuming the session",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    const answers =
      buildAnswers(
        session,
        10,
      );

    answers[0] = {
      questionId:
        answers[0].questionId,
      optionId:
        "forged-option",
    };

    await assert.rejects(
      () =>
        submissionService
          .processAlgebraFinalTest(
            "uid_a",
            session.sessionId,
            answers,
          ),
      /Invalid final-test option/,
    );

    assert.equal(
      await readProgress(
        "uid_a",
      ),
      null,
    );

    const stored =
      await readStoredSession(
        "uid_a",
        session.sessionId,
      );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "duplicate answer is rejected without reward",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    const answers =
      buildAnswers(
        session,
        10,
      );

    answers[1] = {
      questionId:
        answers[0].questionId,
      optionId:
        answers[0].optionId,
    };

    await assert.rejects(
      () =>
        submissionService
          .processAlgebraFinalTest(
            "uid_a",
            session.sessionId,
            answers,
          ),
      /Duplicate final-test answer/,
    );

    assert.equal(
      await readProgress(
        "uid_a",
      ),
      null,
    );
  },
);

test(
  "tampered trusted question id is rejected without reward",
  async () => {
    const session =
      await sessionService
        .startAlgebraFinalTest(
          "uid_a",
        );

    const sessionRef =
      firestore
        .collection("users")
        .doc("uid_a")
        .collection(
          "final_test_sessions",
        )
        .doc(session.sessionId);

    const stored =
      await sessionRef.get();

    const data =
      stored.data();

    assert.ok(data);

    const questionIds =
      [...data.questionIds];

    questionIds[0] =
      "server-tampered-question";

    await sessionRef.update({
      questionIds,
    });

    const answers =
      session.questions.map(
        (question) => {
          const trusted =
            getAlgebraFinalTestQuestion(
              question.id,
            );

          assert.ok(trusted);

          return {
            questionId:
              question.id,
            optionId:
              trusted.correctOptionId,
          };
        },
      );

    answers[0] = {
      questionId:
        "server-tampered-question",
      optionId:
        answers[0].optionId,
    };

    await assert.rejects(
      () =>
        submissionService
          .processAlgebraFinalTest(
            "uid_a",
            session.sessionId,
            answers,
          ),
      /Trusted question not found/,
    );

    assert.equal(
      await readProgress(
        "uid_a",
      ),
      null,
    );
  },
);
test(
  "Equations session exposes trusted questions without answer keys",
  async () => {
    const session =
      await sessionService
        .startEquationsFinalTest(
          "uid_equations",
        );

    assert.equal(
      session.moduleId,
      "equacoes-inequacoes",
    );

    assert.equal(
      session.questions.length,
      10,
    );

    assert.equal(
      new Set(
        session.questions.map(
          (question) =>
            question.id,
        ),
      ).size,
      10,
    );

    for (
      const question
      of session.questions
    ) {
      assert.equal(
        "correctOptionId" in question,
        false,
      );

      assert.ok(
        getEquationsFinalTestQuestion(
          question.id,
        ),
      );

      assert.equal(
        getAlgebraFinalTestQuestion(
          question.id,
        ),
        undefined,
      );
    }

    const stored =
      await readStoredSession(
        "uid_equations",
        session.sessionId,
      );

    assert.equal(
      stored.moduleId,
      "equacoes-inequacoes",
    );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "seven of ten Equations answers awards nothing",
  async () => {
    const session =
      await sessionService
        .startEquationsFinalTest(
          "uid_equations",
        );

    const result =
      await submissionService
        .processEquationsFinalTest(
          "uid_equations",
          session.sessionId,
          buildEquationsAnswers(
            session,
            7,
          ),
        );

    assert.equal(
      result.submission.correctAnswers,
      7,
    );

    assert.equal(
      result.submission.accuracy,
      0.7,
    );

    assert.equal(
      result.submission.approved,
      false,
    );

    assert.equal(
      result.reward,
      null,
    );

    assert.equal(
      await readProgress(
        "uid_equations",
      ),
      null,
    );
  },
);

test(
  "eight of ten Equations answers awards canonical reward",
  async () => {
    const session =
      await sessionService
        .startEquationsFinalTest(
          "uid_equations",
        );

    const result =
      await submissionService
        .processEquationsFinalTest(
          "uid_equations",
          session.sessionId,
          buildEquationsAnswers(
            session,
            8,
          ),
        );

    assert.equal(
      result.submission.moduleId,
      "equacoes-inequacoes",
    );

    assert.equal(
      result.submission.correctAnswers,
      8,
    );

    assert.equal(
      result.submission.accuracy,
      0.8,
    );

    assert.equal(
      result.submission.approved,
      true,
    );

    assert.deepEqual(
      result.reward,
      {
        moduleId:
          "equacoes-inequacoes",
        alreadyCompleted: false,
        xpAwarded: 70,
        goldAwarded: 30,
      },
    );

    const progress =
      await readProgress(
        "uid_equations",
      );

    assert.ok(progress);

    assert.equal(
      progress.totalXp,
      70,
    );

    assert.equal(
      progress.totalGold,
      30,
    );

    const stored =
      await readStoredSession(
        "uid_equations",
        session.sessionId,
      );

    assert.equal(
      stored.rewardApplied,
      true,
    );
  },
);

test(
  "Equations session cannot be processed through Algebra path",
  async () => {
    const session =
      await sessionService
        .startEquationsFinalTest(
          "uid_equations",
        );

    await assert.rejects(
      () =>
        submissionService
          .processAlgebraFinalTest(
            "uid_equations",
            session.sessionId,
            buildEquationsAnswers(
              session,
              10,
            ),
          ),
      /Invalid final-test module/,
    );

    assert.equal(
      await readProgress(
        "uid_equations",
      ),
      null,
    );

    const stored =
      await readStoredSession(
        "uid_equations",
        session.sessionId,
      );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "invalid Equations option is rejected without consuming session",
  async () => {
    const session =
      await sessionService
        .startEquationsFinalTest(
          "uid_equations",
        );

    const answers =
      buildEquationsAnswers(
        session,
        10,
      );

    answers[0] = {
      questionId:
        answers[0].questionId,
      optionId:
        "forged-option",
    };

    await assert.rejects(
      () =>
        submissionService
          .processEquationsFinalTest(
            "uid_equations",
            session.sessionId,
            answers,
          ),
      /Invalid final-test option/,
    );

    assert.equal(
      await readProgress(
        "uid_equations",
      ),
      null,
    );

    const stored =
      await readStoredSession(
        "uid_equations",
        session.sessionId,
      );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "replaying approved Equations session never duplicates reward",
  async () => {
    const session =
      await sessionService
        .startEquationsFinalTest(
          "uid_equations",
        );

    const answers =
      buildEquationsAnswers(
        session,
        8,
      );

    const first =
      await submissionService
        .processEquationsFinalTest(
          "uid_equations",
          session.sessionId,
          answers,
        );

    const replay =
      await submissionService
        .processEquationsFinalTest(
          "uid_equations",
          session.sessionId,
          answers,
        );

    assert.equal(
      first.submission.alreadySubmitted,
      false,
    );

    assert.equal(
      replay.submission.alreadySubmitted,
      true,
    );

    assert.ok(
      replay.reward,
    );

    assert.equal(
      replay.reward.alreadyCompleted,
      true,
    );

    assert.equal(
      replay.reward.xpAwarded,
      0,
    );

    assert.equal(
      replay.reward.goldAwarded,
      0,
    );

    const progress =
      await readProgress(
        "uid_equations",
      );

    assert.ok(progress);

    assert.equal(
      progress.totalXp,
      70,
    );

    assert.equal(
      progress.totalGold,
      30,
    );
  },
);
/**
 * Builds trusted Limits answers for integration tests.
 *
 * @param {FinalTestSessionResult} session Trusted test session.
 * @param {number} correctCount Number of correct answers.
 * @return {FinalTestAnswer[]} Generated answers.
 */
function buildLimitsAnswers(
  session: FinalTestSessionResult,
  correctCount: number,
): FinalTestAnswer[] {
  if (
    !Number.isInteger(correctCount) ||
    correctCount < 0 ||
    correctCount > session.questions.length
  ) {
    throw new Error(
      "Invalid Limits correct-answer count.",
    );
  }

  return session.questions.map(
    (publicQuestion, index) => {
      const trustedQuestion =
        getLimitsFinalTestQuestion(
          publicQuestion.id,
        );

      if (!trustedQuestion) {
        throw new Error(
          "Trusted Limits test question not found.",
        );
      }

      if (index < correctCount) {
        return {
          questionId: publicQuestion.id,
          optionId: trustedQuestion.correctOptionId,
        };
      }

      const wrongOption =
        trustedQuestion.options.find(
          (option) =>
            option.id !==
            trustedQuestion.correctOptionId,
        );

      if (!wrongOption) {
        throw new Error(
          "Limits question has no wrong option.",
        );
      }

      return {
        questionId: publicQuestion.id,
        optionId: wrongOption.id,
      };
    },
  );
}
test(
  "Functions session exposes trusted questions without answer keys",
  async () => {
    const session =
      await sessionService
        .startFunctionsFinalTest(
          "uid_functions",
        );

    assert.equal(
      session.moduleId,
      "funcoes",
    );

    assert.equal(
      session.questions.length,
      10,
    );

    assert.equal(
      new Set(
        session.questions.map(
          (question) =>
            question.id,
        ),
      ).size,
      10,
    );

    for (
      const question
      of session.questions
    ) {
      assert.equal(
        "correctOptionId" in question,
        false,
      );

      assert.ok(
        getFunctionsFinalTestQuestion(
          question.id,
        ),
      );

      assert.equal(
        getAlgebraFinalTestQuestion(
          question.id,
        ),
        undefined,
      );
    }

    const stored =
      await readStoredSession(
        "uid_functions",
        session.sessionId,
      );

    assert.equal(
      stored.moduleId,
      "funcoes",
    );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "seven of ten Functions answers awards nothing",
  async () => {
    const session =
      await sessionService
        .startFunctionsFinalTest(
          "uid_functions",
        );

    const result =
      await submissionService
        .processFunctionsFinalTest(
          "uid_functions",
          session.sessionId,
          buildFunctionsAnswers(
            session,
            7,
          ),
        );

    assert.equal(
      result.submission.correctAnswers,
      7,
    );

    assert.equal(
      result.submission.accuracy,
      0.7,
    );

    assert.equal(
      result.submission.approved,
      false,
    );

    assert.equal(
      result.reward,
      null,
    );

    assert.equal(
      await readProgress(
        "uid_functions",
      ),
      null,
    );
  },
);

test(
  "eight of ten Functions answers awards canonical reward",
  async () => {
    const session =
      await sessionService
        .startFunctionsFinalTest(
          "uid_functions",
        );

    const result =
      await submissionService
        .processFunctionsFinalTest(
          "uid_functions",
          session.sessionId,
          buildFunctionsAnswers(
            session,
            8,
          ),
        );

    assert.equal(
      result.submission.moduleId,
      "funcoes",
    );

    assert.equal(
      result.submission.correctAnswers,
      8,
    );

    assert.equal(
      result.submission.accuracy,
      0.8,
    );

    assert.equal(
      result.submission.approved,
      true,
    );

    assert.deepEqual(
      result.reward,
      {
        moduleId:
          "funcoes",
        alreadyCompleted: false,
        xpAwarded: 80,
        goldAwarded: 35,
      },
    );

    const progress =
      await readProgress(
        "uid_functions",
      );

    assert.ok(progress);

    assert.equal(
      progress.totalXp,
      80,
    );

    assert.equal(
      progress.totalGold,
      35,
    );

    const stored =
      await readStoredSession(
        "uid_functions",
        session.sessionId,
      );

    assert.equal(
      stored.rewardApplied,
      true,
    );
  },
);

test(
  "Functions session cannot be processed through Algebra path",
  async () => {
    const session =
      await sessionService
        .startFunctionsFinalTest(
          "uid_functions",
        );

    await assert.rejects(
      () =>
        submissionService
          .processAlgebraFinalTest(
            "uid_functions",
            session.sessionId,
            buildFunctionsAnswers(
              session,
              10,
            ),
          ),
      /Invalid final-test module/,
    );

    assert.equal(
      await readProgress(
        "uid_functions",
      ),
      null,
    );

    const stored =
      await readStoredSession(
        "uid_functions",
        session.sessionId,
      );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "invalid Functions option is rejected without consuming session",
  async () => {
    const session =
      await sessionService
        .startFunctionsFinalTest(
          "uid_functions",
        );

    const answers =
      buildFunctionsAnswers(
        session,
        10,
      );

    answers[0] = {
      questionId:
        answers[0].questionId,
      optionId:
        "forged-option",
    };

    await assert.rejects(
      () =>
        submissionService
          .processFunctionsFinalTest(
            "uid_functions",
            session.sessionId,
            answers,
          ),
      /Invalid final-test option/,
    );

    assert.equal(
      await readProgress(
        "uid_functions",
      ),
      null,
    );

    const stored =
      await readStoredSession(
        "uid_functions",
        session.sessionId,
      );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "replaying approved Functions session never duplicates reward",
  async () => {
    const session =
      await sessionService
        .startFunctionsFinalTest(
          "uid_functions",
        );

    const answers =
      buildFunctionsAnswers(
        session,
        8,
      );

    const first =
      await submissionService
        .processFunctionsFinalTest(
          "uid_functions",
          session.sessionId,
          answers,
        );

    const replay =
      await submissionService
        .processFunctionsFinalTest(
          "uid_functions",
          session.sessionId,
          answers,
        );

    assert.equal(
      first.submission.alreadySubmitted,
      false,
    );

    assert.equal(
      replay.submission.alreadySubmitted,
      true,
    );

    assert.ok(
      replay.reward,
    );

    assert.equal(
      replay.reward.alreadyCompleted,
      true,
    );

    assert.equal(
      replay.reward.xpAwarded,
      0,
    );

    assert.equal(
      replay.reward.goldAwarded,
      0,
    );

    const progress =
      await readProgress(
        "uid_functions",
      );

    assert.ok(progress);

    assert.equal(
      progress.totalXp,
      80,
    );

    assert.equal(
      progress.totalGold,
      35,
    );
  },
);
test(
  "Limits session exposes trusted questions without answer keys",
  async () => {
    const session =
      await sessionService
        .startLimitsFinalTest(
          "uid_limits",
        );

    assert.equal(
      session.moduleId,
      "limites",
    );

    assert.equal(
      session.questions.length,
      10,
    );

    assert.equal(
      new Set(
        session.questions.map(
          (question) =>
            question.id,
        ),
      ).size,
      10,
    );

    for (
      const question
      of session.questions
    ) {
      assert.equal(
        "correctOptionId" in question,
        false,
      );

      assert.ok(
        getLimitsFinalTestQuestion(
          question.id,
        ),
      );

      assert.equal(
        getAlgebraFinalTestQuestion(
          question.id,
        ),
        undefined,
      );
    }

    const stored =
      await readStoredSession(
        "uid_limits",
        session.sessionId,
      );

    assert.equal(
      stored.moduleId,
      "limites",
    );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "seven of ten Limits answers awards nothing",
  async () => {
    const session =
      await sessionService
        .startLimitsFinalTest(
          "uid_limits",
        );

    const result =
      await submissionService
        .processLimitsFinalTest(
          "uid_limits",
          session.sessionId,
          buildLimitsAnswers(
            session,
            7,
          ),
        );

    assert.equal(
      result.submission.correctAnswers,
      7,
    );

    assert.equal(
      result.submission.accuracy,
      0.7,
    );

    assert.equal(
      result.submission.approved,
      false,
    );

    assert.equal(
      result.reward,
      null,
    );

    assert.equal(
      await readProgress(
        "uid_limits",
      ),
      null,
    );
  },
);

test(
  "eight of ten Limits answers awards canonical reward",
  async () => {
    const session =
      await sessionService
        .startLimitsFinalTest(
          "uid_limits",
        );

    const result =
      await submissionService
        .processLimitsFinalTest(
          "uid_limits",
          session.sessionId,
          buildLimitsAnswers(
            session,
            8,
          ),
        );

    assert.equal(
      result.submission.moduleId,
      "limites",
    );

    assert.equal(
      result.submission.correctAnswers,
      8,
    );

    assert.equal(
      result.submission.accuracy,
      0.8,
    );

    assert.equal(
      result.submission.approved,
      true,
    );

    assert.deepEqual(
      result.reward,
      {
        moduleId:
          "limites",
        alreadyCompleted: false,
        xpAwarded: 90,
        goldAwarded: 40,
      },
    );

    const progress =
      await readProgress(
        "uid_limits",
      );

    assert.ok(progress);

    assert.equal(
      progress.totalXp,
      90,
    );

    assert.equal(
      progress.totalGold,
      40,
    );

    const stored =
      await readStoredSession(
        "uid_limits",
        session.sessionId,
      );

    assert.equal(
      stored.rewardApplied,
      true,
    );
  },
);

test(
  "Limits session cannot be processed through Algebra path",
  async () => {
    const session =
      await sessionService
        .startLimitsFinalTest(
          "uid_limits",
        );

    await assert.rejects(
      () =>
        submissionService
          .processAlgebraFinalTest(
            "uid_limits",
            session.sessionId,
            buildLimitsAnswers(
              session,
              10,
            ),
          ),
      /Invalid final-test module/,
    );

    assert.equal(
      await readProgress(
        "uid_limits",
      ),
      null,
    );

    const stored =
      await readStoredSession(
        "uid_limits",
        session.sessionId,
      );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "invalid Limits option is rejected without consuming session",
  async () => {
    const session =
      await sessionService
        .startLimitsFinalTest(
          "uid_limits",
        );

    const answers =
      buildLimitsAnswers(
        session,
        10,
      );

    answers[0] = {
      questionId:
        answers[0].questionId,
      optionId:
        "forged-option",
    };

    await assert.rejects(
      () =>
        submissionService
          .processLimitsFinalTest(
            "uid_limits",
            session.sessionId,
            answers,
          ),
      /Invalid final-test option/,
    );

    assert.equal(
      await readProgress(
        "uid_limits",
      ),
      null,
    );

    const stored =
      await readStoredSession(
        "uid_limits",
        session.sessionId,
      );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);

test(
  "replaying approved Limits session never duplicates reward",
  async () => {
    const session =
      await sessionService
        .startLimitsFinalTest(
          "uid_limits",
        );

    const answers =
      buildLimitsAnswers(
        session,
        8,
      );

    const first =
      await submissionService
        .processLimitsFinalTest(
          "uid_limits",
          session.sessionId,
          answers,
        );

    const replay =
      await submissionService
        .processLimitsFinalTest(
          "uid_limits",
          session.sessionId,
          answers,
        );

    assert.equal(
      first.submission.alreadySubmitted,
      false,
    );

    assert.equal(
      replay.submission.alreadySubmitted,
      true,
    );

    assert.ok(
      replay.reward,
    );

    assert.equal(
      replay.reward.alreadyCompleted,
      true,
    );

    assert.equal(
      replay.reward.xpAwarded,
      0,
    );

    assert.equal(
      replay.reward.goldAwarded,
      0,
    );

    const progress =
      await readProgress(
        "uid_limits",
      );

    assert.ok(progress);

    assert.equal(
      progress.totalXp,
      90,
    );

    assert.equal(
      progress.totalGold,
      40,
    );
  },
);
test(
  "Continuity session exposes trusted questions without answer keys",
  async () => {
    const session =
      await sessionService
        .startContinuityFinalTest(
          "uid_continuity",
        );

    assert.equal(
      session.moduleId,
      "continuidade",
    );

    assert.equal(
      session.questions.length,
      10,
    );

    for (const question of session.questions) {
      assert.equal(
        Object.prototype.hasOwnProperty.call(
          question,
          "correctOptionId",
        ),
        false,
      );

      assert.ok(
        getContinuityFinalTestQuestion(
          question.id,
        ),
      );
    }

    const stored =
      await readStoredSession(
        "uid_continuity",
        session.sessionId,
      );

    assert.equal(
      stored.moduleId,
      "continuidade",
    );

    assert.equal(
      stored.consumed,
      false,
    );
  },
);
test(
  "seven of ten Continuity answers awards nothing",
  async () => {
    const session =
      await sessionService
        .startContinuityFinalTest(
          "uid_continuity_fail",
        );

    const result =
      await submissionService
        .processContinuityFinalTest(
          "uid_continuity_fail",
          session.sessionId,
          buildContinuityAnswers(
            session,
            7,
          ),
        );

    assert.equal(
      result.submission.correctAnswers,
      7,
    );

    assert.equal(
      result.submission.approved,
      false,
    );

    assert.equal(
      result.reward,
      null,
    );

    assert.equal(
      await readProgress(
        "uid_continuity_fail",
      ),
      null,
    );
  },
);
test(
  "eight of ten Continuity answers awards canonical reward",
  async () => {
    const session =
      await sessionService
        .startContinuityFinalTest(
          "uid_continuity_pass",
        );

    const result =
      await submissionService
        .processContinuityFinalTest(
          "uid_continuity_pass",
          session.sessionId,
          buildContinuityAnswers(
            session,
            8,
          ),
        );

    assert.equal(
      result.submission.moduleId,
      "continuidade",
    );

    assert.equal(
      result.submission.correctAnswers,
      8,
    );

    assert.equal(
      result.submission.approved,
      true,
    );

    assert.deepEqual(
      result.reward,
      {
        moduleId: "continuidade",
        alreadyCompleted: false,
        xpAwarded: 100,
        goldAwarded: 45,
      },
    );

    const progress =
      await readProgress(
        "uid_continuity_pass",
      );

    assert.ok(progress);

    assert.equal(
      progress.totalXp,
      100,
    );

    assert.equal(
      progress.totalGold,
      45,
    );

    const stored =
      await readStoredSession(
        "uid_continuity_pass",
        session.sessionId,
      );

    assert.equal(
      stored.rewardApplied,
      true,
    );
  },
);
