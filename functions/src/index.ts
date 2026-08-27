import {
  getApps,
  initializeApp,
} from "firebase-admin/app";
import {
  getFirestore,
} from "firebase-admin/firestore";
import {
  onCall,
} from "firebase-functions/v2/https";

import {
  TUTOR_RUNTIME_CONFIG,
} from "./config/tutorRuntimeConfig";
import {
  contentRepository,
} from "./data/contentCatalog";
import {
  createGeminiTutorClient,
} from "./gemini/GeminiTutorClient";
import {
  FirestoreIdempotencyStore,
} from "./idempotency/FirestoreIdempotencyStore";
import {
  FirestoreRateLimitStore,
} from "./rateLimit/FirestoreRateLimitStore";
import {
  GEMINI_API_KEY,
} from "./secrets/geminiSecret";
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
} from "./tutor/tutorCallableHandler";

if (getApps().length === 0) {
  initializeApp();
}

const firestore =
  getFirestore();

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
        getTutorOrchestrator(),
      ),
  );
