import assert from "node:assert/strict";
import test from "node:test";

import {
  ContentRepository,
} from "../content/ContentRepository";
import {
  LessonContent,
  TutorQuestion,
} from "../content/contentTypes";
import {
  RequestHintInput,
  TutorBackendResponse,
} from "../contracts/types";
import {
  GeminiTutorResult,
  TutorModelRequest,
} from "../gemini/geminiTypes";
import {
  IdempotencyClaim,
  IdempotencyClaimResult,
} from "../idempotency/idempotencyTypes";
import {
  RateLimitResult,
} from "../rateLimit/rateLimitTypes";
import {
  SessionContext,
  SessionMutationResult,
  TutorSession,
} from "../sessions/sessionTypes";
import {
  GeminiGateway,
  IdempotencyGateway,
  RateLimitGateway,
  SessionGateway,
  TutorOrchestrator,
  TutorOrchestratorError,
} from "./TutorOrchestrator";

const now =
  new Date(
    "2026-08-27T03:00:00Z",
  );

const question:
TutorQuestion = {
  contentVersion: "1.0.0",
  lessonId:
    "limites_indeterminacao_01",
  questionId: "q014",
  subject: "Limites",
  statement:
    "Calcule lim x→2 de (x²−4)/(x−2).",
  options: [
    {
      id: "a",
      text: "0",
    },
    {
      id: "b",
      text: "2",
    },
    {
      id: "c",
      text: "4",
    },
  ],
  correctOptionId: "c",
  originalExplanation:
    "Fatore x²−4.",
  references: [
    {
      sourceId:
        "stewart_calculo_v1_8ed",
      sectionId:
        "limites_continuidade",
    },
  ],
};

const lesson:
LessonContent = {
  contentVersion: "1.0.0",
  lessonId:
    question.lessonId,
  subject: "Limites",
  questions: [
    question,
  ],
};

const validHintRaw =
  JSON.stringify({
    responseType: "hint",
    title: "Pista",
    message:
      "Observe a diferença de quadrados.",
    steps: [],
    checkQuestion:
      "Como fatorar x²−4?",
    referenceKeys: [
      {
        sourceId:
          "stewart_calculo_v1_8ed",
        sectionId:
          "limites_continuidade",
      },
    ],
    suggestedAction:
      "continue",
  });

const validStepsRaw =
  JSON.stringify({
    responseType:
      "step_by_step",
    title: "Passos",
    message:
      "Comece identificando a fatoração.",
    steps: [
      "Reconheça uma diferença de quadrados.",
    ],
    checkQuestion: "",
    referenceKeys: [],
    suggestedAction:
      "continue",
  });

const validSimilarRaw =
  JSON.stringify({
    responseType:
      "similar_exercise",
    title:
      "Exercício semelhante",
    message:
      "Calcule lim x→3 de (x²−9)/(x−3).",
    steps: [],
    checkQuestion: "",
    referenceKeys: [],
    suggestedAction:
      "continue",
  });

const successResponse:
TutorBackendResponse = {
  schemaVersion: "1.0",
  status: "ok",
  interactionId:
    "int_cached",
  tutorSessionId:
    "sess_cached",
  contentFormat:
    "plain_text",
  responseType: "hint",
  title: "Cache",
  message:
    "Resposta anterior.",
  steps: [],
  checkQuestion: "",
  references: [],
  suggestedAction:
    "continue",
  error: null,
};

interface TestState {
  rateCalls: number;
  geminiCalls: number;
  completed: number;
  abandoned: number;
  createdFirstHint: number;
  createdSession: number;
  touched: number;
  advanced: number;
  lastModelRequest:
    TutorModelRequest | null;
}

interface TestDependencies {
  contentRepository:
    ContentRepository;
  idempotency:
    IdempotencyGateway;
  rateLimit:
    RateLimitGateway;
  sessions:
    SessionGateway;
  gemini:
    GeminiGateway;
}

/**
 * Builds deterministic orchestrator fakes.
 *
 * @param {object} options Optional behavior overrides.
 * @return {object} Dependencies and mutable test state.
 */
