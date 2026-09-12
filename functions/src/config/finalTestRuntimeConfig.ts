import {
  z,
} from "zod";

const rateLimitSchema = z.object({
  burstWindowMs: z.number().int().positive(),
  burstMaxRequests: z.number().int().positive(),
  minuteWindowMs: z.number().int().positive(),
  minuteMaxRequests: z.number().int().positive(),
  dayWindowMs: z.number().int().positive(),
  dayMaxRequests: z.number().int().positive(),
}).strict();

const finalTestRuntimeConfigSchema = z.object({
  startRateLimit: rateLimitSchema,
  submitRateLimit: rateLimitSchema,
}).strict();

export const FINAL_TEST_RUNTIME_CONFIG =
  finalTestRuntimeConfigSchema.parse({
    startRateLimit: {
      burstWindowMs: 5 * 1000,
      burstMaxRequests: 2,
      minuteWindowMs: 60 * 1000,
      minuteMaxRequests: 6,
      dayWindowMs: 24 * 60 * 60 * 1000,
      dayMaxRequests: 30,
    },
    submitRateLimit: {
      burstWindowMs: 5 * 1000,
      burstMaxRequests: 4,
      minuteWindowMs: 60 * 1000,
      minuteMaxRequests: 12,
      dayWindowMs: 24 * 60 * 60 * 1000,
      dayMaxRequests: 60,
    },
  });
