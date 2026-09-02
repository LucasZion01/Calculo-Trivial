import assert from "node:assert/strict";
import test from "node:test";

import {
  ContentReferenceKey,
} from "../content/contentTypes";
import {
  validateGeminiRawResponseForContext,
} from "./modelResponsePipeline";

const stewartReference:
ContentReferenceKey = {
  sourceId:
    "stewart_calculo_v1_8ed",
  sectionId:
    "limites_continuidade",
};

const thomasReference:
ContentReferenceKey = {
  sourceId:
    "thomas_calculo_v1_12ed",
  sectionId:
    "limites_continuidade",
};

/**
 * Builds one otherwise valid Gemini response.
 *
 * @param {ContentReferenceKey[]} referenceKeys Internal references.
 * @return {string} Serialized model response.
 */
function buildRawResponse(
  referenceKeys:
    ContentReferenceKey[],
): string {
  return JSON.stringify({
    responseType: "hint",
    title: "Pista",
    message:
      "Observe a estrutura algébrica antes de substituir.",
    steps: [],
    checkQuestion: "",
    referenceKeys,
    suggestedAction:
      "continue",
  });
}

test("accepts an authorized question reference", () => {
  const result =
    validateGeminiRawResponseForContext(
      buildRawResponse([
        stewartReference,
      ]),
      [
        stewartReference,
      ],
    );

  assert.equal(
    result.ok,
    true,
  );
});

test("rejects a reference not authorized for the question", () => {
  const result =
    validateGeminiRawResponseForContext(
      buildRawResponse([
        thomasReference,
      ]),
      [
        stewartReference,
      ],
    );

  assert.deepEqual(
    result,
    {
      ok: false,
      code:
        "UNAUTHORIZED_REFERENCE",
    },
  );
});

test("allows empty references with an empty authorization set", () => {
  const result =
    validateGeminiRawResponseForContext(
      buildRawResponse([]),
      [],
    );

  assert.equal(
    result.ok,
    true,
  );
});

test("rejects mixed authorized and unauthorized references", () => {
  const result =
    validateGeminiRawResponseForContext(
      buildRawResponse([
        stewartReference,
        thomasReference,
      ]),
      [
        stewartReference,
      ],
    );

  assert.deepEqual(
    result,
    {
      ok: false,
      code:
        "UNAUTHORIZED_REFERENCE",
    },
  );
});
