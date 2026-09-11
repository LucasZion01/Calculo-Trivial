import {
  Firestore,
  Timestamp,
} from "firebase-admin/firestore";

import {
  getAlgebraFinalTestQuestion,
  TrustedFinalTestQuestion,
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
  getDerivativesFinalTestQuestion,
} from "./derivativesFinalTestCatalog";

import {
  ModuleCompletionResult,
  ModuleCompletionService,
  ModuleId,
} from "../progress/moduleCompletion";

const ALGEBRA_MODULE_ID =
  "algebra-fundamental";

const EQUATIONS_MODULE_ID =
  "equacoes-inequacoes";

const FUNCTIONS_MODULE_ID =
  "funcoes";

const LIMITS_MODULE_ID =
  "limites";

const CONTINUITY_MODULE_ID =
  "continuidade";

const DERIVATIVES_MODULE_ID =
  "derivadas";

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
 * Result of submission processing including trusted reward data.
 */
export interface FinalTestProcessingResult {
  submission: FinalTestSubmissionResult;
  reward: ModuleCompletionResult | null;
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
 * Resolves a trusted question exclusively from backend-owned catalogs.
 */
type TrustedQuestionResolver = (
  questionId: string,
) => TrustedFinalTestQuestion | undefined;

/**
 * Corrects final tests using only backend-owned answer keys.
 */
export class FinalTestSubmissionService {
  /**
   * Creates the final-test submission service.
   *
   * @param {Firestore} firestore Firestore Admin instance.
   * @param {ModuleCompletionService} completionService Trusted rewards.
   */
  // eslint-disable-next-line require-jsdoc
  constructor(
    private readonly firestore:
    Firestore,
    private readonly completionService:
    ModuleCompletionService,
  ) {}

  /**
   * Processes a final test using the server-owned session module.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestProcessingResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  async processTrustedFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestProcessingResult> {
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

    const snapshot =
      await sessionRef.get();

    if (!snapshot.exists) {
      throw new Error(
        "Final-test session not found.",
      );
    }

    const session =
      snapshot.data() as
        StoredFinalTestSession;

    if (
      session.uid !== uid
    ) {
      throw new Error(
        "Final-test session owner mismatch.",
      );
    }

    if (
      session.moduleId ===
      ALGEBRA_MODULE_ID
    ) {
      return this.processAlgebraFinalTest(
        uid,
        sessionId,
        answers,
      );
    }

    if (
      session.moduleId ===
      EQUATIONS_MODULE_ID
    ) {
      return this.processEquationsFinalTest(
        uid,
        sessionId,
        answers,
      );
    }

    if (
      session.moduleId ===
      FUNCTIONS_MODULE_ID
    ) {
      return this.processFunctionsFinalTest(
        uid,
        sessionId,
        answers,
      );
    }

    if (
      session.moduleId ===
      LIMITS_MODULE_ID
    ) {
      return this.processLimitsFinalTest(
        uid,
        sessionId,
        answers,
      );
    }

    if (
      session.moduleId ===
      CONTINUITY_MODULE_ID
    ) {
      return this.processContinuityFinalTest(
        uid,
        sessionId,
        answers,
      );
    }

    if (
      session.moduleId ===
      DERIVATIVES_MODULE_ID
    ) {
      return this.processDerivativesFinalTest(
        uid,
        sessionId,
        answers,
      );
    }

    throw new Error(
      "Unsupported final-test module.",
    );
  }
  /**
   * Processes one trusted Algebra final test.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestProcessingResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  async processAlgebraFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestProcessingResult> {
    return this.processFinalTest(
      uid,
      sessionId,
      answers,
      ALGEBRA_MODULE_ID,
      getAlgebraFinalTestQuestion,
    );
  }

  /**
   * Processes one trusted Equations and Inequalities final test.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestProcessingResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  async processEquationsFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestProcessingResult> {
    return this.processFinalTest(
      uid,
      sessionId,
      answers,
      EQUATIONS_MODULE_ID,
      getEquationsFinalTestQuestion,
    );
  }

  /**
   * Processes one trusted Functions final test.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestProcessingResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  async processFunctionsFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestProcessingResult> {
    return this.processFinalTest(
      uid,
      sessionId,
      answers,
      FUNCTIONS_MODULE_ID,
      getFunctionsFinalTestQuestion,
    );
  }

  /**
   * Processes one trusted Limits final test.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestProcessingResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  async processLimitsFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestProcessingResult> {
    return this.processFinalTest(
      uid,
      sessionId,
      answers,
      LIMITS_MODULE_ID,
      getLimitsFinalTestQuestion,
    );
  }

  /**
   * Processes one trusted Continuity final test.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestProcessingResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  async processContinuityFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestProcessingResult> {
    return this.processFinalTest(
      uid,
      sessionId,
      answers,
      CONTINUITY_MODULE_ID,
      getContinuityFinalTestQuestion,
    );
  }

  /**
   * Processes one trusted Derivatives final test.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @return {Promise<FinalTestProcessingResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  async processDerivativesFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestProcessingResult> {
    return this.processFinalTest(
      uid,
      sessionId,
      answers,
      DERIVATIVES_MODULE_ID,
      getDerivativesFinalTestQuestion,
    );
  }
  /**
   * Corrects and conditionally rewards one trusted final test.
   *
   * The expected module and answer resolver are selected by trusted
   * backend code. The client cannot select either one.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @param {string} expectedModuleId Trusted expected module.
   * @param {TrustedQuestionResolver} resolveQuestion Trusted resolver.
   * @return {Promise<FinalTestProcessingResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  private async processFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
    expectedModuleId: ModuleId,
    resolveQuestion: TrustedQuestionResolver,
  ): Promise<FinalTestProcessingResult> {
    const submission =
      await this.submitFinalTest(
        uid,
        sessionId,
        answers,
        expectedModuleId,
        resolveQuestion,
      );

    if (!submission.approved) {
      return {
        submission,
        reward: null,
      };
    }

    const reward =
      await this.completionService
        .awardAfterVerifiedPass(
          uid,
          expectedModuleId,
          sessionId,
        );

    await this.markRewardApplied(
      uid,
      sessionId,
      expectedModuleId,
    );

    return {
      submission,
      reward,
    };
  }

  /**
   * Corrects one trusted final-test session.
   *
   * Repeated submissions return the previously trusted result
   * instead of recalculating the score.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Trusted session identifier.
   * @param {FinalTestAnswer[]} answers Submitted answers.
   * @param {string} expectedModuleId Trusted expected module.
   * @param {TrustedQuestionResolver} resolveQuestion Trusted resolver.
   * @return {Promise<FinalTestSubmissionResult>} Trusted result.
   */
  // eslint-disable-next-line require-jsdoc
  private async submitFinalTest(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
    expectedModuleId: ModuleId,
    resolveQuestion: TrustedQuestionResolver,
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
          expectedModuleId,
        );

