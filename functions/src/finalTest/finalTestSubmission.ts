import {
  Firestore,
  Timestamp,
} from "firebase-admin/firestore";

import {
  getAlgebraFinalTestQuestion,
} from "./algebraFinalTestCatalog";

const ALGEBRA_MODULE_ID =
  "algebra-fundamental";

const MINIMUM_PASSING_ACCURACY =
  0.8;

/**
 * One answer submitted by the authenticated user.
 */
export interface FinalTestAnswer {
  questionId: string;
  optionId: string;
}

/**
 * Result of a trusted final-test submission.
 */
export interface FinalTestSubmissionResult {
  sessionId: string;
  moduleId: string;
  totalQuestions: number;
  correctAnswers: number;
  accuracy: number;
  approved: boolean;
  alreadySubmitted: boolean;
}

/**
 * Stored final-test session shape used during correction.
 */
interface StoredFinalTestSession {
  uid: string;
  moduleId: string;
  questionIds: readonly string[];
  createdAt: Timestamp;
  expiresAt: Timestamp;
  consumed: boolean;
  consumedAt?: Timestamp;
  totalQuestions?: number;
  correctAnswers?: number;
  accuracy?: number;
  approved?: boolean;
  rewardApplied?: boolean;
}

/**
 * Corrects final tests using only backend-owned answer keys.
 */
export class FinalTestSubmissionService {
  /**
   * Creates the final-test submission service.
   *
   * @param {Firestore} firestore Firestore Admin instance.
   */
  // eslint-disable-next-line require-jsdoc
  constructor(
    private readonly firestore:
    Firestore,
  ) {}

