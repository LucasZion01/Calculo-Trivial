import assert from "node:assert/strict";
import test from "node:test";

import {
  HttpsError,
} from "firebase-functions/v2/https";

import {
  FinalTestSessionResult,
} from "./finalTestSession";

import {
  FinalTestAnswer,
  FinalTestProcessingResult,
} from "./finalTestSubmission";

import {
  FinalTestExecutor,
  handleStartFinalTest,
  handleSubmitFinalTest,
} from "./finalTestCallableHandler";

const SESSION_ID =
  "123e4567-e89b-42d3-a456-426614174000";

const ANSWERS: readonly FinalTestAnswer[] =
  Array.from(
    {
      length: 10,
    },
    (_, index) => ({
      questionId:
        `final-algebra-v1-${String(
          index + 1,
        ).padStart(2, "0")}`,
      optionId: "a",
    }),
  );

/**
 * In-memory executor used to verify the callable security boundary.
 */
/**
 * In-memory executor used to verify the callable security boundary.
 */
class FakeFinalTestExecutor
implements FinalTestExecutor {
  startCalls: string[] = [];

  submitCalls: Array<{
    uid: string;
    sessionId: string;
    answers: readonly FinalTestAnswer[];
  }> = [];

  /**
   * Records a trusted final-test start operation.
   *
   * @param {string} uid Authenticated user identifier.
   * @return {Promise<FinalTestSessionResult>} Fake session.
   */
  /**
   * Records a trusted final-test start operation.
   *
   * @param {string} uid Authenticated user identifier.
   * @return {Promise<FinalTestSessionResult>} Fake session.
   */
  async start(
    uid: string,
  ): Promise<FinalTestSessionResult> {
    this.startCalls.push(uid);

    return {
      sessionId: SESSION_ID,
      moduleId:
        "algebra-fundamental",
      expiresAt:
        "2099-01-01T00:00:00.000Z",
      questions: [],
    };
  }

  /**
   * Records a trusted final-test submission operation.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestProcessingResult>} Fake trusted result.
   */
  /**
   * Records a trusted final-test submission operation.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestProcessingResult>} Fake trusted result.
   */
  async submit(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestProcessingResult> {
    this.submitCalls.push({
      uid,
      sessionId,
      answers,
    });

    return {
      submission: {
        sessionId,
        moduleId:
          "algebra-fundamental",
        totalQuestions: 10,
        correctAnswers: 8,
        accuracy: 0.8,
        approved: true,
        alreadySubmitted: false,
      },
      reward: {
        moduleId:
          "algebra-fundamental",
        alreadyCompleted: false,
        xpAwarded: 60,
        goldAwarded: 25,
      },
    };
  }
}

/**
 * Requires an HttpsError with a specific callable code.
 *
 * @param {unknown} error Candidate error.
 * @param {string} code Expected callable code.
 * @return {boolean} True when the expected error is found.
 */
function hasHttpsCode(
  error: unknown,
  code: string,
): boolean {
  return (
    error instanceof HttpsError &&
    error.code === code
  );
}

test(
  "start rejects unauthenticated caller",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    await assert.rejects(
      () =>
        handleStartFinalTest(
          {
            authUid: null,
            data: {
              moduleId:
                "algebra-fundamental",
            },
          },
          executor,
        ),
      (error) =>
        hasHttpsCode(
          error,
          "unauthenticated",
        ),
    );

    assert.equal(
      executor.startCalls.length,
      0,
    );
  },
);

test(
  "start accepts authenticated Algebra request",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    const result =
      await handleStartFinalTest(
        {
          authUid: "trusted-user",
          data: {
            moduleId:
              "algebra-fundamental",
          },
        },
        executor,
      );

    assert.equal(
      result.moduleId,
      "algebra-fundamental",
    );

    assert.deepEqual(
      executor.startCalls,
      [
        "trusted-user",
      ],
    );
  },
);

test(
  "start rejects unsupported module",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    await assert.rejects(
      () =>
        handleStartFinalTest(
          {
            authUid: "trusted-user",
            data: {
              moduleId:
                "client-forged-module",
            },
          },
          executor,
        ),
      (error) =>
        hasHttpsCode(
          error,
          "invalid-argument",
        ),
    );

    assert.equal(
      executor.startCalls.length,
      0,
    );
  },
);