function createTestEnvironment(
  options: {
    idempotencyResult?:
      IdempotencyClaimResult;
    rateResult?:
      RateLimitResult;
    geminiResult?:
      GeminiTutorResult;
    questionExists?:
      boolean;
  } = {},
): {
  dependencies:
    TestDependencies;
  state: TestState;
} {
  const state:
  TestState = {
    rateCalls: 0,
    geminiCalls: 0,
    completed: 0,
    abandoned: 0,
    createdFirstHint: 0,
    createdSession: 0,
    touched: 0,
    advanced: 0,
    lastModelRequest: null,
  };

  const claim:
  IdempotencyClaim = {
    recordId: "record_1",
    claimToken: "token_1",
    expiresAt:
      new Date(
        now.getTime() +
        86_400_000,
      ),
  };

  const dependencies:
  TestDependencies = {
    contentRepository: {
      async getLesson(
        lessonId: string,
      ): Promise<LessonContent | null> {
        return (
          lessonId === lesson.lessonId ?
            lesson :
            null
        );
      },

      async getQuestion(
        lessonId: string,
        questionId: string,
      ): Promise<TutorQuestion | null> {
        if (
          options.questionExists ===
          false
        ) {
          return null;
        }

        if (
          lessonId ===
            question.lessonId &&
          questionId ===
            question.questionId
        ) {
          return question;
        }

        return null;
      },

      async questionBelongsToLesson(
        lessonId: string,
        questionId: string,
      ): Promise<boolean> {
        return (
          lessonId ===
            question.lessonId &&
          questionId ===
            question.questionId
        );
      },
    },

    idempotency: {
      async claim():
      Promise<IdempotencyClaimResult> {
        return (
          options.idempotencyResult ??
          {
            status: "acquired",
            claim,
          }
        );
      },

      async complete():
      Promise<void> {
        state.completed += 1;
      },

      async abandon():
      Promise<void> {
        state.abandoned += 1;
      },
    },

    rateLimit: {
      async consume():
      Promise<RateLimitResult> {
        state.rateCalls += 1;

        return (
          options.rateResult ??
          {
            allowed: true,
            remainingMinute: 9,
            remainingDaily: 99,
          }
        );
      },
    },

    sessions: {
      async createSession(
        uid: string,
        context: SessionContext,
        interactionTime: Date,
      ): Promise<TutorSession> {
        state.createdSession += 1;

        return buildSession(
          uid,
          context,
          interactionTime,
          0,
        );
      },

      async createSessionForFirstHint(
        uid: string,
        context: SessionContext,
        interactionTime: Date,
      ): Promise<TutorSession> {
        state.createdFirstHint += 1;

        return buildSession(
          uid,
          context,
          interactionTime,
          1,
        );
      },

      async requestNextHint(
        sessionId: string,
        uid: string,
        context: SessionContext,
        interactionTime: Date,
      ): Promise<SessionMutationResult> {
        state.advanced += 1;

        return {
          ok: true,
          session: {
            ...buildSession(
              uid,
              context,
              interactionTime,
              2,
            ),
            sessionId,
          },
        };
      },

      async touchSession(
        sessionId: string,
        uid: string,
        context: SessionContext,
        interactionTime: Date,
      ): Promise<SessionMutationResult> {
        state.touched += 1;

        return {
          ok: true,
          session: {
            ...buildSession(
              uid,
              context,
              interactionTime,
              1,
            ),
            sessionId,
          },
        };
      },
    },

    gemini: {
      async generate(
        modelRequest:
          TutorModelRequest,
      ): Promise<GeminiTutorResult> {
        state.geminiCalls += 1;

        state.lastModelRequest =
          modelRequest;

        return (
          options.geminiResult ??
          {
            ok: true,
            rawResponse:
              validHintRaw,
            metrics: {
              latencyMs: 1,
              promptTokenCount:
                null,
              candidatesTokenCount:
                null,
              totalTokenCount:
                null,
            },
          }
        );
      },
    },
  };

  return {
    dependencies,
    state,
  };
}

