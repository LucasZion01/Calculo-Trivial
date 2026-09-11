import {
  Firestore,
  Timestamp,
} from "firebase-admin/firestore";
import {
  randomInt,
  randomUUID,
} from "node:crypto";

import {
  ALGEBRA_FINAL_TEST_CATALOG,
  PublicFinalTestQuestion,
  TrustedFinalTestQuestion,
  toPublicFinalTestQuestion,
} from "./algebraFinalTestCatalog";
import {
  EQUATIONS_FINAL_TEST_CATALOG,
  toPublicEquationsFinalTestQuestion,
} from "./equationsFinalTestCatalog";
import {
  FUNCTIONS_FINAL_TEST_CATALOG,
  toPublicFunctionsFinalTestQuestion,
} from "./functionsFinalTestCatalog";
import {
  LIMITS_FINAL_TEST_CATALOG,
  toPublicLimitsFinalTestQuestion,
} from "./limitsFinalTestCatalog";
import {
  CONTINUITY_FINAL_TEST_CATALOG,
  toPublicContinuityFinalTestQuestion,
} from "./continuityFinalTestCatalog";
import {
  DERIVATIVES_FINAL_TEST_CATALOG,
  toPublicDerivativesFinalTestQuestion,
} from "./derivativesFinalTestCatalog";

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

const FINAL_TEST_QUESTION_COUNT = 10;

const FINAL_TEST_SESSION_DURATION_MINUTES =
  30;

/**
 * Result returned when a trusted final-test session is created.
 */
export interface FinalTestSessionResult {
  sessionId: string;
  moduleId: string;
  expiresAt: string;
  questions: readonly PublicFinalTestQuestion[];
}

/**
 * Server-side persisted final-test session.
 */
interface StoredFinalTestSession {
  uid: string;
  moduleId: string;
  questionIds: readonly string[];
  createdAt: Timestamp;
  expiresAt: Timestamp;
  consumed: boolean;
}

/**
 * Creates trusted final-test sessions.
 */
export class FinalTestSessionService {
  /**
   * Creates the final-test session service.
   *
   * @param {Firestore} firestore Firestore Admin instance.
   */
  // eslint-disable-next-line require-jsdoc
  constructor(
    private readonly firestore:
    Firestore,
  ) {}

  /**
   * Creates one trusted Algebra final-test session.
   *
   * @param {string} uid Authenticated user identifier.
   * @return {Promise<FinalTestSessionResult>} Created session.
   */
  // eslint-disable-next-line require-jsdoc
  async startAlgebraFinalTest(
    uid: string,
  ): Promise<FinalTestSessionResult> {
    return this.startFinalTest(
      uid,
      ALGEBRA_MODULE_ID,
      ALGEBRA_FINAL_TEST_CATALOG,
      toPublicFinalTestQuestion,
    );
  }

  /**
   * Creates one trusted Equations and Inequalities final-test session.
   *
   * @param {string} uid Authenticated user identifier.
   * @return {Promise<FinalTestSessionResult>} Created session.
   */
  // eslint-disable-next-line require-jsdoc
  async startEquationsFinalTest(
    uid: string,
  ): Promise<FinalTestSessionResult> {
    return this.startFinalTest(
      uid,
      EQUATIONS_MODULE_ID,
      EQUATIONS_FINAL_TEST_CATALOG,
      toPublicEquationsFinalTestQuestion,
    );
  }

  /**
   * Creates one trusted Functions final-test session.
   *
   * @param {string} uid Authenticated user identifier.
   * @return {Promise<FinalTestSessionResult>} Created session.
   */
  // eslint-disable-next-line require-jsdoc
  async startFunctionsFinalTest(
    uid: string,
  ): Promise<FinalTestSessionResult> {
    return this.startFinalTest(
      uid,
      FUNCTIONS_MODULE_ID,
      FUNCTIONS_FINAL_TEST_CATALOG,
      toPublicFunctionsFinalTestQuestion,
    );
  }

  /**
   * Creates one trusted Limits final-test session.
   *
   * @param {string} uid Authenticated user identifier.
   * @return {Promise<FinalTestSessionResult>} Created session.
   */
  // eslint-disable-next-line require-jsdoc
  async startLimitsFinalTest(
    uid: string,
  ): Promise<FinalTestSessionResult> {
    return this.startFinalTest(
      uid,
      LIMITS_MODULE_ID,
      LIMITS_FINAL_TEST_CATALOG,
      toPublicLimitsFinalTestQuestion,
    );
  }