        if (session.consumed === true) {
          return trustedStoredResult(
            sessionId,
            session,
            expectedModuleId,
          );
        }

        validateActiveSession(
          session,
        );

        validateAnswers(
          session.questionIds,
          answers,
          resolveQuestion,
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
            resolveQuestion(
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
            session.moduleId,
          totalQuestions,
          correctAnswers,
          accuracy,
          approved,
          alreadySubmitted: false,
        };
      },
    );
  }

  /**
   * Marks a passing session after its idempotent reward succeeds.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} sessionId Final-test session identifier.
   * @param {string} expectedModuleId Trusted expected module.
   * @return {Promise<void>} Completion.
   */
  // eslint-disable-next-line require-jsdoc
  private async markRewardApplied(
    uid: string,
    sessionId: string,
    expectedModuleId: ModuleId,
  ): Promise<void> {
    const sessionRef =
      this.firestore
        .collection("users")
        .doc(uid)
        .collection(
          "final_test_sessions",
        )
        .doc(sessionId);

    await this.firestore.runTransaction(
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
          expectedModuleId,
        );

        if (
          session.consumed !== true ||
          session.approved !== true
        ) {
          throw new Error(
            "Final-test reward state mismatch.",
          );
        }

        if (session.rewardApplied === true) {
          return;
        }

        transaction.update(
          sessionRef,
          {
            rewardApplied: true,
          },
        );
      },
    );
  }
}

/**
 * Builds a previously stored trusted result.
 *
 * @param {string} sessionId Session identifier.
 * @param {StoredFinalTestSession} session Stored session.
 * @param {string} expectedModuleId Trusted expected module.
 * @return {FinalTestSubmissionResult} Trusted stored result.
 */
function trustedStoredResult(
  sessionId: string,
  session: StoredFinalTestSession,
  expectedModuleId: ModuleId,
): FinalTestSubmissionResult {
  validateStoredSessionIdentity(
    session,
    session.uid,
    expectedModuleId,
  );

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
      session.moduleId,
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
 * @param {string} expectedModuleId Trusted expected module.
 * @return {void}
 */
function validateStoredSessionIdentity(
  session: StoredFinalTestSession,
  uid: string,
  expectedModuleId: ModuleId,
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
    expectedModuleId
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
 * Validates answers against assigned questions.
 *
 * @param {string[]} questionIds Assigned question identifiers.
 * @param {FinalTestAnswer[]} answers Submitted answers.
 * @param {TrustedQuestionResolver} resolveQuestion Trusted resolver.
 * @return {void}
 */
function validateAnswers(
  questionIds: readonly string[],
  answers: readonly FinalTestAnswer[],
  resolveQuestion: TrustedQuestionResolver,
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
      resolveQuestion(
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
