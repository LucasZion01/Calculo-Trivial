export type TutorModelActionType =
  | "request_hint"
  | "view_steps"
  | "explain_error"
  | "create_similar"
  | "recommend_review";

export interface TutorModelOption {
  id: string;
  text: string;
}

export interface TutorModelReferenceKey {
  sourceId: string;
  sectionId: string;
}

export interface TutorModelQuestionContext {
  lessonId: string;
  questionId: string;
  subject: string;
  statement: string;
  options: TutorModelOption[];
  contentVersion: string;
  allowedReferenceKeys: TutorModelReferenceKey[];
}

export interface TutorModelAttemptContext {
  selectedOptionId: string;
  isCorrect: boolean;
}

export interface TutorModelRequest {
  actionType: TutorModelActionType;
  userMessage?: string;
  hintLevel?: 1 | 2 | 3;
  question?: TutorModelQuestionContext;
  attempt?: TutorModelAttemptContext;
  reviewTopics?: string[];
}

export interface GeminiUsageMetrics {
  promptTokenCount: number | null;
  candidatesTokenCount: number | null;
  totalTokenCount: number | null;
}

export interface GeminiInvocationMetrics
extends GeminiUsageMetrics {
  latencyMs: number;
}

export type GeminiFailureCode =
  | "TIMEOUT"
  | "UNAVAILABLE"
  | "EMPTY_RESPONSE";

export type GeminiTutorResult =
  | {
    ok: true;
    rawResponse: string;
    metrics: GeminiInvocationMetrics;
  }
  | {
    ok: false;
    code: GeminiFailureCode;
    metrics: GeminiInvocationMetrics;
  };
