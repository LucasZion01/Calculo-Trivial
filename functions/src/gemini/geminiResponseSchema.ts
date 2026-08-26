export const GEMINI_RESPONSE_TYPES = [
  "hint",
  "error_explanation",
  "step_by_step",
  "similar_exercise",
  "review_recommendation",
  "system_message",
] as const;

export const GEMINI_SUGGESTED_ACTIONS = [
  "request_hint",
  "view_steps",
  "try_similar",
  "recommend_review",
  "continue",
  "retry",
  "close",
] as const;

export const TUTOR_GEMINI_RESPONSE_SCHEMA = {
  type: "OBJECT",
  properties: {
    responseType: {
      type: "STRING",
      enum: [...GEMINI_RESPONSE_TYPES],
    },
    title: {
      type: "STRING",
    },
    message: {
      type: "STRING",
    },
    steps: {
      type: "ARRAY",
      items: {
        type: "STRING",
      },
    },
    checkQuestion: {
      type: "STRING",
    },
    referenceKeys: {
      type: "ARRAY",
      items: {
        type: "OBJECT",
        properties: {
          sourceId: {
            type: "STRING",
          },
          sectionId: {
            type: "STRING",
          },
        },
        required: [
          "sourceId",
          "sectionId",
        ],
      },
    },
    suggestedAction: {
      type: "STRING",
      enum: [...GEMINI_SUGGESTED_ACTIONS],
    },
  },
  required: [
    "responseType",
    "title",
    "message",
    "steps",
    "checkQuestion",
    "referenceKeys",
    "suggestedAction",
  ],
} as const;
