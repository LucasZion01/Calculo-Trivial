import assert from "node:assert/strict";
import test from "node:test";

import {
  buildTutorSuccessResponse,
  MAX_GEMINI_RAW_RESPONSE_BYTES,
  validateGeminiRawResponse,
} from "./modelResponsePipeline";

const validResponse = {
  responseType: "hint",
  title: "Fatoração e indeterminação",
  message:
    "Observe como o numerador pode ser fatorado.",
  steps: [],
  checkQuestion:
    "Como podemos fatorar x² − 4?",
  referenceKeys: [
    {
      sourceId: "stewart_calculo_v1_8ed",
      sectionId: "limites_continuidade",
    },
  ],
  suggestedAction: "request_hint",
};

test("accepts a valid plain text model response", () => {
  const result = validateGeminiRawResponse(
    JSON.stringify(validResponse),
  );

  assert.equal(result.ok, true);
});

test("rejects raw responses larger than 16 KB", () => {
  const oversized =
    "x".repeat(
      MAX_GEMINI_RAW_RESPONSE_BYTES + 1,
    );

  const result =
    validateGeminiRawResponse(oversized);

  assert.deepEqual(
    result,
    {
      ok: false,
      code: "RAW_RESPONSE_TOO_LARGE",
    },
  );
});

test("rejects invalid JSON", () => {
  const result =
    validateGeminiRawResponse("{");

  assert.deepEqual(
    result,
    {
      ok: false,
      code: "INVALID_JSON",
    },
  );
});

test("rejects invalid model schema", () => {
  const invalid = {
    responseType: "hint",
    title: "Título",
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.deepEqual(
    result,
    {
      ok: false,
      code: "INVALID_MODEL_SCHEMA",
    },
  );
});

test("rejects an unauthorized reference", () => {
  const invalid = {
    ...validResponse,
    referenceKeys: [
      {
        sourceId: "unknown_source",
        sectionId: "limites_continuidade",
      },
    ],
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.deepEqual(
    result,
    {
      ok: false,
      code: "UNAUTHORIZED_REFERENCE",
    },
  );
});

test("rejects HTML tags", () => {
  const invalid = {
    ...validResponse,
    message:
      "Veja <strong>esta parte</strong>.",
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.equal(result.ok, false);

  if (!result.ok) {
    assert.equal(
      result.code,
      "DISALLOWED_MODEL_CONTENT",
    );
  }
});

test("rejects SVG markup", () => {
  const invalid = {
    ...validResponse,
    message:
      "<svg><circle></circle></svg>",
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.equal(result.ok, false);

  if (!result.ok) {
    assert.equal(
      result.code,
      "DISALLOWED_MODEL_CONTENT",
    );
  }
});

test("rejects data URLs", () => {
  const invalid = {
    ...validResponse,
    message:
      "data:image/png;base64,AAAA",
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.equal(result.ok, false);

  if (!result.ok) {
    assert.equal(
      result.code,
      "DISALLOWED_MODEL_CONTENT",
    );
  }
});

test("rejects Markdown images", () => {
  const invalid = {
    ...validResponse,
    message:
      "![gráfico](imagem.png)",
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.equal(result.ok, false);

  if (!result.ok) {
    assert.equal(
      result.code,
      "DISALLOWED_MODEL_CONTENT",
    );
  }
});

test("rejects javascript schemes", () => {
  const invalid = {
    ...validResponse,
    message:
      "javascript:alert(1)",
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.equal(result.ok, false);

  if (!result.ok) {
    assert.equal(
      result.code,
      "DISALLOWED_MODEL_CONTENT",
    );
  }
});

test("rejects links created by the model", () => {
  const invalid = {
    ...validResponse,
    message:
      "Consulte https://example.com/agora",
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.equal(result.ok, false);

  if (!result.ok) {
    assert.equal(
      result.code,
      "DISALLOWED_MODEL_CONTENT",
    );
  }
});

test("rejects long raw Base64 content", () => {
  const invalid = {
    ...validResponse,
    message:
      "A".repeat(140),
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.equal(result.ok, false);

  if (!result.ok) {
    assert.equal(
      result.code,
      "DISALLOWED_MODEL_CONTENT",
    );
  }
});

test("accepts UTF-8 mathematical text", () => {
  const valid = {
    ...validResponse,
    message:
      "Use √(x − 5), x² − 4 e ∫x·eˣ dx.",
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(valid),
  );

  assert.equal(result.ok, true);
});

test("accepts mathematical < and > operators", () => {
  const valid = {
    ...validResponse,
    message:
      "Se x < 2 ou x > 5, compare os limites.",
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(valid),
  );

  assert.equal(result.ok, true);
});

test("checks text inside steps recursively", () => {
  const invalid = {
    ...validResponse,
    steps: [
      "Primeiro passo.",
      "<iframe src='x'></iframe>",
    ],
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.equal(result.ok, false);

  if (!result.ok) {
    assert.equal(
      result.code,
      "DISALLOWED_MODEL_CONTENT",
    );
  }
});

test("checks text inside reference keys", () => {
  const invalid = {
    ...validResponse,
    referenceKeys: [
      {
        sourceId:
          "<script>alert(1)</script>",
        sectionId:
          "limites_continuidade",
      },
    ],
  };

  const result = validateGeminiRawResponse(
    JSON.stringify(invalid),
  );

  assert.equal(result.ok, false);

  if (!result.ok) {
    assert.equal(
      result.code,
      "DISALLOWED_MODEL_CONTENT",
    );
  }
});

test("builds the final plain text response", () => {
  const validation =
    validateGeminiRawResponse(
      JSON.stringify(validResponse),
    );

  assert.equal(validation.ok, true);

  if (!validation.ok) {
    return;
  }

  const response =
    buildTutorSuccessResponse(
      {
        interactionId:
          "int_7891011_abc",
        tutorSessionId:
          "sess_99887766_xyz",
      },
      validation.value,
    );

  assert.equal(response.status, "ok");
  assert.equal(
    response.contentFormat,
    "plain_text",
  );
  assert.equal(
    response.references.length,
    1,
  );
  assert.equal(response.error, null);
});

test("does not expose reference keys publicly", () => {
  const validation =
    validateGeminiRawResponse(
      JSON.stringify(validResponse),
    );

  assert.equal(validation.ok, true);

  if (!validation.ok) {
    return;
  }

  const response =
    buildTutorSuccessResponse(
      {
        interactionId: "int_1",
        tutorSessionId: "sess_1",
      },
      validation.value,
    );

  assert.equal(
    "referenceKeys" in response,
    false,
  );
});