/**
 * Builds one deterministic session.
 *
 * @param {string} uid User id.
 * @param {SessionContext} context Session context.
 * @param {Date} interactionTime Interaction time.
 * @param {number} hintLevel Hint level.
 * @return {TutorSession} Session.
 */
function buildSession(
  uid: string,
  context: SessionContext,
  interactionTime: Date,
  hintLevel: number,
): TutorSession {
  return {
    sessionId:
      "sess_test",
    uid,
    context,
    createdAt:
      interactionTime,
    lastInteractionAt:
      interactionTime,
    expiresAt:
      new Date(
        interactionTime.getTime() +
        1_800_000,
      ),
    hintLevel,
  };
}

/**
 * Builds a valid request_hint input.
 *
 * @return {TutorRequest} Request.
 */
function buildHintRequest():
RequestHintInput {
  return {
    schemaVersion: "1.0",
    clientRequestId:
      "550e8400-e29b-41d4-a716-446655440000",
    actionType:
      "request_hint",
    lessonId:
      question.lessonId,
    questionId:
      question.questionId,
  };
}

test("cached idempotent response bypasses rate limit and Gemini", async () => {
  const environment =
    createTestEnvironment({
      idempotencyResult: {
        status: "completed",
        response:
          successResponse,
      },
    });

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  const result =
    await orchestrator.execute(
      "uid_a",
      buildHintRequest(),
      now,
    );

  assert.deepEqual(
    result,
    successResponse,
  );

  assert.equal(
    environment.state.rateCalls,
    0,
  );

  assert.equal(
    environment.state.geminiCalls,
    0,
  );
});

test("rate-limit failure releases idempotency claim", async () => {
  const environment =
    createTestEnvironment({
      rateResult: {
        allowed: false,
        code:
          "MINUTE_LIMIT_EXCEEDED",
        retryAfterMs: 5000,
      },
    });

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  await assert.rejects(
    () =>
      orchestrator.execute(
        "uid_a",
        buildHintRequest(),
        now,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof
          TutorOrchestratorError,
      );

      assert.equal(
        error.code,
        "RATE_LIMITED",
      );

      assert.equal(
        error.retryAfterMs,
        5000,
      );

      return true;
    },
  );

  assert.equal(
    environment.state.abandoned,
    1,
  );
});

test("first hint creates level-one session", async () => {
  const environment =
    createTestEnvironment();

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  const result =
    await orchestrator.execute(
      "uid_a",
      buildHintRequest(),
      now,
    );

  assert.equal(
    result.status,
    "ok",
  );

  assert.equal(
    environment.state
      .createdFirstHint,
    1,
  );

  assert.equal(
    environment.state.completed,
    1,
  );

  assert.equal(
    environment.state
      .lastModelRequest
      ?.hintLevel,
    1,
  );
});

test("existing hint session advances instead of creating", async () => {
  const environment =
    createTestEnvironment();

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  await orchestrator.execute(
    "uid_a",
    {
      ...buildHintRequest(),
      tutorSessionId:
        "sess_existing",
    },
    now,
  );

  assert.equal(
    environment.state.advanced,
    1,
  );

  assert.equal(
    environment.state
      .createdFirstHint,
    0,
  );

  assert.equal(
    environment.state
      .lastModelRequest
      ?.hintLevel,
    2,
  );
});

test("view_steps refreshes existing session without hint advance", async () => {
  const environment =
    createTestEnvironment({
      geminiResult: {
        ok: true,
        rawResponse:
          validStepsRaw,
        metrics: {
          latencyMs: 1,
          promptTokenCount: null,
          candidatesTokenCount:
            null,
          totalTokenCount: null,
        },
      },
    });

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  const result =
    await orchestrator.execute(
      "uid_a",
      {
        schemaVersion: "1.0",
        clientRequestId:
          "550e8400-e29b-41d4-a716-446655440001",
        actionType:
          "view_steps",
        lessonId:
          question.lessonId,
        questionId:
          question.questionId,
        tutorSessionId:
          "sess_existing",
      },
      now,
    );

  assert.equal(
    result.status,
    "ok",
  );

  assert.equal(
    environment.state.touched,
    1,
  );

  assert.equal(
    environment.state.advanced,
    0,
  );
});

