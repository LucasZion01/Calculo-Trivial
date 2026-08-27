import {
  randomBytes,
} from "node:crypto";

import {
  ContentRepository,
} from "../content/ContentRepository";
import {
  TutorQuestion,
} from "../content/contentTypes";
import {
  tutorBackendResponseSchema,
} from "../contracts/responseSchemas";
import {
  CreateSimilarInput,
  RequestHintInput,
  TutorBackendResponse,
  TutorRequest,
  ViewStepsInput,
} from "../contracts/types";
import {
  GeminiTutorResult,
  TutorModelQuestionContext,
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
  buildTutorSuccessResponse,
  validateGeminiRawResponseForContext,
} from "../security/modelResponsePipeline";
import {
  SessionContext,
  SessionMutationResult,
  TutorSession,
} from "../sessions/sessionTypes";

export type TutorOrchestratorErrorCode =
  | "IDEMPOTENCY_IN_PROGRESS"
  | "RATE_LIMITED"
  | "LESSON_NOT_FOUND"
  | "QUESTION_NOT_FOUND"
  | "SESSION_NOT_FOUND"
  | "SESSION_FORBIDDEN"
  | "SESSION_EXPIRED"
  | "SESSION_CONTEXT_MISMATCH"
  | "HINT_LIMIT_REACHED"
  | "FEATURE_NOT_READY";

export interface IdempotencyGateway {
  claim(
    key: {
      uid: string;
      clientRequestId: string;
    },
    now: Date,
  ): Promise<IdempotencyClaimResult>;

  complete(
    claim: IdempotencyClaim,
    response: TutorBackendResponse,
    now: Date,
  ): Promise<void>;

  abandon(
    claim: IdempotencyClaim,
  ): Promise<void>;
}

export interface RateLimitGateway {
  consume(
    uid: string,
    now: Date,
  ): Promise<RateLimitResult>;
}

export interface SessionGateway {
  createSession(
    uid: string,
    context: SessionContext,
    now: Date,
  ): Promise<TutorSession>;

  createSessionForFirstHint(
    uid: string,
    context: SessionContext,
    now: Date,
  ): Promise<TutorSession>;

  requestNextHint(
    sessionId: string,
    uid: string,
    context: SessionContext,
    now: Date,
  ): Promise<SessionMutationResult>;

  touchSession(
    sessionId: string,
    uid: string,
    context: SessionContext,
    now: Date,
  ): Promise<SessionMutationResult>;
}

export interface GeminiGateway {
  generate(
    request: TutorModelRequest,
  ): Promise<GeminiTutorResult>;
}

export interface TutorOrchestratorDependencies {
  contentRepository: ContentRepository;
  idempotency: IdempotencyGateway;
  rateLimit: RateLimitGateway;
  sessions: SessionGateway;
  gemini: GeminiGateway;
}

interface PreparedSession {
  sessionId: string;
  hintLevel: number;
}

type QuestionBackedRequest =
  | RequestHintInput
  | ViewStepsInput
  | CreateSimilarInput;

/**
 * Controlled internal orchestration error.
 */
export class TutorOrchestratorError
  extends Error {
  /**
   * Creates one controlled orchestration error.
   *
   * @param {TutorOrchestratorErrorCode} code Internal error code.
   * @param {number|null} retryAfterMs Optional retry delay.
   */
  constructor(
    public readonly code:
      TutorOrchestratorErrorCode,
    public readonly retryAfterMs:
      number | null = null,
  ) {
    super(code);

    this.name =
      "TutorOrchestratorError";
  }
}

/**
 * Coordinates trusted backend Tutor Trivial operations.
 */
export class TutorOrchestrator {
  /**
   * Creates the orchestrator.
   *
   * @param {TutorOrchestratorDependencies} dependencies Dependencies.
   */
  constructor(
    private readonly dependencies:
      TutorOrchestratorDependencies,
  ) {}

