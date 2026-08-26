import {
  randomBytes,
} from "node:crypto";

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

/**
 * Creates opaque and unpredictable tutor session ids.
 *
 * @return {string} New session identifier.
 */
function createSessionId(): string {
  return `sess_${randomBytes(24).toString("base64url")}`;
}

/**
 * Application service for tutor sessions.
 */
export class TutorSessionService {
  /**
   * Creates the session service.
   *
   * @param {SessionStore} store Session persistence.
   */
  constructor(
    private readonly store: SessionStore,
  ) {}

  /**
   * Creates a new tutor session.
   *
   * @param {string} uid Authenticated Firebase uid.
   * @param {SessionContext} context Backend-owned context.
   * @param {Date} now Current backend time.
   * @return {Promise<TutorSession>} New session.
   */
  async createSession(
    uid: string,
    context: SessionContext,
    now: Date = new Date(),
  ): Promise<TutorSession> {
    const session: TutorSession = {
      sessionId: createSessionId(),
      uid,
      context,
      createdAt: now,
      lastInteractionAt: now,
      expiresAt: new Date(
        now.getTime() + SESSION_IDLE_TIMEOUT_MS,
      ),
      hintLevel: 0,
    };

    await this.store.create(session);

    return session;
  }

  /**
   * Advances one hint level using an atomic store operation.
   *
   * @param {string} sessionId Opaque session identifier.
   * @param {string} uid Authenticated Firebase uid.
   * @param {SessionContext} context Expected context.
   * @param {Date} now Current backend time.
   * @return {Promise<SessionMutationResult>} Mutation result.
   */
  async requestNextHint(
    sessionId: string,
    uid: string,
    context: SessionContext,
    now: Date = new Date(),
  ): Promise<SessionMutationResult> {
    return this.store.advanceHintAtomically(
      sessionId,
      uid,
      context,
      now,
    );
  }
}

export {
  MAX_HINT_LEVEL,
};