  /**
   * Corrects one Algebra final-test session.
   *
   * Repeated submissions return the previously trusted result
   * instead of recalculating the score.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestSubmissionResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  async submitAlgebraFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestSubmissionResult> {
    validateUid(uid);
    validateSessionId(sessionId);

    const sessionRef =
      this.firestore
        .collection("users")
        .doc(uid)
        .collection(
          "final_test_sessions",
        )
        .doc(sessionId);

    return this.firestore.runTransaction(
      async (transaction) => {
        const snapshot =
          await transaction.get(
            sessionRef,
          );

        if (!snapshot.exists) {
          throw new Error(
            "Final-test session not found.",
          );
        }

        const session =
          snapshot.data() as
          StoredFinalTestSession;

        validateStoredSessionIdentity(
          session,
          uid,
        );

        if (session.consumed === true) {
          return trustedStoredResult(
            sessionId,
            session,
          );
        }

        validateActiveSession(
          session,
        );

        validateAnswers(
          session.questionIds,
          answers,
        );

        const answerMap =
          new Map<string, string>();

        for (const answer of answers) {
          answerMap.set(
            answer.questionId,
            answer.optionId,
          );
        }

        let correctAnswers = 0;

        for (
          const questionId
          of session.questionIds
        ) {
          const question =
            getAlgebraFinalTestQuestion(
              questionId,
            );

          if (!question) {
            throw new Error(
              "Trusted question not found.",
            );
          }

          const selectedOptionId =
            answerMap.get(
              questionId,
            );

          if (
            selectedOptionId ===
            question.correctOptionId
          ) {
            correctAnswers++;
          }
        }

        const totalQuestions =
          session.questionIds.length;

        const accuracy =
          totalQuestions === 0 ?
            0 :
            correctAnswers /
              totalQuestions;

        const approved =
          totalQuestions > 0 &&
          accuracy >=
            MINIMUM_PASSING_ACCURACY;

        transaction.update(
          sessionRef,
          {
            consumed: true,
            consumedAt:
              Timestamp.now(),
            totalQuestions,
            correctAnswers,
            accuracy,
            approved,
            rewardApplied: false,
          },
        );

        return {
          sessionId,
          moduleId:
            ALGEBRA_MODULE_ID,
          totalQuestions,
          correctAnswers,
          accuracy,
          approved,
          alreadySubmitted: false,
        };
      },
    );
  }
}

/**
 * Builds a previously stored trusted result.
 *
 * @param {string} sessionId Session identifier.
 * @param {StoredFinalTestSession} session Stored session.
 * @return {FinalTestSubmissionResult} Trusted stored result.
 */
function trustedStoredResult(
  sessionId: string,
  session: StoredFinalTestSession,
): FinalTestSubmissionResult {
  if (
    typeof session.totalQuestions !== "number" ||
    !Number.isInteger(
      session.totalQuestions,
    ) ||
    session.totalQuestions <= 0 ||
    typeof session.correctAnswers !== "number" ||
    !Number.isInteger(
      session.correctAnswers,
    ) ||
    session.correctAnswers < 0 ||
    session.correctAnswers >
      session.totalQuestions ||
    typeof session.accuracy !== "number" ||
    session.accuracy < 0 ||
    session.accuracy > 1 ||
    typeof session.approved !== "boolean"
  ) {
    throw new Error(
      "Invalid stored final-test result.",
    );
  }

  return {
    sessionId,
    moduleId:
      ALGEBRA_MODULE_ID,
    totalQuestions:
      session.totalQuestions,
    correctAnswers:
      session.correctAnswers,
    accuracy:
      session.accuracy,
    approved:
      session.approved,
    alreadySubmitted: true,
  };
}

/**
 * Validates the authenticated user identifier.
 *
 * @param {string} uid Authenticated user identifier.
 * @return {void}
 */
function validateUid(
  uid: string,
): void {
  if (
    typeof uid !== "string" ||
    uid.trim().length === 0
  ) {
    throw new Error(
      "Authenticated user ID is required.",
    );
  }
}

/**
 * Validates the final-test session identifier.
 *
 * @param {string} sessionId Session identifier.
 * @return {void}
 */
function validateSessionId(
  sessionId: string,
): void {
  const uuidV4Pattern =
    /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

  if (
    typeof sessionId !== "string" ||
    !uuidV4Pattern.test(
      sessionId,
    )
  ) {
    throw new Error(
      "Invalid final-test session ID.",
    );
  }
}

/**
 * Validates immutable session identity data.
 *
 * @param {StoredFinalTestSession} session Stored session.
 * @param {string} uid Authenticated user identifier.
 * @return {void}
 */
function validateStoredSessionIdentity(
  session: StoredFinalTestSession,
  uid: string,
): void {
  if (
    session.uid !== uid
  ) {
    throw new Error(
      "Final-test session ownership mismatch.",
    );
  }

  if (
    session.moduleId !==
    ALGEBRA_MODULE_ID
  ) {
    throw new Error(
      "Invalid final-test module.",
    );
  }

  if (
    !Array.isArray(
      session.questionIds,
    ) ||
    session.questionIds.length === 0
  ) {
    throw new Error(
      "Invalid final-test questions.",
    );
  }
}

/**
 * Validates an active unconsumed final-test session.
 *
 * @param {StoredFinalTestSession} session Stored session.
 * @return {void}
 */
function validateActiveSession(
  session: StoredFinalTestSession,
): void {
  if (
    !(session.expiresAt instanceof
      Timestamp)
  ) {
    throw new Error(
      "Invalid final-test expiration.",
    );
  }

  if (
    session.expiresAt.toMillis() <=
    Timestamp.now().toMillis()
  ) {
    throw new Error(
      "Final-test session expired.",
    );
  }
}

/**
 * Validates answers against the questions assigned to the session.
 *
 * @param {string[]} questionIds Assigned question identifiers.
 * @param {FinalTestAnswer[]} answers Submitted answers.
 * @return {void}
 */
function validateAnswers(
  questionIds: readonly string[],
  answers: readonly FinalTestAnswer[],
): void {
  if (
    !Array.isArray(answers) ||
    answers.length !==
      questionIds.length
  ) {
    throw new Error(
      "Invalid final-test answer count.",
    );
  }

  const expectedQuestions =
    new Set(questionIds);

  const submittedQuestions =
    new Set<string>();

  for (const answer of answers) {
    if (
      typeof answer !== "object" ||
      answer === null ||
      typeof answer.questionId !==
        "string" ||
      typeof answer.optionId !==
        "string"
    ) {
      throw new Error(
        "Invalid final-test answer.",
      );
    }

    if (
      !expectedQuestions.has(
        answer.questionId,
      )
    ) {
      throw new Error(
        "Unexpected final-test question.",
      );
    }

    if (
      submittedQuestions.has(
        answer.questionId,
      )
    ) {
      throw new Error(
        "Duplicate final-test answer.",
      );
    }

    const question =
      getAlgebraFinalTestQuestion(
        answer.questionId,
      );

    if (!question) {
      throw new Error(
        "Trusted question not found.",
      );
    }

    const validOption =
      question.options.some(
        (option) =>
          option.id ===
          answer.optionId,
      );

    if (!validOption) {
      throw new Error(
        "Invalid final-test option.",
      );
    }

    submittedQuestions.add(
      answer.questionId,
    );
  }

  for (
    const questionId
    of questionIds
  ) {
    if (
      !submittedQuestions.has(
        questionId,
      )
    ) {
      throw new Error(
        "Missing final-test answer.",
      );
    }
  }
}
