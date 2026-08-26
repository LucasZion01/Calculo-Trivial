import {
  TUTOR_RUNTIME_CONFIG,
} from "../config/tutorRuntimeConfig";
import {
  TUTOR_GEMINI_RESPONSE_SCHEMA,
} from "./geminiResponseSchema";
import {
  GeminiInvocationMetrics,
  GeminiTutorResult,
  GeminiUsageMetrics,
  TutorModelRequest,
} from "./geminiTypes";
import {
  buildTutorPrompt,
  TUTOR_SYSTEM_INSTRUCTION,
} from "./tutorPromptBuilder";

export interface GeminiTransportRequest {
  model: string;
  contents: string;
  systemInstruction: string;
  responseMimeType: "application/json";
  responseSchema:
    typeof TUTOR_GEMINI_RESPONSE_SCHEMA;
  temperature: number;
}

export interface GeminiTransportResponse {
  text: string;
  usageMetadata?: unknown;
}

export interface GeminiTransport {
  generate(
    request: GeminiTransportRequest,
  ): Promise<GeminiTransportResponse>;
}

interface GeminiClientOptions {
  timeoutMs: number;
  maxConcurrent: number;
  model: string;
  temperature: number;
}

interface ProviderResponseLike {
  text?: string;
  usageMetadata?: unknown;
}

interface ProviderClientLike {
  models: {
    generateContent(
      request: unknown,
    ): Promise<ProviderResponseLike>;
  };
}

const GOOGLE_GENAI_PACKAGE =
  "@google/genai";

/**
 * Restricts provider concurrency inside one Functions instance.
 */
class AsyncSemaphore {
  private active = 0;

  private readonly waiters:
  Array<() => void> = [];

  /**
   * Creates the semaphore.
   *
   * @param {number} maximum Maximum simultaneous operations.
   */
  constructor(
    private readonly maximum: number,
  ) {}

  /**
   * Executes an operation with one permit.
   *
   * @param {Function} operation Asynchronous operation.
   * @return {Promise<*>} Operation result.
   */
  async run<T>(
    operation: () => Promise<T>,
  ): Promise<T> {
    await this.acquire();

    try {
      return await operation();
    } finally {
      this.release();
    }
  }

  /**
   * Acquires one permit.
   *
   * @return {Promise<void>} Acquisition promise.
   */
  private async acquire():
  Promise<void> {
    if (
      this.active <
      this.maximum
    ) {
      this.active += 1;
      return;
    }

    await new Promise<void>(
      (resolve) => {
        this.waiters.push(resolve);
      },
    );

    this.active += 1;
  }

  /**
   * Releases one permit.
   *
   * @return {void} Nothing.
   */
  private release(): void {
    this.active -= 1;

    const next =
      this.waiters.shift();

    if (next) {
      next();
    }
  }
}

/**
 * Internal timeout marker.
 */
class GeminiTimeoutError
  extends Error {
  /**
   * Creates the timeout marker.
   */
  constructor() {
    super("Gemini request timed out");
    this.name =
      "GeminiTimeoutError";
  }
}

/**
 * Applies the configured provider timeout.
 *
 * @param {Promise<*>} operation Provider request.
 * @param {number} timeoutMs Timeout in milliseconds.
 * @return {Promise<*>} Timed request.
 */
function withTimeout<T>(
  operation: Promise<T>,
  timeoutMs: number,
): Promise<T> {
  return new Promise<T>(
    (resolve, reject) => {
      const timer =
        setTimeout(
          () => {
            reject(
              new GeminiTimeoutError(),
            );
          },
          timeoutMs,
        );

      operation.then(
        (value) => {
          clearTimeout(timer);
          resolve(value);
        },
        (error: unknown) => {
          clearTimeout(timer);
          reject(error);
        },
      );
    },
  );
}

/**
 * Reads one safe numeric usage metric.
 *
 * @param {Record<string, unknown>} object Metadata.
 * @param {string} key Metadata key.
 * @return {number|null} Metric value.
 */
function readMetric(
  object: Record<string, unknown>,
  key: string,
): number | null {
  const value = object[key];

  if (
    typeof value === "number" &&
    Number.isFinite(value) &&
    value >= 0
  ) {
    return value;
  }

  return null;
}

/**
 * Extracts only non-sensitive token counters.
 *
 * @param {unknown} metadata Provider metadata.
 * @return {GeminiUsageMetrics} Sanitized counters.
 */
function extractUsageMetrics(
  metadata: unknown,
): GeminiUsageMetrics {
  if (
    metadata === null ||
    typeof metadata !== "object"
  ) {
    return {
      promptTokenCount: null,
      candidatesTokenCount: null,
      totalTokenCount: null,
    };
  }

  const object =
    metadata as
    Record<string, unknown>;

  return {
    promptTokenCount:
      readMetric(
        object,
        "promptTokenCount",
      ),
    candidatesTokenCount:
      readMetric(
        object,
        "candidatesTokenCount",
      ),
    totalTokenCount:
      readMetric(
        object,
        "totalTokenCount",
      ),
  };
}

/**
 * Loads the ESM-only Google SDK at runtime.
 *
 * @param {string} apiKey Secret Manager API key.
 * @return {Promise<ProviderClientLike>} Provider client.
 */
async function loadProviderClient(
  apiKey: string,
): Promise<ProviderClientLike> {
  const imported =
    await import(
      GOOGLE_GENAI_PACKAGE
    );

  const moduleObject =
    imported as unknown as
    Record<string, unknown>;

  const constructor =
    moduleObject.GoogleGenAI;

  if (
    typeof constructor !==
    "function"
  ) {
    throw new Error(
      "Gemini SDK constructor is unavailable",
    );
  }

  const ProviderConstructor =
    constructor as new (
      options: {
        apiKey: string;
      }
    ) => ProviderClientLike;

  return new ProviderConstructor({
    apiKey,
  });
}

