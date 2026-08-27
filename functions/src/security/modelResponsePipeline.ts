import {
  GeminiInternalResponse,
  TutorBackendResponse,
} from "../contracts/types";
import {
  geminiInternalResponseSchema,
  tutorBackendResponseSchema,
} from "../contracts/responseSchemas";
import {
  ContentReferenceKey,
} from "../content/contentTypes";
import {
  ResolvedReference,
  resolveReferences,
} from "../data/referenceResolver";

export const MAX_GEMINI_RAW_RESPONSE_BYTES =
  16 * 1024;

const HTML_TAG_PATTERN =
  /<\/?[a-z][^>]*>/i;

const HTML_META_PATTERN =
  /(?:<!doctype|<!--)/i;

const DATA_SCHEME_PATTERN =
  /\bdata\s*:/i;

const JAVASCRIPT_SCHEME_PATTERN =
  /\bjavascript\s*:/i;

const HTTP_URL_PATTERN =
  /\bhttps?:\/\/\S+/i;

const WWW_URL_PATTERN =
  /\bwww\.[^\s]+/i;

const MARKDOWN_IMAGE_PATTERN =
  /!\[[^\]]*]\([^)]*\)/;

const RAW_BASE64_PATTERN =
  /[A-Za-z0-9+/]{128,}={0,2}/;

export type ModelResponseErrorCode =
  | "RAW_RESPONSE_TOO_LARGE"
  | "INVALID_JSON"
  | "INVALID_MODEL_SCHEMA"
  | "DISALLOWED_MODEL_CONTENT"
  | "UNAUTHORIZED_REFERENCE";

export interface ValidatedModelResponse {
  model: GeminiInternalResponse;
  references: ResolvedReference[];
}

export type ModelResponseValidationResult =
  | {
    ok: true;
    value: ValidatedModelResponse;
  }
  | {
    ok: false;
    code: ModelResponseErrorCode;
  };

export interface TutorSuccessContext {
  interactionId: string;
  tutorSessionId: string;
}

/**
 * Checks one textual field for content prohibited by v1.0.
 *
 * Mathematical comparison symbols such as x < 2 and x > 5
 * remain allowed.
 *
 * @param {string} value Text to inspect.
 * @return {boolean} True when prohibited content is found.
 */
function containsDisallowedModelContent(
  value: string,
): boolean {
  return (
    HTML_TAG_PATTERN.test(value) ||
    HTML_META_PATTERN.test(value) ||
    DATA_SCHEME_PATTERN.test(value) ||
    JAVASCRIPT_SCHEME_PATTERN.test(value) ||
    HTTP_URL_PATTERN.test(value) ||
    WWW_URL_PATTERN.test(value) ||
    MARKDOWN_IMAGE_PATTERN.test(value) ||
    RAW_BASE64_PATTERN.test(value)
  );
}

/**
 * Recursively checks every textual field in a validated object.
 *
 * @param {unknown} value Value to inspect.
 * @return {boolean} True when prohibited text is found.
 */
function hasDisallowedText(
  value: unknown,
): boolean {
  if (typeof value === "string") {
    return containsDisallowedModelContent(value);
  }

  if (Array.isArray(value)) {
    return value.some(
      (item) =>
        hasDisallowedText(item),
    );
  }

  if (
    typeof value === "object" &&
    value !== null
  ) {
    return Object.values(value).some(
      (item) =>
        hasDisallowedText(item),
    );
  }

  return false;
}

/**
 * Builds a stable comparison key for one bibliography reference.
 *
 * @param {ContentReferenceKey} reference Reference key.
 * @return {string} Stable key.
 */
function buildReferenceKey(
  reference: ContentReferenceKey,
): string {
  return [
    reference.sourceId,
    reference.sectionId,
  ].join("\u0000");
}

/**
 * Checks whether every model reference was explicitly authorized by
 * the backend context.
 *
 * @param {ContentReferenceKey[]} modelReferences Model keys.
 * @param {ContentReferenceKey[]} allowedReferences Allowed keys.
 * @return {boolean} True only when every model key is allowed.
 */
function referencesAreAuthorized(
  modelReferences:
    readonly ContentReferenceKey[],
  allowedReferences:
    readonly ContentReferenceKey[],
): boolean {
  const allowed =
    new Set(
      allowedReferences.map(
        buildReferenceKey,
      ),
    );

  return modelReferences.every(
    (reference) =>
      allowed.has(
        buildReferenceKey(
          reference,
        ),
      ),
  );
}

