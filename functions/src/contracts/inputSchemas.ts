import {z} from "zod";

import {
  clientRequestIdSchema,
  nonEmptySafeTextSchema,
  schemaVersionSchema,
  userMessageSchema,
} from "./commonSchemas";

const tutorSessionIdSchema = nonEmptySafeTextSchema
  .nullable()
  .optional();

const requestHintSchema = z.object({
  schemaVersion: schemaVersionSchema,
  clientRequestId: clientRequestIdSchema,
  actionType: z.literal("request_hint"),
  lessonId: nonEmptySafeTextSchema,
  questionId: nonEmptySafeTextSchema,
  tutorSessionId: tutorSessionIdSchema,
  userMessage: userMessageSchema.optional(),
}).strict();

const viewStepsSchema = z.object({
  schemaVersion: schemaVersionSchema,
  clientRequestId: clientRequestIdSchema,
  actionType: z.literal("view_steps"),
  lessonId: nonEmptySafeTextSchema,
  questionId: nonEmptySafeTextSchema,
  tutorSessionId: tutorSessionIdSchema,
  userMessage: userMessageSchema.optional(),
}).strict();

const explainErrorSchema = z.object({
  schemaVersion: schemaVersionSchema,
  clientRequestId: clientRequestIdSchema,
  actionType: z.literal("explain_error"),
  attemptId: nonEmptySafeTextSchema,
  tutorSessionId: tutorSessionIdSchema,
  userMessage: userMessageSchema.optional(),
}).strict();

const createSimilarSchema = z.object({
  schemaVersion: schemaVersionSchema,
  clientRequestId: clientRequestIdSchema,
  actionType: z.literal("create_similar"),
  lessonId: nonEmptySafeTextSchema,
  questionId: nonEmptySafeTextSchema.optional(),
  tutorSessionId: tutorSessionIdSchema,
  userMessage: userMessageSchema.optional(),
}).strict();

const recommendReviewSchema = z.object({
  schemaVersion: schemaVersionSchema,
  clientRequestId: clientRequestIdSchema,
  actionType: z.literal("recommend_review"),
  userMessage: userMessageSchema.optional(),
}).strict();

export const tutorRequestSchema = z.discriminatedUnion(
  "actionType",
  [
    requestHintSchema,
    viewStepsSchema,
    explainErrorSchema,
    createSimilarSchema,
    recommendReviewSchema,
  ],
);
