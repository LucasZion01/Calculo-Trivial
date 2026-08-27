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
   * Creates a new tutor session without consuming a hint.
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
    return this.createWithHintLevel(
      uid,
      context,
      0,
      now,
    );
  }

  /**
   * Creates the first request_hint session atomically at hint level one.
   *
   * This avoids creating level zero and then requiring a second write
   * merely to consume the first hint.
   *
   * @param {string} uid Authenticated Firebase uid.
   * @param {SessionContext} context Backend-owned question context.
   * @param {Date} now Current backend time.
   * @return {Promise<TutorSession>} New first-hint session.
   */
  async createSessionForFirstHint(
    uid: string,
    context: SessionContext,
    now: Date = new Date(),
  ): Promise<TutorSession> {
    return this.createWithHintLevel(
      uid,
      context,
      1,
      now,
    );
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

  /**
   * Validates and refreshes a non-hint session use atomically.
   *
   * The hint level is preserved while lastInteractionAt and expiresAt
   * are renewed.
   *
   * @param {string} sessionId Opaque session identifier.
   * @param {string} uid Authenticated Firebase uid.
   * @param {SessionContext} context Expected backend context.
   * @param {Date} now Current backend time.
   * @return {Promise<SessionMutationResult>} Mutation result.
   */
  async touchSession(
    sessionId: string,
    uid: string,
    context: SessionContext,
    now: Date = new Date(),
  ): Promise<SessionMutationResult> {
    return this.store.touchAtomically(
      sessionId,
      uid,
      context,
      now,
    );
  }

  /**
   * Creates one persisted session at an explicit backend hint level.
   *
   * @param {string} uid Authenticated Firebase uid.
   * @param {SessionContext} context Backend-owned context.
   * @param {number} hintLevel Initial hint level.
   * @param {Date} now Current backend time.
   * @return {Promise<TutorSession>} Persisted session.
   */
  private async createWithHintLevel(
    uid: string,
    context: SessionContext,
    hintLevel: number,
    now: Date,
  ): Promise<TutorSession> {
    const session: TutorSession = {
      sessionId: createSessionId(),
      uid,
      context,
      createdAt: now,
      lastInteractionAt: now,
      expiresAt: new Date(
        now.getTime() +
        SESSION_IDLE_TIMEOUT_MS,
      ),
      hintLevel,
    };

    await this.store.create(session);

    return session;
  }
}

export {
  MAX_HINT_LEVEL,
};
