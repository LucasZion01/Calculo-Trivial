import {
  defineSecret,
} from "firebase-functions/params";

/**
 * Runtime binding for the Gemini API key stored in Secret Manager.
 *
 * This file defines only the secret name. It never contains the secret value.
 */
export const GEMINI_API_KEY =
  defineSecret("GEMINI_API_KEY");
