export const SESSION_IDLE_TIMEOUT_MS =
  30 * 60 * 1000;

export const MAX_HINT_LEVEL = 3;

export type SessionContext =
  | {
    contextType: "question";
    lessonId: string;
    questionId: string;
  }
  | {
    contextType: "attempt";
    attemptId: string;
  };

export interface TutorSession {
  sessionId: string;
  uid: string;
  context: SessionContext;
  createdAt: Date;
  lastInteractionAt: Date;
  expiresAt: Date;
  hintLevel: number;
}

export type SessionMutationResult =
  | {
    ok: true;
    session: TutorSession;
  }
  | {
    ok: false;
    code:
      | "SESSION_NOT_FOUND"
      | "SESSION_FORBIDDEN"
      | "SESSION_EXPIRED"
      | "SESSION_CONTEXT_MISMATCH"
      | "HINT_LIMIT_REACHED";
  };