  /**
   * Executes one authenticated tutor request.
   *
   * @param {string} uid Authenticated Firebase uid.
   * @param {TutorRequest} request Validated request.
   * @param {Date} now Backend time.
   * @return {Promise<TutorBackendResponse>} Public response.
   */
  async execute(
    uid: string,
    request: TutorRequest,
    now: Date = new Date(),
  ): Promise<TutorBackendResponse> {
    const idempotency =
      await this.dependencies
        .idempotency
        .claim(
          {
            uid,
            clientRequestId:
              request.clientRequestId,
          },
          now,
        );

    if (
      idempotency.status ===
      "completed"
    ) {
      return idempotency.response;
    }

    if (
      idempotency.status ===
      "processing"
    ) {
      throw new TutorOrchestratorError(
        "IDEMPOTENCY_IN_PROGRESS",
      );
    }

    const claim =
      idempotency.claim;

    try {
      await this.consumeRateLimit(
        uid,
        now,
      );

      const response =
        await this.executeClaimed(
          uid,
          request,
          now,
        );

      await this.dependencies
        .idempotency
        .complete(
          claim,
          response,
          now,
        );

      return response;
    } catch (error: unknown) {
      await this.abandonSafely(
        claim,
      );

      throw error;
    }
  }

  /**
   * Executes a request after idempotency ownership was acquired.
   *
   * @param {string} uid Authenticated uid.
   * @param {TutorRequest} request Request.
   * @param {Date} now Backend time.
   * @return {Promise<TutorBackendResponse>} Response.
   */
  private async executeClaimed(
    uid: string,
    request: TutorRequest,
    now: Date,
  ): Promise<TutorBackendResponse> {
    switch (request.actionType) {
    case "request_hint":
      return this.executeQuestionAction(
        uid,
        request,
        now,
      );

    case "view_steps":
      return this.executeQuestionAction(
        uid,
        request,
        now,
      );

    case "create_similar":
      return this.executeQuestionAction(
        uid,
        request,
        now,
      );

    case "explain_error":
      throw new TutorOrchestratorError(
        "FEATURE_NOT_READY",
      );

    case "recommend_review":
      throw new TutorOrchestratorError(
        "FEATURE_NOT_READY",
      );
    }
  }

  /**
   * Executes an action backed by trusted lesson content.
   *
   * @param {string} uid Authenticated uid.
   * @param {QuestionBackedRequest} request Request.
   * @param {Date} now Backend time.
   * @return {Promise<TutorBackendResponse>} Response.
   */
  private async executeQuestionAction(
    uid: string,
    request: QuestionBackedRequest,
    now: Date,
  ): Promise<TutorBackendResponse> {
    const question =
      await this.loadQuestion(
        request,
      );

    const session =
      await this.prepareSession(
        uid,
        request,
        question,
        now,
      );

    const modelRequest =
      this.buildModelRequest(
        request,
        question,
        session.hintLevel,
      );

    const allowedReferences =
      question.references;

    const interactionId =
      createInteractionId();

    const result =
      await this.dependencies
        .gemini
        .generate(modelRequest);

    if (!result.ok) {
      return buildUnavailableResponse(
        interactionId,
      );
    }

    const validated =
      validateGeminiRawResponseForContext(
        result.rawResponse,
        allowedReferences,
      );

    if (!validated.ok) {
      return buildUnavailableResponse(
        interactionId,
      );
    }

    if (
      !responseTypeMatchesAction(
        request.actionType,
        validated.value.model
          .responseType,
      )
    ) {
      return buildUnavailableResponse(
        interactionId,
      );
    }

    return buildTutorSuccessResponse(
      {
        interactionId,
        tutorSessionId:
          session.sessionId,
      },
      validated.value,
    );
  }

