import assert from "node:assert/strict";
import test from "node:test";

import {
  SessionStore,
} from "./SessionStore";
import {
  TutorSessionService,
} from "./TutorSessionService";
import {
  MAX_HINT_LEVEL,
  SESSION_IDLE_TIMEOUT_MS,
  SessionContext,
  SessionMutationResult,
  TutorSession,
} from "./sessionTypes";

/**
 * In-memory atomic store used only by unit tests.
 */
class MemorySessionStore
implements SessionStore {
  private readonly sessions =
    new Map<string, TutorSession>();

  /**
   * Stores a session.
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
      structuredClone(session),
    );
  }

  /**
   * Atomically advances a session for unit tests.
   *
   * @param {string} sessionId Session id.
   * @param {string} uid Authenticated uid.
   * @param {SessionContext} context Expected context.
   * @param {Date} now Backend time.
   * @return {Promise<SessionMutationResult>} Result.
   */
  async advanceHintAtomically(
    sessionId: string,
    uid: string,
    context: SessionContext,
    now: Date,
  ): Promise<SessionMutationResult> {
    const session =
      this.sessions.get(sessionId);

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
      JSON.stringify(session.context) !==
      JSON.stringify(context)
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
      session.hintLevel >=
      MAX_HINT_LEVEL
    ) {
      return {
        ok: false,
        code: "HINT_LIMIT_REACHED",
      };
    }

    const updated: TutorSession = {
      ...session,
      hintLevel:
        session.hintLevel + 1,
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

const questionContext:
SessionContext = {
  contextType: "question",
  lessonId:
    "limites_indeterminacao_01",
  questionId:
    "limites_q_014",
};

test("creates opaque unpredictable session ids", async () => {
  const store =
    new MemorySessionStore();

  const service =
    new TutorSessionService(store);

  const now =
    new Date("2026-08-26T12:00:00Z");

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
    new Date("2026-08-26T12:00:00Z");

  const session =
    await service.createSession(
      "uid_a",
      questionContext,
      now,
    );

  assert.equal(
    session.expiresAt.getTime() -
    session.lastInteractionAt.getTime(),
    SESSION_IDLE_TIMEOUT_MS,
  );
});

test("rejects a session from another user", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date("2026-08-26T12:00:00Z");

  const session =
    await service.createSession(
      "uid_owner",
      questionContext,
      now,
    );

  const result =
    await service.requestNextHint(
      session.sessionId,
      "uid_other",
      questionContext,
      new Date(
        now.getTime() + 1000,
      ),
    );

  assert.deepEqual(
    result,
    {
      ok: false,
      code: "SESSION_FORBIDDEN",
    },
  );
});

test("rejects an expired session", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date("2026-08-26T12:00:00Z");

  const session =
    await service.createSession(
      "uid_a",
      questionContext,
      now,
    );

  const result =
    await service.requestNextHint(
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
      code: "SESSION_EXPIRED",
    },
  );
});

test("rejects a mismatched question context", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date("2026-08-26T12:00:00Z");

  const session =
    await service.createSession(
      "uid_a",
      questionContext,
      now,
    );

  const result =
    await service.requestNextHint(
      session.sessionId,
      "uid_a",
      {
        contextType: "question",
        lessonId:
          "limites_indeterminacao_01",
        questionId:
          "limites_q_015",
      },
      new Date(
        now.getTime() + 1000,
      ),
    );

  assert.deepEqual(
    result,
    {
      ok: false,
      code: "SESSION_CONTEXT_MISMATCH",
    },
  );
});

test("supports attempt-bound sessions", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const now =
    new Date("2026-08-26T12:00:00Z");

  const context:
  SessionContext = {
    contextType: "attempt",
    attemptId: "attempt_123",
  };

  const session =
    await service.createSession(
      "uid_a",
      context,
      now,
    );

  assert.deepEqual(
    session.context,
    context,
  );
});

test("progresses through exactly three hints", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const start =
    new Date("2026-08-26T12:00:00Z");

  const session =
    await service.createSession(
      "uid_a",
      questionContext,
      start,
    );

  for (
    let expectedLevel = 1;
    expectedLevel <= 3;
    expectedLevel += 1
  ) {
    const result =
      await service.requestNextHint(
        session.sessionId,
        "uid_a",
        questionContext,
        new Date(
          start.getTime() +
          expectedLevel * 1000,
        ),
      );

    assert.equal(
      result.ok,
      true,
    );

    if (result.ok) {
      assert.equal(
        result.session.hintLevel,
        expectedLevel,
      );
    }
  }

  const fourth =
    await service.requestNextHint(
      session.sessionId,
      "uid_a",
      questionContext,
      new Date(
        start.getTime() + 4000,
      ),
    );

  assert.deepEqual(
    fourth,
    {
      ok: false,
      code: "HINT_LIMIT_REACHED",
    },
  );
});

test("each hint refreshes session expiration", async () => {
  const service =
    new TutorSessionService(
      new MemorySessionStore(),
    );

  const start =
    new Date("2026-08-26T12:00:00Z");

  const session =
    await service.createSession(
      "uid_a",
      questionContext,
      start,
    );

  const interaction =
    new Date(
      start.getTime() + 60_000,
    );

  const result =
    await service.requestNextHint(
      session.sessionId,
      "uid_a",
      questionContext,
      interaction,
    );

  assert.equal(result.ok, true);

  if (result.ok) {
    assert.equal(
      result.session.expiresAt.getTime(),
      interaction.getTime() +
      SESSION_IDLE_TIMEOUT_MS,
    );
  }
});
