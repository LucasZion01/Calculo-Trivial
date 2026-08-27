import assert from "node:assert/strict";
import test from "node:test";

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
import {
  TutorSessionService,
} from "./TutorSessionService";

/**
 * In-memory atomic session store for unit tests.
 */
class MemorySessionStore
implements SessionStore {
  private readonly sessions =
    new Map<string, TutorSession>();

  /**
   * Persists one session.
   *
   * @param {TutorSession} session Session.
   * @return {Promise<void>} Completion promise.
   */
  async create(
    session: TutorSession,
  ): Promise<void> {
    if (
      this.sessions.has(
        session.sessionId,
      )
    ) {
      throw new Error(
        "Session already exists",
      );
    }

    this.sessions.set(
      session.sessionId,
      session,
    );
  }

  /**
   * Advances one hint atomically.
   *
   * @param {string} sessionId Session id.
   * @param {string} uid Authenticated uid.
   * @param {SessionContext} expectedContext Expected context.
   * @param {Date} now Backend time.
   * @return {Promise<SessionMutationResult>} Result.
   */
  async advanceHintAtomically(
    sessionId: string,
    uid: string,
    expectedContext: SessionContext,
    now: Date,
  ): Promise<SessionMutationResult> {
    return this.mutate(
      sessionId,
      uid,
      expectedContext,
      now,
      true,
    );
  }

  /**
   * Refreshes one session without advancing its hint.
   *
   * @param {string} sessionId Session id.
   * @param {string} uid Authenticated uid.
   * @param {SessionContext} expectedContext Expected context.
   * @param {Date} now Backend time.
   * @return {Promise<SessionMutationResult>} Result.
   */
  async touchAtomically(
    sessionId: string,
    uid: string,
    expectedContext: SessionContext,
    now: Date,
  ): Promise<SessionMutationResult> {
    return this.mutate(
      sessionId,
      uid,
      expectedContext,
      now,
      false,
    );
  }

  /**
   * Applies one in-memory atomic mutation.
   *
   * @param {string} sessionId Session id.
   * @param {string} uid Authenticated uid.
   * @param {SessionContext} expectedContext Expected context.
   * @param {Date} now Backend time.
   * @param {boolean} advanceHint Whether to consume a hint.
   * @return {Promise<SessionMutationResult>} Result.
   */
  private async mutate(
    sessionId: string,
    uid: string,
    expectedContext: SessionContext,
    now: Date,
    advanceHint: boolean,
  ): Promise<SessionMutationResult> {
    const session =
      this.sessions.get(
        sessionId,
      );

    if (!session) {
      return {
        ok: false,
        code: "SESSION_NOT_FOUND",
      };
    }

    if (session.uid !== uid) {
      return {
        ok: false,
        code: "SESSION_FORBIDDEN",
      };
    }

    if (
      !sameContext(
        session.context,
        expectedContext,
      )
    ) {
      return {
        ok: false,
        code: "SESSION_CONTEXT_MISMATCH",
      };
    }

    if (
      session.expiresAt.getTime() <=
      now.getTime()
    ) {
      return {
        ok: false,
        code: "SESSION_EXPIRED",
      };
    }

    if (
      advanceHint &&
      session.hintLevel >=
      MAX_HINT_LEVEL
    ) {
      return {
        ok: false,
        code: "HINT_LIMIT_REACHED",
      };
    }

    const hintLevel =
      advanceHint ?
        session.hintLevel + 1 :
        session.hintLevel;

    const updated:
    TutorSession = {
      ...session,
      hintLevel,
      lastInteractionAt: now,
      expiresAt: new Date(
        now.getTime() +
        SESSION_IDLE_TIMEOUT_MS,
      ),
    };

    this.sessions.set(
      sessionId,
      updated,
    );

    return {
      ok: true,
      session: updated,
    };
  }
}

/**
 * Compares test session contexts.
 *
 * @param {SessionContext} left First context.
 * @param {SessionContext} right Second context.
 * @return {boolean} Whether contexts match.
 */
function sameContext(
  left: SessionContext,
  right: SessionContext,
): boolean {
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
    return (
      left.attemptId ===
      right.attemptId
    );
  }

  return false;
}

const questionContext:
SessionContext = {
  contextType: "question",
  lessonId:
    "limites_indeterminacao_01",
  questionId: "q014",
};

test("creates opaque unpredictable session ids", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date(
      "2026-08-27T00:00:00Z",
    );

  const first =
    await service.createSession(
      "uid_a",
      questionContext,
      now,
    );

  const second =
    await service.createSession(
      "uid_a",
      questionContext,
      now,
    );

  assert.match(
    first.sessionId,
    /^sess_[A-Za-z0-9_-]+$/,
  );

  assert.notEqual(
    first.sessionId,
    second.sessionId,
  );
});

test("new sessions expire after 30 minutes", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date(
      "2026-08-27T00:00:00Z",
    );

  const session =
    await service.createSession(
      "uid_a",
      questionContext,
      now,
    );

  assert.equal(
    session.expiresAt.getTime() -
      now.getTime(),
    SESSION_IDLE_TIMEOUT_MS,
  );

  assert.equal(
    session.hintLevel,
    0,
  );
});