  /**
   * Loads the trusted question for one action.
   *
   * create_similar may omit questionId. In that case the backend picks
   * the first curated lesson question as a trusted concept anchor.
   *
   * @param {QuestionBackedRequest} request Request.
   * @return {Promise<TutorQuestion>} Trusted question.
   */
  private async loadQuestion(
    request: QuestionBackedRequest,
  ): Promise<TutorQuestion> {
    if (
      request.actionType !==
      "create_similar"
    ) {
      const question =
        await this.dependencies
          .contentRepository
          .getQuestion(
            request.lessonId,
            request.questionId,
          );

      if (!question) {
        throw new TutorOrchestratorError(
          "QUESTION_NOT_FOUND",
        );
      }

      return question;
    }

    const lesson =
      await this.dependencies
        .contentRepository
        .getLesson(
          request.lessonId,
        );

    if (!lesson) {
      throw new TutorOrchestratorError(
        "LESSON_NOT_FOUND",
      );
    }

    if (request.questionId) {
      const question =
        await this.dependencies
          .contentRepository
          .getQuestion(
            request.lessonId,
            request.questionId,
          );

      if (!question) {
        throw new TutorOrchestratorError(
          "QUESTION_NOT_FOUND",
        );
      }

      return question;
    }

    const anchor =
      lesson.questions[0];

    if (!anchor) {
      throw new TutorOrchestratorError(
        "QUESTION_NOT_FOUND",
      );
    }

    return anchor;
  }

  /**
   * Creates, advances or refreshes one trusted session.
   *
   * @param {string} uid Authenticated uid.
   * @param {QuestionBackedRequest} request Request.
   * @param {TutorQuestion} question Trusted question.
   * @param {Date} now Backend time.
   * @return {Promise<PreparedSession>} Prepared session.
   */
  private async prepareSession(
    uid: string,
    request: QuestionBackedRequest,
    question: TutorQuestion,
    now: Date,
  ): Promise<PreparedSession> {
    const context:
    SessionContext = {
      contextType: "question",
      lessonId:
        question.lessonId,
      questionId:
        question.questionId,
    };

    const sessionId =
      request.tutorSessionId ??
      null;

    if (
      request.actionType ===
      "request_hint"
    ) {
      if (!sessionId) {
        const created =
          await this.dependencies
            .sessions
            .createSessionForFirstHint(
              uid,
              context,
              now,
            );

        return {
          sessionId:
            created.sessionId,
          hintLevel:
            created.hintLevel,
        };
      }

      const mutation =
        await this.dependencies
          .sessions
          .requestNextHint(
            sessionId,
            uid,
            context,
            now,
          );

      return requireSessionMutation(
        mutation,
      );
    }

    if (!sessionId) {
      const created =
        await this.dependencies
          .sessions
          .createSession(
            uid,
            context,
            now,
          );

      return {
        sessionId:
          created.sessionId,
        hintLevel:
          created.hintLevel,
      };
    }

    const mutation =
      await this.dependencies
        .sessions
        .touchSession(
          sessionId,
          uid,
          context,
          now,
        );

    return requireSessionMutation(
      mutation,
    );
  }

  /**
   * Builds the explicit provider whitelist payload.
   *
   * correctOptionId and originalExplanation are intentionally omitted.
   *
   * @param {QuestionBackedRequest} request Request.
   * @param {TutorQuestion} question Trusted question.
   * @param {number} hintLevel Backend hint level.
   * @return {TutorModelRequest} Safe model request.
   */
  private buildModelRequest(
    request: QuestionBackedRequest,
    question: TutorQuestion,
    hintLevel: number,
  ): TutorModelRequest {
    const modelQuestion =
      buildModelQuestion(
        question,
      );

    const base = {
      actionType:
        request.actionType,
      userMessage:
        request.userMessage,
      question:
        modelQuestion,
    };

    if (
      request.actionType ===
      "request_hint"
    ) {
      return {
        ...base,
        actionType:
          "request_hint",
        hintLevel:
          requireHintLevel(
            hintLevel,
          ),
      };
    }

    if (
      request.actionType ===
      "view_steps"
    ) {
      return {
        ...base,
        actionType:
          "view_steps",
      };
    }

    return {
      ...base,
      actionType:
        "create_similar",
    };
  }

  /**
   * Applies the authenticated per-user rate limit.
   *
   * @param {string} uid Authenticated uid.
   * @param {Date} now Backend time.
   * @return {Promise<void>} Completion promise.
   */
  private async consumeRateLimit(
    uid: string,
    now: Date,
  ): Promise<void> {
    const result =
      await this.dependencies
        .rateLimit
        .consume(
          uid,
          now,
        );

    if (!result.allowed) {
      throw new TutorOrchestratorError(
        "RATE_LIMITED",
        result.retryAfterMs,
      );
    }
  }

