import {z} from "zod";

const UUID_V4_REGEX =
  /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

/**
 * Checks whether text contains disallowed control characters.
 *
 * @param {string} value Text to inspect.
 * @return {boolean} True when a disallowed character is present.
 */
function hasDisallowedControlCharacter(value: string): boolean {
  for (let index = 0; index < value.length; index += 1) {
    const code = value.charCodeAt(index);

    if (
      code <= 0x08 ||
      code === 0x0b ||
      code === 0x0c ||
      (code >= 0x0e && code <= 0x1f) ||
      code === 0x7f
    ) {
      return true;
    }
  }

  return false;
}

interface TextBounds {
  min: number;
  max: number;
  trim?: boolean;
}

/**
 * Creates a bounded text schema that rejects unsafe control characters.
 *
 * @param {TextBounds} bounds Text length and trimming options.
 * @return {z.ZodEffects<z.ZodString>} Validated text schema.
 */
export function boundedSafeTextSchema(bounds: TextBounds) {
  let schema = z.string();

  if (bounds.trim) {
    schema = schema.trim();
  }

  schema = schema.min(bounds.min).max(bounds.max);

  return schema.refine(
    (value) => !hasDisallowedControlCharacter(value),
    "String contains disallowed control characters",
  );
}

export const safeTextSchema = z.string().refine(
  (value) => !hasDisallowedControlCharacter(value),
  "String contains disallowed control characters",
);

export const nonEmptySafeTextSchema = z
  .string()
  .trim()
  .min(1)
  .refine(
    (value) => !hasDisallowedControlCharacter(value),
    "String contains disallowed control characters",
  );

export const schemaVersionSchema = z.literal("1.0");

export const clientRequestIdSchema = z
  .string()
  .regex(UUID_V4_REGEX, "Invalid UUID v4");

export const userMessageSchema = boundedSafeTextSchema({
  min: 1,
  max: 300,
  trim: true,
});
