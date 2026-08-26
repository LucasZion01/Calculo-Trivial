import {z} from "zod";

const tutorRuntimeConfigSchema = z.object({
  rateLimit: z.object({
    burstWindowMs: z.number().int().positive(),
    burstMaxRequests: z.number().int().positive(),
    minuteWindowMs: z.number().int().positive(),
    minuteMaxRequests: z.number().int().positive(),
    dayWindowMs: z.number().int().positive(),
    dayMaxRequests: z.number().int().positive(),
  }).strict(),
  function: z.object({
    minInstances: z.number().int().nonnegative(),
    maxInstances: z.number().int().positive(),
    concurrency: z.number().int().positive(),
    timeoutSeconds: z.number().int().positive(),
  }).strict(),
  gemini: z.object({
    model: z.string().min(1),
    timeoutMs: z.number().int().positive(),
    maxRawResponseBytes: z.number().int().positive(),
    maxConcurrentPerInstance: z.number().int().positive(),
    temperature: z.number().min(0).max(2),
  }).strict(),
}).strict();

export const TUTOR_RUNTIME_CONFIG =
  tutorRuntimeConfigSchema.parse({
    rateLimit: {
      burstWindowMs: 5 * 1000,
      burstMaxRequests: 3,
      minuteWindowMs: 60 * 1000,
      minuteMaxRequests: 10,
      dayWindowMs: 24 * 60 * 60 * 1000,
      dayMaxRequests: 100,
    },
    function: {
      minInstances: 0,
      maxInstances: 3,
      concurrency: 5,
      timeoutSeconds: 30,
    },
    gemini: {
      model: "gemini-3.7-flash",
      timeoutMs: 15 * 1000,
      maxRawResponseBytes: 16 * 1024,
      maxConcurrentPerInstance: 2,
      temperature: 0.3,
    },
  });
