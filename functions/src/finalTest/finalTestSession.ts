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

const ALGEBRA_MODULE_ID =
  "algebra-fundamental";

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
   * The answer key is never included in the returned questions.
   *
   * @param {string} uid Authenticated user identifier.
   * @return {Promise<FinalTestSessionResult>} Created session.
   */
  // eslint-disable-next-line require-jsdoc
  async startAlgebraFinalTest(
    uid: string,
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
        ALGEBRA_FINAL_TEST_CATALOG,
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
      moduleId:
        ALGEBRA_MODULE_ID,
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
      moduleId:
        ALGEBRA_MODULE_ID,
      expiresAt:
        expiresAt
          .toDate()
          .toISOString(),
      questions:
        selectedQuestions.map(
          toPublicFinalTestQuestion,
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
