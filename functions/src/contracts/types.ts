import {z} from "zod";

import {tutorRequestSchema} from "./inputSchemas";
import {
  geminiInternalResponseSchema,
  tutorBackendResponseSchema,
} from "./responseSchemas";

export type TutorRequest = z.infer<typeof tutorRequestSchema>;

export type RequestHintInput = Extract<
  TutorRequest,
  {actionType: "request_hint"}
>;

export type ViewStepsInput = Extract<
  TutorRequest,
  {actionType: "view_steps"}
>;

export type ExplainErrorInput = Extract<
  TutorRequest,
  {actionType: "explain_error"}
>;

export type CreateSimilarInput = Extract<
  TutorRequest,
  {actionType: "create_similar"}
>;

export type RecommendReviewInput = Extract<
  TutorRequest,
  {actionType: "recommend_review"}
>;

export type GeminiInternalResponse = z.infer<
  typeof geminiInternalResponseSchema
>;

export type TutorBackendResponse = z.infer<
  typeof tutorBackendResponseSchema
>;