test(
  "start rejects client supplied uid",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    await assert.rejects(
      () =>
        handleStartFinalTest(
          {
            authUid: "trusted-user",
            data: {
              moduleId:
                "algebra-fundamental",
              uid:
                "victim-user",
            },
          },
          executor,
        ),
      (error) =>
        hasHttpsCode(
          error,
          "invalid-argument",
        ),
    );

    assert.equal(
      executor.startCalls.length,
      0,
    );
  },
);

test(
  "submit rejects unauthenticated caller",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    await assert.rejects(
      () =>
        handleSubmitFinalTest(
          {
            authUid: null,
            data: {
              sessionId:
                SESSION_ID,
              answers:
                ANSWERS,
            },
          },
          executor,
        ),
      (error) =>
        hasHttpsCode(
          error,
          "unauthenticated",
        ),
    );

    assert.equal(
      executor.submitCalls.length,
      0,
    );
  },
);

test(
  "submit uses authenticated uid only",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    await handleSubmitFinalTest(
      {
        authUid:
          "trusted-user",
        data: {
          sessionId:
            SESSION_ID,
          answers:
            ANSWERS,
        },
      },
      executor,
    );

    assert.equal(
      executor.submitCalls.length,
      1,
    );

    assert.equal(
      executor.submitCalls[0].uid,
      "trusted-user",
    );

    assert.equal(
      executor.submitCalls[0].sessionId,
      SESSION_ID,
    );
  },
);

test(
  "submit rejects client supplied uid",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    await assert.rejects(
      () =>
        handleSubmitFinalTest(
          {
            authUid:
              "trusted-user",
            data: {
              sessionId:
                SESSION_ID,
              answers:
                ANSWERS,
              uid:
                "victim-user",
            },
          },
          executor,
        ),
      (error) =>
        hasHttpsCode(
          error,
          "invalid-argument",
        ),
    );

    assert.equal(
      executor.submitCalls.length,
      0,
    );
  },
);

test(
  "submit rejects forged score and reward fields",
  async () => {
    const forbiddenFields =
      [
        "score",
        "correctAnswers",
        "accuracy",
        "approved",
        "xp",
        "gold",
      ];

    for (
      const forbiddenField
      of forbiddenFields
    ) {
      const executor =
        new FakeFinalTestExecutor();

      await assert.rejects(
        () =>
          handleSubmitFinalTest(
            {
              authUid:
                "trusted-user",
              data: {
                sessionId:
                  SESSION_ID,
                answers:
                  ANSWERS,
                [forbiddenField]:
                  999999,
              },
            },
            executor,
          ),
        (error) =>
          hasHttpsCode(
            error,
            "invalid-argument",
          ),
      );

      assert.equal(
        executor.submitCalls.length,
        0,
      );
    }
  },
);

test(
  "submit rejects invalid session id",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    await assert.rejects(
      () =>
        handleSubmitFinalTest(
          {
            authUid:
              "trusted-user",
            data: {
              sessionId:
                "forged-session",
              answers:
                ANSWERS,
            },
          },
          executor,
        ),
      (error) =>
        hasHttpsCode(
          error,
          "invalid-argument",
        ),
    );

    assert.equal(
      executor.submitCalls.length,
      0,
    );
  },
);

test(
  "submit requires exactly ten answers",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    await assert.rejects(
      () =>
        handleSubmitFinalTest(
          {
            authUid:
              "trusted-user",
            data: {
              sessionId:
                SESSION_ID,
              answers:
                ANSWERS.slice(
                  0,
                  9,
                ),
            },
          },
          executor,
        ),
      (error) =>
        hasHttpsCode(
          error,
          "invalid-argument",
        ),
    );

    assert.equal(
      executor.submitCalls.length,
      0,
    );
  },
);

test(
  "submit rejects unexpected fields inside answers",
  async () => {
    const executor =
      new FakeFinalTestExecutor();

    const forgedAnswers =
      ANSWERS.map(
        (answer) => ({
          ...answer,
        }),
      );

    const first =
      forgedAnswers[0] as
      Record<string, unknown>;

    first.correct =
      true;

    await assert.rejects(
      () =>
        handleSubmitFinalTest(
          {
            authUid:
              "trusted-user",
            data: {
              sessionId:
                SESSION_ID,
              answers:
                forgedAnswers,
            },
          },
          executor,
        ),
      (error) =>
        hasHttpsCode(
          error,
          "invalid-argument",
        ),
    );

    assert.equal(
      executor.submitCalls.length,
      0,
    );
  },
);