  /**
   * Creates one trusted Continuity final-test session.
   *
   * @param {string} uid Authenticated user identifier.
   * @return {Promise<FinalTestSessionResult>} Created session.
   */
  // eslint-disable-next-line require-jsdoc
  async startContinuityFinalTest(
    uid: string,
  ): Promise<FinalTestSessionResult> {
    return this.startFinalTest(
      uid,
      CONTINUITY_MODULE_ID,
      CONTINUITY_FINAL_TEST_CATALOG,
      toPublicContinuityFinalTestQuestion,
    );
  }

  /**
   * Creates one trusted Derivatives final-test session.
   *
   * @param {string} uid Authenticated user identifier.
   * @return {Promise<FinalTestSessionResult>} Created session.
   */
  // eslint-disable-next-line require-jsdoc
  async startDerivativesFinalTest(
    uid: string,
  ): Promise<FinalTestSessionResult> {
    return this.startFinalTest(
      uid,
      DERIVATIVES_MODULE_ID,
      DERIVATIVES_FINAL_TEST_CATALOG,
      toPublicDerivativesFinalTestQuestion,
    );
  }

  /**
   * Creates one trusted final-test session from a server-owned catalog.
   *
   * The answer key is never included in the returned questions.
   *
   * @param {string} uid Authenticated user identifier.
   * @param {string} moduleId Trusted module identifier.
   * @param {TrustedFinalTestQuestion[]} catalog Trusted question catalog.
   * @param {Function} toPublic Removes the answer key.
   * @return {Promise<FinalTestSessionResult>} Created session.
   */
  // eslint-disable-next-line require-jsdoc
  private async startFinalTest(
    uid: string,
    moduleId: string,
    catalog:
    readonly TrustedFinalTestQuestion[],
    toPublic: (
      question: TrustedFinalTestQuestion,
    ) => PublicFinalTestQuestion,
  ): Promise<FinalTestSessionResult> {
    if (
      typeof uid !== "string" ||
      uid.trim().length === 0
    ) {
      throw new Error(
        "Authenticated user ID is required.",
      );
    }

    const selectedQuestions =
      selectRandomQuestions(
        catalog,
        FINAL_TEST_QUESTION_COUNT,
      );

    const sessionId =
      randomUUID();

    const createdAt =
      Timestamp.now();

    const expiresAt =
      Timestamp.fromMillis(
        createdAt.toMillis() +
          FINAL_TEST_SESSION_DURATION_MINUTES *
            60 *
            1000,
      );

    const sessionRef =
      this.firestore
        .collection("users")
        .doc(uid)
        .collection(
          "final_test_sessions",
        )
        .doc(sessionId);

    const storedSession:
    StoredFinalTestSession = {
      uid,
      moduleId,
      questionIds:
        selectedQuestions.map(
          (question) =>
            question.id,
        ),
      createdAt,
      expiresAt,
      consumed: false,
    };

    await sessionRef.create(
      storedSession,
    );

    return {
      sessionId,
      moduleId,
      expiresAt:
        expiresAt
          .toDate()
          .toISOString(),
      questions:
        selectedQuestions.map(
          toPublic,
        ),
    };
  }
}

/**
 * Selects unique questions using Node's cryptographic RNG.
 *
 * @param {TrustedFinalTestQuestion[]} catalog Trusted catalog.
 * @param {number} count Number of questions to select.
 * @return {TrustedFinalTestQuestion[]} Selected questions.
 */
function selectRandomQuestions(
  catalog:
  readonly TrustedFinalTestQuestion[],
  count: number,
): TrustedFinalTestQuestion[] {
  if (
    !Number.isInteger(count) ||
    count <= 0 ||
    count > catalog.length
  ) {
    throw new Error(
      "Invalid final-test question count.",
    );
  }

  const pool =
    [...catalog];

  for (
    let index =
      pool.length - 1;
    index > 0;
    index--
  ) {
    const swapIndex =
      randomInt(
        index + 1,
      );

    const current =
      pool[index];

    pool[index] =
      pool[swapIndex];

    pool[swapIndex] =
      current;
  }

  return pool.slice(
    0,
    count,
  );
}
