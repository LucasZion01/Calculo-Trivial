import {
  getApps,
  initializeApp,
} from "firebase-admin/app";
import {
  getAuth,
} from "firebase-admin/auth";
import {
  getFirestore,
} from "firebase-admin/firestore";
import {
  onCall,
} from "firebase-functions/v2/https";

import {
  FirebaseAccountDeletionService,
  handleDeleteAccount,
} from "./account/accountDeletion";
import {
  TUTOR_RUNTIME_CONFIG,
} from "./config/tutorRuntimeConfig";
import {
  contentRepository,
} from "./data/contentCatalog";
import {
  handleStartFinalTest,
  handleSubmitFinalTest,
} from "./finalTest/finalTestCallableHandler";
import {
  FinalTestSessionService,
} from "./finalTest/finalTestSession";
import {
  FinalTestSubmissionService,
} from "./finalTest/finalTestSubmission";
import {
  createGeminiTutorClient,
} from "./gemini/GeminiTutorClient";
import {
  FirestoreIdempotencyStore,
} from "./idempotency/FirestoreIdempotencyStore";
import {
  ModuleCompletionService,
} from "./progress/moduleCompletion";
import {
  FirestoreRateLimitStore,
} from "./rateLimit/FirestoreRateLimitStore";
import {
  GEMINI_API_KEY,
} from "./config/geminiSecret";
import {
  FirestoreSessionStore,
} from "./sessions/FirestoreSessionStore";
import {
  TutorSessionService,
} from "./sessions/TutorSessionService";
import {
  TutorOrchestrator,
} from "./tutor/TutorOrchestrator";
import {
  handleTutorCallable,
  TutorExecutor,
} from "./tutor/tutorCallableHandler";

if (getApps().length === 0) {
  initializeApp();
}

const firestore =
  getFirestore();

const accountDeletion =
  new FirebaseAccountDeletionService(
    firestore,
    getAuth(),
  );

const idempotency =
  new FirestoreIdempotencyStore(
    firestore,
  );

const rateLimit =
  new FirestoreRateLimitStore(
    firestore,
  );

const sessions =
  new TutorSessionService(
    new FirestoreSessionStore(
      firestore,
    ),
  );

const moduleCompletion =
  new ModuleCompletionService(
    firestore,
  );

const finalTestSessions =
  new FinalTestSessionService(
    firestore,
  );

const finalTestSubmissions =
  new FinalTestSubmissionService(
    firestore,
    moduleCompletion,
  );

let tutorOrchestrator:
TutorOrchestrator | null = null;

/**
 * Returns the process-local Tutor Trivial orchestrator.
 *
 * Keeping one Gemini client per Functions instance also preserves the
 * configured process-local concurrency guard.
 *
 * @return {TutorOrchestrator} Tutor orchestrator.
 */
function getTutorOrchestrator():
TutorOrchestrator {
  if (tutorOrchestrator) {
    return tutorOrchestrator;
  }

  const apiKey =
    GEMINI_API_KEY.value();

  if (!apiKey) {
    throw new Error(
      "Tutor secret is unavailable",
    );
  }

  tutorOrchestrator =
    new TutorOrchestrator({
      contentRepository,
      idempotency,
      rateLimit,
      sessions,
      gemini:
        createGeminiTutorClient(
          apiKey,
        ),
    });

  return tutorOrchestrator;
}

const tutorExecutor: TutorExecutor = {
  execute(
    uid,
    request,
    now,
  ) {
    return getTutorOrchestrator()
      .execute(
        uid,
        request,
        now,
      );
  },
};

