import assert from "node:assert/strict";
import test from "node:test";

import {tutorRequestSchema} from "./inputSchemas";
import {
  geminiInternalResponseSchema,
  tutorBackendResponseSchema,
} from "./responseSchemas";

const REQUEST_ID = "550e8400-e29b-41d4-a716-446655440000";

test("accepts a valid request_hint payload", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: REQUEST_ID,
    tutorSessionId: null,
    actionType: "request_hint",
    lessonId: "limites_indeterminacao_01",
    questionId: "limites_q_014",
    userMessage: "  Não entendi como começar.  ",
  });

  assert.equal(result.success, true);

  if (result.success) {
    assert.equal(
      result.data.userMessage,
      "Não entendi como começar.",
    );
  }
});

test("rejects an invalid UUID", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: "not-a-uuid",
    actionType: "recommend_review",
  });

  assert.equal(result.success, false);
});

test("rejects unknown properties", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: REQUEST_ID,
    actionType: "request_hint",
    lessonId: "lesson_01",
    questionId: "question_01",
    extraField: true,
  });

  assert.equal(result.success, false);
});

test("rejects attemptId for request_hint", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: REQUEST_ID,
    actionType: "request_hint",
    lessonId: "lesson_01",
    questionId: "question_01",
    attemptId: "attempt_01",
  });

  assert.equal(result.success, false);
});

test("explain_error accepts attemptId only as its context id", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: REQUEST_ID,
    actionType: "explain_error",
    attemptId: "attempt_01",
  });

  assert.equal(result.success, true);
});

test("explain_error rejects client-supplied lesson context", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: REQUEST_ID,
    actionType: "explain_error",
    attemptId: "attempt_01",
    lessonId: "lesson_01",
  });

  assert.equal(result.success, false);
});

test("recommend_review rejects tutorSessionId", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: REQUEST_ID,
    actionType: "recommend_review",
    tutorSessionId: "sess_123",
  });

  assert.equal(result.success, false);
});

test("rejects blank userMessage after trim", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: REQUEST_ID,
    actionType: "recommend_review",
    userMessage: "   ",
  });

  assert.equal(result.success, false);
});

test("rejects disallowed control characters", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: REQUEST_ID,
    actionType: "recommend_review",
    userMessage: "texto\u0000inválido",
  });

  assert.equal(result.success, false);
});

test("accepts mathematical comparison operators", () => {
  const result = tutorRequestSchema.safeParse({
    schemaVersion: "1.0",
    clientRequestId: REQUEST_ID,
    actionType: "recommend_review",
    userMessage: "Se x < 2 ou x > 5, o que acontece?",
  });

  assert.equal(result.success, true);
});

test("validates the internal Gemini response contract", () => {
  const result = geminiInternalResponseSchema.safeParse({
    responseType: "hint",
    title: "Fatoração e indeterminação",
    message: "Observe como o numerador pode ser fatorado.",
    steps: [],
    checkQuestion: "Como podemos fatorar x² − 4?",
    referenceKeys: [
      {
        sourceId: "stewart_calculo_v1_8ed",
        sectionId: "limites_continuidade",
      },
    ],
    suggestedAction: "request_hint",
  });

  assert.equal(result.success, true);
});

test("requires every internal Gemini response field", () => {
  const result = geminiInternalResponseSchema.safeParse({
    responseType: "hint",
    title: "Título",
    message: "Mensagem",
    steps: [],
    referenceKeys: [],
    suggestedAction: "request_hint",
  });

  assert.equal(result.success, false);
});

test("accepts the controlled unavailable response", () => {
  const result = tutorBackendResponseSchema.safeParse({
    schemaVersion: "1.0",
    status: "unavailable",
    interactionId: "int_7891011_err",
    tutorSessionId: null,
    contentFormat: "plain_text",
    responseType: "system_message",
    title: "Tutor indisponível",
    message: "Não foi possível analisar sua dúvida neste momento.",
    steps: [],
    checkQuestion: "",
    references: [],
    suggestedAction: "retry",
    error: {
      code: "TUTOR_TEMPORARILY_UNAVAILABLE",
      retryable: true,
    },
  });

  assert.equal(result.success, true);
});