test("first hint session starts directly at level one", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const session =
    await service
      .createSessionForFirstHint(
        "uid_a",
        questionContext,
        new Date(
          "2026-08-27T00:00:00Z",
        ),
      );

  assert.equal(
    session.hintLevel,
    1,
  );
});

test("rejects a session from another user", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date(
      "2026-08-27T00:00:00Z",
    );

  const session =
    await service.createSession(
      "uid_a",
      questionContext,
      now,
    );

  const result =
    await service.touchSession(
      session.sessionId,
      "uid_b",
      questionContext,
      now,
    );

  assert.deepEqual(
    result,
    {
      ok: false,
      code:
        "SESSION_FORBIDDEN",
    },
  );
});

test("rejects an expired session", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date(
      "2026-08-27T00:00:00Z",
    );

  const session =
    await service.createSession(
      "uid_a",
      questionContext,
      now,
    );

  const result =
    await service.touchSession(
      session.sessionId,
      "uid_a",
      questionContext,
      new Date(
        now.getTime() +
        SESSION_IDLE_TIMEOUT_MS,
      ),
    );

  assert.deepEqual(
    result,
    {
      ok: false,
      code:
        "SESSION_EXPIRED",
    },
  );
});

test("rejects a mismatched question context", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date(
      "2026-08-27T00:00:00Z",
    );

  const session =
    await service.createSession(
      "uid_a",
      questionContext,
      now,
    );

  const result =
    await service.touchSession(
      session.sessionId,
      "uid_a",
      {
        contextType:
          "question",
        lessonId:
          "limites_indeterminacao_01",
        questionId: "q015",
      },
      now,
    );

  assert.deepEqual(
    result,
    {
      ok: false,
      code:
        "SESSION_CONTEXT_MISMATCH",
    },
  );
});

test("supports attempt-bound sessions", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const context:
  SessionContext = {
    contextType: "attempt",
    attemptId: "attempt_123",
  };

  const now =
    new Date(
      "2026-08-27T00:00:00Z",
    );

  const session =
    await service.createSession(
      "uid_a",
      context,
      now,
    );

  const result =
    await service.touchSession(
      session.sessionId,
      "uid_a",
      context,
      new Date(
        now.getTime() + 1000,
      ),
    );

  assert.equal(
    result.ok,
    true,
  );
});

test("progresses through exactly three hints", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date(
      "2026-08-27T00:00:00Z",
    );

  const session =
    await service
      .createSessionForFirstHint(
        "uid_a",
        questionContext,
        now,
      );

  const second =
    await service.requestNextHint(
      session.sessionId,
      "uid_a",
      questionContext,
      new Date(
        now.getTime() + 1000,
      ),
    );

  assert.equal(
    second.ok,
    true,
  );

  const third =
    await service.requestNextHint(
      session.sessionId,
      "uid_a",
      questionContext,
      new Date(
        now.getTime() + 2000,
      ),
    );

  assert.equal(
    third.ok,
    true,
  );

  const fourth =
    await service.requestNextHint(
      session.sessionId,
      "uid_a",
      questionContext,
      new Date(
        now.getTime() + 3000,
      ),
    );

  assert.deepEqual(
    fourth,
    {
      ok: false,
      code:
        "HINT_LIMIT_REACHED",
    },
  );
});

test("each hint refreshes session expiration", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date(
      "2026-08-27T00:00:00Z",
    );

  const session =
    await service
      .createSessionForFirstHint(
        "uid_a",
        questionContext,
        now,
      );

  const interaction =
    new Date(
      now.getTime() +
      10_000,
    );

  const result =
    await service.requestNextHint(
      session.sessionId,
      "uid_a",
      questionContext,
      interaction,
    );

  assert.equal(
    result.ok,
    true,
  );

  if (result.ok) {
    assert.equal(
      result.session
        .expiresAt
        .getTime(),
      interaction.getTime() +
        SESSION_IDLE_TIMEOUT_MS,
    );
  }
});

test("non-hint use refreshes expiration without consuming a hint", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date(
      "2026-08-27T00:00:00Z",
    );

  const session =
    await service
      .createSessionForFirstHint(
        "uid_a",
        questionContext,
        now,
      );

  const interaction =
    new Date(
      now.getTime() +
      20_000,
    );

  const result =
    await service.touchSession(
      session.sessionId,
      "uid_a",
      questionContext,
      interaction,
    );

  assert.equal(
    result.ok,
    true,
  );

  if (result.ok) {
    assert.equal(
      result.session.hintLevel,
      1,
    );

    assert.equal(
      result.session
        .lastInteractionAt
        .getTime(),
      interaction.getTime(),
    );

    assert.equal(
      result.session
        .expiresAt
        .getTime(),
      interaction.getTime() +
        SESSION_IDLE_TIMEOUT_MS,
    );
  }
});