export const tutor =
  onCall(
    {
      enforceAppCheck: true,
      secrets: [
        GEMINI_API_KEY,
      ],
      minInstances:
        TUTOR_RUNTIME_CONFIG
          .function
          .minInstances,
      maxInstances:
        TUTOR_RUNTIME_CONFIG
          .function
          .maxInstances,
      concurrency:
        TUTOR_RUNTIME_CONFIG
          .function
          .concurrency,
      timeoutSeconds:
        TUTOR_RUNTIME_CONFIG
          .function
          .timeoutSeconds,
    },
    async (request) =>
      handleTutorCallable(
        {
          auth:
            request.auth ?
              {
                uid:
                  request.auth.uid,
              } :
              null,
          data: request.data,
        },
        tutorExecutor,
      ),
  );

export const deleteAccount =
  onCall(
    {
      enforceAppCheck: true,
      minInstances: 0,
      maxInstances: 2,
      concurrency: 10,
      timeoutSeconds: 30,
    },
    async (request) =>
      handleDeleteAccount(
        {
          authUid:
            request.auth?.uid ??
            null,
          data: request.data,
        },
        accountDeletion,
      ),
  );

export const startFinalTest =
  onCall(
    {
      enforceAppCheck: true,
      minInstances: 0,
      maxInstances: 2,
      concurrency: 20,
      timeoutSeconds: 30,
    },
    async (request) =>
      handleStartFinalTest(
        {
          authUid:
            request.auth?.uid ??
            null,
          data: request.data,
        },
        {
          start: (
            uid,
            moduleId,
          ) => {
            if (
              moduleId ===
              "algebra-fundamental"
            ) {
              return finalTestSessions
                .startAlgebraFinalTest(
                  uid,
                );
            }

            if (
              moduleId ===
              "equacoes-inequacoes"
            ) {
              return finalTestSessions
                .startEquationsFinalTest(
                  uid,
                );
            }

            if (
              moduleId ===
              "funcoes"
            ) {
              return finalTestSessions
                .startFunctionsFinalTest(
                  uid,
                );
            }

            if (
              moduleId ===
              "limites"
            ) {
              return finalTestSessions
                .startLimitsFinalTest(
                  uid,
                );
            }

            if (
              moduleId ===
              "derivadas"
            ) {
              return finalTestSessions
                .startDerivativesFinalTest(
                  uid,
                );
            }

            return finalTestSessions
              .startContinuityFinalTest(
                uid,
              );
          },
          submit: (
            uid,
            sessionId,
            answers,
          ) =>
            finalTestSubmissions
              .processTrustedFinalTest(
                uid,
                sessionId,
                answers,
              ),
        },
      ),
  );

export const submitFinalTest =
  onCall(
    {
      enforceAppCheck: true,
      minInstances: 0,
      maxInstances: 2,
      concurrency: 20,
      timeoutSeconds: 30,
    },
    async (request) =>
      handleSubmitFinalTest(
        {
          authUid:
            request.auth?.uid ??
            null,
          data: request.data,
        },
        {
          start: (
            uid,
            moduleId,
          ) => {
            if (
              moduleId ===
              "algebra-fundamental"
            ) {
              return finalTestSessions
                .startAlgebraFinalTest(
                  uid,
                );
            }

            if (
              moduleId ===
              "equacoes-inequacoes"
            ) {
              return finalTestSessions
                .startEquationsFinalTest(
                  uid,
                );
            }

            if (
              moduleId ===
              "funcoes"
            ) {
              return finalTestSessions
                .startFunctionsFinalTest(
                  uid,
                );
            }

            if (
              moduleId ===
              "limites"
            ) {
              return finalTestSessions
                .startLimitsFinalTest(
                  uid,
                );
            }

            if (
              moduleId ===
              "derivadas"
            ) {
              return finalTestSessions
                .startDerivativesFinalTest(
                  uid,
                );
            }

            return finalTestSessions
              .startContinuityFinalTest(
                uid,
              );
          },
          submit: (
            uid,
            sessionId,
            answers,
          ) =>
            finalTestSubmissions
              .processTrustedFinalTest(
                uid,
                sessionId,
                answers,
              ),
        },
      ),
  );
