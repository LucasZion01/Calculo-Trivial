import {
  HttpsError,
} from "firebase-functions/v2/https";

import {
  tutorRequestSchema,
} from "../contracts/inputSchemas";
import {
  TutorBackendResponse,
  TutorRequest,
} from "../contracts/types";
import {
  TutorOrchestratorError,
} from "./TutorOrchestrator";

export interface TutorExecutor {
  execute(
    uid: string,
    request: TutorRequest,
    now?: Date,
  ): Promise<TutorBackendResponse>;
}

export interface TutorCallableRequest {
  auth?: {
    uid: string;
  } | null;
  data: unknown;
}

/**
 * Handles one already-App-Check-protected callable request.
 *
 * Firebase onCall performs App Check enforcement before this handler.
 * Authentication and payload validation remain explicit here.
 *
 * @param {TutorCallableRequest} request Callable request.
 * @param {TutorExecutor} executor Trusted tutor executor.
 * @return {Promise<TutorBackendResponse>} Public response.
 */
export async function handleTutorCallable(
  request: TutorCallableRequest,
  executor: TutorExecutor,
): Promise<TutorBackendResponse> {
  const uid =
    request.auth?.uid;

  if (!uid) {
    throw new HttpsError(
      "unauthenticated",
      "Autenticação obrigatória.",
    );
  }

  const parsed =
    tutorRequestSchema.safeParse(
      request.data,
    );

  if (!parsed.success) {
    throw new HttpsError(
      "invalid-argument",
      "Solicitação inválida.",
    );
  }

  try {
    return await executor.execute(
      uid,
      parsed.data,
    );
  } catch (error: unknown) {
    throw mapTutorError(error);
  }
}

/**
 * Converts internal orchestration failures to public callable errors.
 *
 * No provider error, stack, uid, prompt or internal path is exposed.
 *
 * @param {unknown} error Internal error.
 * @return {HttpsError} Public Firebase error.
 */
function mapTutorError(
  error: unknown,
): HttpsError {
  if (
    !(
      error instanceof
      TutorOrchestratorError
    )
  ) {
    return new HttpsError(
      "internal",
      "Não foi possível concluir a solicitação.",
    );
  }

  switch (error.code) {
  case "IDEMPOTENCY_IN_PROGRESS":
    return new HttpsError(
      "aborted",
      "Solicitação já está em processamento.",
    );

  case "RATE_LIMITED":
    return new HttpsError(
      "resource-exhausted",
      "Limite temporário de solicitações atingido.",
      error.retryAfterMs === null ?
        undefined :
        {
          retryAfterMs:
            error.retryAfterMs,
        },
    );

  case "LESSON_NOT_FOUND":
  case "QUESTION_NOT_FOUND":
    return new HttpsError(
      "not-found",
      "Conteúdo não encontrado.",
    );

  case "SESSION_NOT_FOUND":
    return new HttpsError(
      "not-found",
      "Sessão do tutor não encontrada.",
    );

  case "SESSION_FORBIDDEN":
    return new HttpsError(
      "permission-denied",
      "Sessão do tutor não autorizada.",
    );

  case "SESSION_EXPIRED":
    return new HttpsError(
      "failed-precondition",
      "A sessão do tutor expirou.",
    );

  case "SESSION_CONTEXT_MISMATCH":
    return new HttpsError(
      "failed-precondition",
      "A sessão não corresponde a este conteúdo.",
    );

  case "HINT_LIMIT_REACHED":
    return new HttpsError(
      "failed-precondition",
      "O limite de pistas desta sessão foi atingido.",
    );

  case "FEATURE_NOT_READY":
    return new HttpsError(
      "failed-precondition",
      "Este recurso ainda não está disponível.",
    );
  }
}
