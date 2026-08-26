import {
  Firestore,
  Timestamp,
} from "firebase-admin/firestore";

import {
  SessionStore,
} from "./SessionStore";
import {
  MAX_HINT_LEVEL,
  SESSION_IDLE_TIMEOUT_MS,
  SessionContext,
  SessionMutationResult,
  TutorSession,
} from "./sessionTypes";

interface TutorSessionDocument {
  uid: string;
  context: SessionContext;
  createdAt: Timestamp;
  lastInteractionAt: Timestamp;
  expiresAt: Timestamp;
  hintLevel: number;
}

/**
 * Firestore-backed atomic tutor session store.
 */
export class FirestoreSessionStore
implements SessionStore {
  /**
   * Creates the Firestore store.
   *
   * @param {Firestore} firestore Admin Firestore instance.
   */
  constructor(
    private readonly firestore: Firestore,
  ) {}

  /**
   * Persists a new session without allowing overwrite.
   *
   * @param {TutorSession} session New tutor session.
   * @return {Promise<void>} Completion promise.
   */
  async create(
    session: TutorSession,
  ): Promise<void> {
    const reference = this.firestore
      .collection("tutorSessions")
      .doc(session.sessionId);

    const document: TutorSessionDocument = {
      uid: session.uid,
      context: session.context,
      createdAt: Timestamp.fromDate(
        session.createdAt,
      ),
      lastInteractionAt: Timestamp.fromDate(
        session.lastInteractionAt,
      ),
      expiresAt: Timestamp.fromDate(
        session.expiresAt,
      ),
      hintLevel: session.hintLevel,
    };

    await reference.create(document);
  }

  /**
   * Atomically validates and advances one hint.
   *
   * @param {string} sessionId Session identifier.
   * @param {string} uid Authenticated uid.
   * @param {SessionContext} expectedContext Expected context.
   * @param {Date} now Backend time.
   * @return {Promise<SessionMutationResult>} Mutation result.
   */
  async advanceHintAtomically(
    sessionId: string,
    uid: string,
    expectedContext: SessionContext,
    now: Date,
  ): Promise<SessionMutationResult> {
    const reference = this.firestore
      .collection("tutorSessions")
      .doc(sessionId);

    return this.firestore.runTransaction(
      async (transaction) => {
        const snapshot =
          await transaction.get(reference);

        if (!snapshot.exists) {
          return {
            ok: false,
            code: "SESSION_NOT_FOUND",
          };
        }

        const data =
          snapshot.data() as TutorSessionDocument;

        if (data.uid !== uid) {
          return {
            ok: false,
            code: "SESSION_FORBIDDEN",
          };
        }

        if (
          !sameContext(
            data.context,
            expectedContext,
          )
        ) {
          return {
            ok: false,
            code: "SESSION_CONTEXT_MISMATCH",
          };
        }

        if (
          data.expiresAt.toMillis() <=
          now.getTime()
        ) {
          return {
            ok: false,
            code: "SESSION_EXPIRED",
          };
        }

        if (
          data.hintLevel >=
          MAX_HINT_LEVEL
        ) {
          return {
            ok: false,
            code: "HINT_LIMIT_REACHED",
          };
        }

        const nextLevel =
          data.hintLevel + 1;

        const expiresAt = new Date(
          now.getTime() +
          SESSION_IDLE_TIMEOUT_MS,
        );

        transaction.update(
          reference,
          {
            hintLevel: nextLevel,
            lastInteractionAt:
              Timestamp.fromDate(now),
            expiresAt:
              Timestamp.fromDate(
                expiresAt,
              ),
          },
        );

        return {
          ok: true,
          session: {
            sessionId,
            uid,
            context: data.context,
            createdAt:
              data.createdAt.toDate(),
            lastInteractionAt: now,
            expiresAt,
            hintLevel: nextLevel,
          },
        };
      },
    );
  }
}

/**
 * Compares two backend-owned session contexts.
 *
 * @param {SessionContext} left First context.
 * @param {SessionContext} right Second context.
 * @return {boolean} True when contexts are identical.
 */
function sameContext(
  left: SessionContext,
  right: SessionContext,
): boolean {
  if (
    left.contextType !==
    right.contextType
  ) {
    return false;
  }

  if (
    left.contextType === "question" &&
    right.contextType === "question"
  ) {
    return (
      left.lessonId === right.lessonId &&
      left.questionId === right.questionId
    );
  }

  if (
    left.contextType === "attempt" &&
    right.contextType === "attempt"
  ) {
    return left.attemptId === right.attemptId;
  }

  return false;
}