/**
 * Google Gen AI transport.
 */
export class GoogleGenAITransport
implements GeminiTransport {
  private clientPromise:
  Promise<ProviderClientLike> | null =
      null;

  /**
   * Creates the transport.
   *
   * @param {string} apiKey Secret Manager API key.
   */
  constructor(
    private readonly apiKey: string,
  ) {
    if (!apiKey.trim()) {
      throw new Error(
        "Gemini API key is empty",
      );
    }
  }

  /**
   * Gets the lazily initialized SDK client.
   *
   * @return {Promise<ProviderClientLike>} Client.
   */
  private getClient():
  Promise<ProviderClientLike> {
    if (!this.clientPromise) {
      this.clientPromise =
        loadProviderClient(
          this.apiKey,
        );
    }

    return this.clientPromise;
  }

  /**
   * Performs one provider request.
   *
   * @param {GeminiTransportRequest} request Provider request.
   * @return {Promise<GeminiTransportResponse>} Provider response.
   */
  async generate(
    request: GeminiTransportRequest,
  ): Promise<GeminiTransportResponse> {
    const client =
      await this.getClient();

    const response =
      await client.models
        .generateContent({
          model: request.model,
          contents: request.contents,
          config: {
            systemInstruction:
              request.systemInstruction,
            responseMimeType:
              request.responseMimeType,
            responseSchema:
              request.responseSchema,
            temperature:
              request.temperature,
          },
        });

    return {
      text:
        response.text?.trim() ??
        "",
      usageMetadata:
        response.usageMetadata,
    };
  }
}

/**
 * Tutor Trivial Gemini client.
 */
export class GeminiTutorClient {
  private readonly semaphore:
  AsyncSemaphore;

  /**
   * Creates the tutor client.
   *
   * @param {GeminiTransport} transport Provider transport.
   * @param {Partial<GeminiClientOptions>} options Runtime overrides.
   */
  constructor(
    private readonly transport:
    GeminiTransport,
    private readonly options:
    Partial<GeminiClientOptions> = {},
  ) {
    this.semaphore =
      new AsyncSemaphore(
        this.getOptions()
          .maxConcurrent,
      );
  }

  /**
   * Generates one provider response.
   *
   * @param {TutorModelRequest} request Authorized backend context.
   * @return {Promise<GeminiTutorResult>} Internal result.
   */
  async generate(
    request: TutorModelRequest,
  ): Promise<GeminiTutorResult> {
    const options =
      this.getOptions();

    const startedAt =
      Date.now();

    let usage:
    GeminiUsageMetrics = {
      promptTokenCount: null,
      candidatesTokenCount: null,
      totalTokenCount: null,
    };

    try {
      const response =
        await this.semaphore.run(
          () =>
            withTimeout(
              this.transport.generate({
                model:
                  options.model,
                contents:
                  buildTutorPrompt(
                    request,
                  ),
                systemInstruction:
                  TUTOR_SYSTEM_INSTRUCTION,
                responseMimeType:
                  "application/json",
                responseSchema:
                  TUTOR_GEMINI_RESPONSE_SCHEMA,
                temperature:
                  options.temperature,
              }),
              options.timeoutMs,
            ),
        );

      usage =
        extractUsageMetrics(
          response.usageMetadata,
        );

      const metrics =
        this.buildMetrics(
          startedAt,
          usage,
        );

      if (!response.text.trim()) {
        return {
          ok: false,
          code:
            "EMPTY_RESPONSE",
          metrics,
        };
      }

      return {
        ok: true,
        rawResponse:
          response.text.trim(),
        metrics,
      };
    } catch (error: unknown) {
      const metrics =
        this.buildMetrics(
          startedAt,
          usage,
        );

      if (
        error instanceof
        GeminiTimeoutError
      ) {
        return {
          ok: false,
          code: "TIMEOUT",
          metrics,
        };
      }

      return {
        ok: false,
        code: "UNAVAILABLE",
        metrics,
      };
    }
  }

  /**
   * Resolves runtime options.
   *
   * @return {GeminiClientOptions} Options.
   */
  private getOptions():
  GeminiClientOptions {
    const config =
      TUTOR_RUNTIME_CONFIG.gemini;

    return {
      timeoutMs:
        this.options.timeoutMs ??
        config.timeoutMs,
      maxConcurrent:
        this.options.maxConcurrent ??
        config
          .maxConcurrentPerInstance,
      model:
        this.options.model ??
        config.model,
      temperature:
        this.options.temperature ??
        config.temperature,
    };
  }

  /**
   * Builds non-sensitive metrics.
   *
   * @param {number} startedAt Start epoch milliseconds.
   * @param {GeminiUsageMetrics} usage Usage metrics.
   * @return {GeminiInvocationMetrics} Metrics.
   */
  private buildMetrics(
    startedAt: number,
    usage: GeminiUsageMetrics,
  ): GeminiInvocationMetrics {
    return {
      latencyMs:
        Math.max(
          0,
          Date.now() -
          startedAt,
        ),
      ...usage,
    };
  }
}

/**
 * Creates the production Gemini tutor client.
 *
 * @param {string} apiKey Secret Manager API key.
 * @return {GeminiTutorClient} Tutor client.
 */
export function createGeminiTutorClient(
  apiKey: string,
): GeminiTutorClient {
  return new GeminiTutorClient(
    new GoogleGenAITransport(
      apiKey,
    ),
  );
}