  /**
   * Best-effort claim release.
   *
   * The original request error always wins over a cleanup failure.
   *
   * @param {IdempotencyClaim} claim Active claim.
   * @return {Promise<void>} Completion promise.
   */
  private async abandonSafely(
    claim: IdempotencyClaim,
  ): Promise<void> {
    try {
      await this.dependencies
        .idempotency
        .abandon(claim);
    } catch {
      // Cleanup failure is intentionally not exposed.
    }
  }
}

/**
 * Creates an opaque interaction identifier.
 *
 * @return {string} Interaction id.
 */
function createInteractionId():
string {
  return `int_${
    randomBytes(18)
      .toString("base64url")
  }`;
}

/**
 * Converts trusted content to the provider whitelist shape.
 *
 * @param {TutorQuestion} question Trusted question.
 * @return {TutorModelQuestionContext} Safe question context.
 */
function buildModelQuestion(
  question: TutorQuestion,
): TutorModelQuestionContext {
  return {
    lessonId:
      question.lessonId,
    questionId:
      question.questionId,
    subject:
      question.subject,
    statement:
      question.statement,
    options:
      question.options.map(
        (option) => ({
          id: option.id,
          text: option.text,
        }),
      ),
    contentVersion:
      question.contentVersion,
    allowedReferenceKeys:
      question.references.map(
        (reference) => ({
          sourceId:
            reference.sourceId,
          sectionId:
            reference.sectionId,
        }),
      ),
  };
}

/**
 * Converts one successful session mutation.
 *
 * @param {SessionMutationResult} result Mutation.
 * @return {PreparedSession} Prepared session.
 */
function requireSessionMutation(
  result: SessionMutationResult,
): PreparedSession {
  if (!result.ok) {
    throw new TutorOrchestratorError(
      result.code,
    );
  }

  return {
    sessionId:
      result.session.sessionId,
    hintLevel:
      result.session.hintLevel,
  };
}

/**
 * Narrows a backend hint level to the provider contract.
 *
 * @param {number} value Hint level.
 * @return {1|2|3} Valid hint level.
 */
function requireHintLevel(
  value: number,
): 1 | 2 | 3 {
  if (
    value === 1 ||
    value === 2 ||
    value === 3
  ) {
    return value;
  }

  throw new TutorOrchestratorError(
    "HINT_LIMIT_REACHED",
  );
}

/**
 * Ensures the provider response type matches the requested action.
 *
 * @param {string} actionType Requested action.
 * @param {string} responseType Model response type.
 * @return {boolean} Whether the semantic type matches.
 */
function responseTypeMatchesAction(
  actionType:
    QuestionBackedRequest[
      "actionType"
    ],
  responseType: string,
): boolean {
  switch (actionType) {
  case "request_hint":
    return responseType === "hint";

  case "view_steps":
    return (
      responseType ===
      "step_by_step"
    );

  case "create_similar":
    return (
      responseType ===
      "similar_exercise"
    );
  }
}

/**
 * Builds the only pedagogical provider failure response allowed by v1.0.
 *
 * @param {string} interactionId Backend interaction id.
 * @return {TutorBackendResponse} Controlled unavailable response.
 */
function buildUnavailableResponse(
  interactionId: string,
): TutorBackendResponse {
  return tutorBackendResponseSchema
    .parse({
      schemaVersion: "1.0",
      status: "unavailable",
      interactionId,
      tutorSessionId: null,
      contentFormat:
        "plain_text",
      responseType:
        "system_message",
      title:
        "Tutor indispon\u00edvel",
      message:
        "N\u00e3o foi poss\u00edvel analisar sua d\u00favida neste momento.",
      steps: [],
      checkQuestion: "",
      references: [],
      suggestedAction:
        "retry",
      error: {
        code:
          "TUTOR_TEMPORARILY_UNAVAILABLE",
        retryable: true,
      },
    });
}
