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

export type SupportedFinalTestModuleId =
  "algebra-fundamental" |
  "equacoes-inequacoes";

const SUPPORTED_MODULE_IDS =
  new Set<SupportedFinalTestModuleId>([
    "algebra-fundamental",
    "equacoes-inequacoes",
  ]);

const MAX_ANSWER_COUNT = 10;

/**
 * Minimal authenticated callable request.
 */
export interface FinalTestCallableRequest {
  authUid: string | null;
  data: unknown;
}

/**
 * Trusted operations exposed to the callable boundary.
 */
export interface FinalTestExecutor {
  start(
    uid: string,
    moduleId: SupportedFinalTestModuleId,
  ): Promise<FinalTestSessionResult>;

  submit(
    uid: string,
    sessionId: string,
    answers: readonly FinalTestAnswer[],
  ): Promise<FinalTestProcessingResult>;
}

/**
 * Handles final-test session creation.
 *
 * The authenticated UID is derived outside client-controlled data.
 * The requested module must belong to the backend allowlist.
 *
 * @param {FinalTestCallableRequest} request Callable request.
 * @param {FinalTestExecutor} executor Trusted executor.
 * @return {Promise<FinalTestSessionResult>} Created session.
 */
export async function handleStartFinalTest(
  request: FinalTestCallableRequest,
  executor: FinalTestExecutor,
): Promise<FinalTestSessionResult> {
  const uid =
    requireAuthenticatedUid(
      request.authUid,
    );

  const data =
    requirePlainObject(
      request.data,
    );

  rejectUnexpectedKeys(
    data,
    new Set([
      "moduleId",
    ]),
  );

  const moduleId =
    requireSupportedModuleId(
      data.moduleId,
    );

  try {
    return await executor.start(
      uid,
      moduleId,
    );
  } catch {
    throw new HttpsError(
      "internal",
      "Unable to start final test.",
    );
  }
}

/**
 * Handles trusted final-test submission.
 *
 * Client-calculated score, XP, gold and approval are never accepted.
 * The module is intentionally not accepted from the client here.
 *
 * @param {FinalTestCallableRequest} request Callable request.
 * @param {FinalTestExecutor} executor Trusted executor.
 * @return {Promise<FinalTestProcessingResult>} Trusted result.
 */
export async function handleSubmitFinalTest(
  request: FinalTestCallableRequest,
  executor: FinalTestExecutor,
): Promise<FinalTestProcessingResult> {
  const uid =
    requireAuthenticatedUid(
      request.authUid,
    );

  const data =
    requirePlainObject(
      request.data,
    );

  rejectUnexpectedKeys(
    data,
    new Set([
      "sessionId",
      "answers",
    ]),
  );

  const sessionId =
    requireSessionId(
      data.sessionId,
    );

  const answers =
    requireAnswers(
      data.answers,
    );

  try {
    return await executor.submit(
      uid,
      sessionId,
      answers,
    );
  } catch (error) {
    if (
      error instanceof HttpsError
    ) {
      throw error;
    }

    throw new HttpsError(
      "failed-precondition",
      "Final test could not be processed.",
    );
  }
}

/**
 * Requires an authenticated Firebase user.
 *
 * @param {string | null} authUid Authenticated UID.
 * @return {string} Trusted UID.
 */
function requireAuthenticatedUid(
  authUid: string | null,
): string {
  if (
    typeof authUid !== "string" ||
    authUid.trim().length === 0
  ) {
    throw new HttpsError(
      "unauthenticated",
      "Authentication is required.",
    );
  }

  return authUid;
}

/**
 * Requires one supported final-test module.
 *
 * @param {unknown} value Candidate module identifier.
 * @return {SupportedFinalTestModuleId} Trusted module identifier.
 */
function requireSupportedModuleId(
  value: unknown,
): SupportedFinalTestModuleId {
  if (
    typeof value !== "string" ||
    !SUPPORTED_MODULE_IDS.has(
      value as SupportedFinalTestModuleId,
    )
  ) {
    throw new HttpsError(
      "invalid-argument",
      "Unsupported final-test module.",
    );
  }

  return value as
    SupportedFinalTestModuleId;
}

/**
 * Requires a plain object payload.
 *
 * @param {unknown} value Candidate payload.
 * @return {Record<string, unknown>} Valid object.
 */
function requirePlainObject(
  value: unknown,
): Record<string, unknown> {
  if (
    typeof value !== "object" ||
    value === null ||
    Array.isArray(value)
  ) {
    throw new HttpsError(
      "invalid-argument",
      "Invalid final-test request.",
    );
  }

  return value as
    Record<string, unknown>;
}

/**
 * Rejects fields outside the callable contract.
 *
 * @param {Record<string, unknown>} data Request data.
 * @param {Set<string>} allowedKeys Allowed keys.
 * @return {void}
 */
function rejectUnexpectedKeys(
  data: Record<string, unknown>,
  allowedKeys: Set<string>,
): void {
  for (
    const key
    of Object.keys(data)
  ) {
    if (!allowedKeys.has(key)) {
      throw new HttpsError(
        "invalid-argument",
        "Unexpected final-test field.",
      );
    }
  }
}

/**
 * Validates the session identifier at the callable boundary.
 *
 * @param {unknown} value Candidate session ID.
 * @return {string} Valid session ID.
 */
function requireSessionId(
  value: unknown,
): string {
  const uuidV4Pattern =
    /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

  if (
    typeof value !== "string" ||
    !uuidV4Pattern.test(value)
  ) {
    throw new HttpsError(
      "invalid-argument",
      "Invalid final-test session ID.",
    );
  }

  return value;
}

/**
 * Validates submitted answers without trusting their correctness.
 *
 * @param {unknown} value Candidate answer list.
 * @return {FinalTestAnswer[]} Validated answers.
 */
function requireAnswers(
  value: unknown,
): FinalTestAnswer[] {
  if (
    !Array.isArray(value) ||
    value.length !==
      MAX_ANSWER_COUNT
  ) {
    throw new HttpsError(
      "invalid-argument",
      "Invalid final-test answers.",
    );
  }

  return value.map(
    (candidate) => {
      const answer =
        requirePlainObject(
          candidate,
        );

      rejectUnexpectedKeys(
        answer,
        new Set([
          "questionId",
          "optionId",
        ]),
      );

      if (
        typeof answer.questionId !==
          "string" ||
        answer.questionId.length === 0 ||
        answer.questionId.length > 80 ||
        typeof answer.optionId !==
          "string" ||
        answer.optionId.length === 0 ||
        answer.optionId.length > 20
      ) {
        throw new HttpsError(
          "invalid-argument",
          "Invalid final-test answer.",
        );
      }

      return {
        questionId:
          answer.questionId,
        optionId:
          answer.optionId,
      };
    },
  );
}