/**
 * Performs the common v1.0 validation pipeline.
 *
 * When allowedReferences is null, validation is catalog-only.
 * The production tutor path must use the context-aware exported
 * validator instead.
 *
 * @param {string} rawResponse Raw provider response.
 * @param {ContentReferenceKey[]|null} allowedReferences Context.
 * @return {ModelResponseValidationResult} Validation result.
 */
function validateInternal(
  rawResponse: string,
  allowedReferences:
    readonly ContentReferenceKey[] |
    null,
): ModelResponseValidationResult {
  const byteLength =
    Buffer.byteLength(
      rawResponse,
      "utf8",
    );

  if (
    byteLength >
    MAX_GEMINI_RAW_RESPONSE_BYTES
  ) {
    return {
      ok: false,
      code:
        "RAW_RESPONSE_TOO_LARGE",
    };
  }

  let parsed: unknown;

  try {
    parsed =
      JSON.parse(rawResponse);
  } catch {
    return {
      ok: false,
      code: "INVALID_JSON",
    };
  }

  const schemaResult =
    geminiInternalResponseSchema
      .safeParse(parsed);

  if (!schemaResult.success) {
    return {
      ok: false,
      code:
        "INVALID_MODEL_SCHEMA",
    };
  }

  if (
    hasDisallowedText(
      schemaResult.data,
    )
  ) {
    return {
      ok: false,
      code:
        "DISALLOWED_MODEL_CONTENT",
    };
  }

  if (
    allowedReferences !== null &&
    !referencesAreAuthorized(
      schemaResult.data
        .referenceKeys,
      allowedReferences,
    )
  ) {
    return {
      ok: false,
      code:
        "UNAUTHORIZED_REFERENCE",
    };
  }

  const references =
    resolveReferences(
      schemaResult.data
        .referenceKeys,
    );

  if (!references) {
    return {
      ok: false,
      code:
        "UNAUTHORIZED_REFERENCE",
    };
  }

  return {
    ok: true,
    value: {
      model:
        schemaResult.data,
      references,
    },
  };
}

/**
 * Validates a raw Gemini response against the bibliography catalog.
 *
 * This function is retained for low-level validation tests. Production
 * tutor orchestration must use validateGeminiRawResponseForContext.
 *
 * @param {string} rawResponse Raw provider response.
 * @return {ModelResponseValidationResult} Validation result.
 */
export function validateGeminiRawResponse(
  rawResponse: string,
): ModelResponseValidationResult {
  return validateInternal(
    rawResponse,
    null,
  );
}

/**
 * Validates a raw Gemini response against both the schema and the exact
 * bibliography keys authorized by the trusted backend context.
 *
 * @param {string} rawResponse Raw provider response.
 * @param {ContentReferenceKey[]} allowedReferences Allowed keys.
 * @return {ModelResponseValidationResult} Validation result.
 */
export function validateGeminiRawResponseForContext(
  rawResponse: string,
  allowedReferences:
    readonly ContentReferenceKey[],
): ModelResponseValidationResult {
  return validateInternal(
    rawResponse,
    allowedReferences,
  );
}

/**
 * Builds the public v1.0 success response.
 *
 * @param {TutorSuccessContext} context Backend-owned ids.
 * @param {ValidatedModelResponse} validated Validated model data.
 * @return {TutorBackendResponse} Public backend response.
 */
export function buildTutorSuccessResponse(
  context: TutorSuccessContext,
  validated: ValidatedModelResponse,
): TutorBackendResponse {
  const response = {
    schemaVersion:
      "1.0" as const,
    status:
      "ok" as const,
    interactionId:
      context.interactionId,
    tutorSessionId:
      context.tutorSessionId,
    contentFormat:
      "plain_text" as const,
    responseType:
      validated.model
        .responseType,
    title:
      validated.model.title,
    message:
      validated.model.message,
    steps:
      validated.model.steps,
    checkQuestion:
      validated.model
        .checkQuestion,
    references:
      validated.references,
    suggestedAction:
      validated.model
        .suggestedAction,
    error: null,
  };

  return tutorBackendResponseSchema
    .parse(response);
}
