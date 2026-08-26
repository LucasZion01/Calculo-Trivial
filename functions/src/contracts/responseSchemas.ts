import {z} from "zod";

import {
  boundedSafeTextSchema,
  nonEmptySafeTextSchema,
} from "./commonSchemas";

export const responseTypeSchema = z.enum([
  "hint",
  "error_explanation",
  "step_by_step",
  "similar_exercise",
  "review_recommendation",
  "system_message",
]);

export const suggestedActionSchema = z.enum([
  "request_hint",
  "view_steps",
  "try_similar",
  "recommend_review",
  "continue",
  "retry",
  "close",
]);

const titleSchema = boundedSafeTextSchema({
  min: 1,
  max: 60,
});

const messageSchema = boundedSafeTextSchema({
  min: 1,
  max: 600,
});

const stepSchema = boundedSafeTextSchema({
  min: 1,
  max: 200,
});

const checkQuestionSchema = boundedSafeTextSchema({
  min: 0,
  max: 150,
});

const referenceKeySchema = z.object({
  sourceId: nonEmptySafeTextSchema,
  sectionId: nonEmptySafeTextSchema,
}).strict();

export const geminiInternalResponseSchema = z.object({
  responseType: responseTypeSchema,
  title: titleSchema,
  message: messageSchema,
  steps: z.array(stepSchema).max(5),
  checkQuestion: checkQuestionSchema,
  referenceKeys: z.array(referenceKeySchema).max(2),
  suggestedAction: suggestedActionSchema,
}).strict();

const resolvedReferenceSchema = z.object({
  sourceId: nonEmptySafeTextSchema,
  displayText: nonEmptySafeTextSchema,
  section: nonEmptySafeTextSchema,
}).strict();

const successResponseSchema = z.object({
  schemaVersion: z.literal("1.0"),
  status: z.literal("ok"),
  interactionId: nonEmptySafeTextSchema,
  tutorSessionId: nonEmptySafeTextSchema,
  contentFormat: z.literal("plain_text"),
  responseType: responseTypeSchema,
  title: titleSchema,
  message: messageSchema,
  steps: z.array(stepSchema).max(5),
  checkQuestion: checkQuestionSchema,
  references: z.array(resolvedReferenceSchema).max(2),
  suggestedAction: suggestedActionSchema,
  error: z.null(),
}).strict();

const emptyArraySchema = z.array(z.never()).length(0);

const unavailableResponseSchema = z.object({
  schemaVersion: z.literal("1.0"),
  status: z.literal("unavailable"),
  interactionId: nonEmptySafeTextSchema,
  tutorSessionId: z.null(),
  contentFormat: z.literal("plain_text"),
  responseType: z.literal("system_message"),
  title: z.literal("Tutor indisponível"),
  message: z.literal(
    "Não foi possível analisar sua dúvida neste momento.",
  ),
  steps: emptyArraySchema,
  checkQuestion: z.literal(""),
  references: emptyArraySchema,
  suggestedAction: z.literal("retry"),
  error: z.object({
    code: z.literal("TUTOR_TEMPORARILY_UNAVAILABLE"),
    retryable: z.literal(true),
  }).strict(),
}).strict();

export const tutorBackendResponseSchema = z.discriminatedUnion(
  "status",
  [
    successResponseSchema,
    unavailableResponseSchema,
  ],
);