test("question lookup failure releases idempotency claim", async () => {
  const environment =
    createTestEnvironment({
      questionExists: false,
    });

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  await assert.rejects(
    () =>
      orchestrator.execute(
        "uid_a",
        buildHintRequest(),
        now,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof
          TutorOrchestratorError,
      );

      assert.equal(
        error.code,
        "QUESTION_NOT_FOUND",
      );

      return true;
    },
  );

  assert.equal(
    environment.state.abandoned,
    1,
  );
});

test("unauthorized model reference becomes unavailable", async () => {
  const environment =
    createTestEnvironment({
      geminiResult: {
        ok: true,
        rawResponse:
          JSON.stringify({
            responseType: "hint",
            title: "Pista",
            message:
              "Observe a estrutura.",
            steps: [],
            checkQuestion: "",
            referenceKeys: [
              {
                sourceId:
                  "thomas_calculo_v1_12ed",
                sectionId:
                  "limites_continuidade",
              },
            ],
            suggestedAction:
              "continue",
          }),
        metrics: {
          latencyMs: 1,
          promptTokenCount: null,
          candidatesTokenCount:
            null,
          totalTokenCount: null,
        },
      },
    });

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  const result =
    await orchestrator.execute(
      "uid_a",
      buildHintRequest(),
      now,
    );

  assert.equal(
    result.status,
    "unavailable",
  );

  assert.equal(
    environment.state.completed,
    1,
  );

  assert.equal(
    environment.state.abandoned,
    0,
  );
});

test("explain_error remains blocked until secure attempts exist", async () => {
  const environment =
    createTestEnvironment();

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  await assert.rejects(
    () =>
      orchestrator.execute(
        "uid_a",
        {
          schemaVersion: "1.0",
          clientRequestId:
            "550e8400-e29b-41d4-a716-446655440002",
          actionType:
            "explain_error",
          attemptId:
            "attempt_1",
        },
        now,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof
          TutorOrchestratorError,
      );

      assert.equal(
        error.code,
        "FEATURE_NOT_READY",
      );

      return true;
    },
  );

  assert.equal(
    environment.state.geminiCalls,
    0,
  );

  assert.equal(
    environment.state.abandoned,
    1,
  );
});

test("recommend_review stays blocked without trusted progress", async () => {
  const environment =
    createTestEnvironment();

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  await assert.rejects(
    () =>
      orchestrator.execute(
        "uid_a",
        {
          schemaVersion: "1.0",
          clientRequestId:
            "550e8400-e29b-41d4-a716-446655440003",
          actionType:
            "recommend_review",
        },
        now,
      ),
    (error: unknown) => {
      assert.ok(
        error instanceof
          TutorOrchestratorError,
      );

      assert.equal(
        error.code,
        "FEATURE_NOT_READY",
      );

      return true;
    },
  );

  assert.equal(
    environment.state.geminiCalls,
    0,
  );
});

test("create_similar can use a trusted lesson anchor", async () => {
  const environment =
    createTestEnvironment({
      geminiResult: {
        ok: true,
        rawResponse:
          validSimilarRaw,
        metrics: {
          latencyMs: 1,
          promptTokenCount: null,
          candidatesTokenCount:
            null,
          totalTokenCount: null,
        },
      },
    });

  const orchestrator =
    new TutorOrchestrator(
      environment.dependencies,
    );

  const result =
    await orchestrator.execute(
      "uid_a",
      {
        schemaVersion: "1.0",
        clientRequestId:
          "550e8400-e29b-41d4-a716-446655440004",
        actionType:
          "create_similar",
        lessonId:
          lesson.lessonId,
      },
      now,
    );

  assert.equal(
    result.status,
    "ok",
  );

  assert.equal(
    environment.state
      .createdSession,
    1,
  );

  assert.equal(
    environment.state
      .lastModelRequest
      ?.question
      ?.questionId,
    question.questionId,
  );
});
