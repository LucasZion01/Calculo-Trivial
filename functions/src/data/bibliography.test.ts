import assert from "node:assert/strict";
import test from "node:test";

import {
  BIBLIOGRAPHIC_SOURCES,
} from "./bibliography";
import {
  isReservedBibliographicSourceId,
  resolveReference,
  resolveReferences,
  UNKNOWN_REFERENCE_MESSAGE,
} from "./referenceResolver";

test("bibliographic source ids are unique", () => {
  const ids = BIBLIOGRAPHIC_SOURCES.map(
    (source) => source.sourceId,
  );

  assert.equal(
    new Set(ids).size,
    ids.length,
  );
});

test("section ids are unique inside each source", () => {
  for (const source of BIBLIOGRAPHIC_SOURCES) {
    const sectionIds = source.sections.map(
      (section) => section.id,
    );

    assert.equal(
      new Set(sectionIds).size,
      sectionIds.length,
    );
  }
});

test("resolves Stewart limites_continuidade", () => {
  const result = resolveReference({
    sourceId: "stewart_calculo_v1_8ed",
    sectionId: "limites_continuidade",
  });

  assert.notEqual(result, null);
  assert.equal(
    result?.section,
    "Capítulo 2 — Limites e derivadas, seções 2.2–2.6",
  );
});

test("resolves Thomas limites_continuidade", () => {
  const result = resolveReference({
    sourceId: "thomas_calculo_v1_12ed",
    sectionId: "limites_continuidade",
  });

  assert.notEqual(result, null);
});

test("resolves Guidorizzi limites_continuidade", () => {
  const result = resolveReference({
    sourceId: "guidorizzi_calculo_v1_6ed",
    sectionId: "limites_continuidade",
  });

  assert.notEqual(result, null);
});

test("resolves Iezzi limites_continuidade", () => {
  const result = resolveReference({
    sourceId: "iezzi_fme_v8_7ed",
    sectionId: "limites_continuidade",
  });

  assert.notEqual(result, null);
});

test("rejects an unknown source id", () => {
  const result = resolveReference({
    sourceId: "unknown_source",
    sectionId: "limites_continuidade",
  });

  assert.equal(result, null);
});

test("rejects an unknown section id", () => {
  const result = resolveReference({
    sourceId: "stewart_calculo_v1_8ed",
    sectionId: "unknown_section",
  });

  assert.equal(result, null);
});

test("reserved old editions do not resolve", () => {
  const result = resolveReference({
    sourceId: "thomas_calculo_v1_14ed",
    sectionId: "limites_continuidade",
  });

  assert.equal(result, null);
  assert.equal(
    isReservedBibliographicSourceId(
      "thomas_calculo_v1_14ed",
    ),
    true,
  );
});

test("all references must resolve", () => {
  const result = resolveReferences([
    {
      sourceId: "stewart_calculo_v1_8ed",
      sectionId: "limites_continuidade",
    },
    {
      sourceId: "guidorizzi_calculo_v1_6ed",
      sectionId: "teorema_confronto",
    },
  ]);

  assert.notEqual(result, null);
  assert.equal(result?.length, 2);
});

test("one invalid reference rejects the set", () => {
  const result = resolveReferences([
    {
      sourceId: "stewart_calculo_v1_8ed",
      sectionId: "limites_continuidade",
    },
    {
      sourceId: "unknown_source",
      sectionId: "limites_continuidade",
    },
  ]);

  assert.equal(result, null);
});

test("unknown reference message is catalog scoped", () => {
  assert.equal(
    UNKNOWN_REFERENCE_MESSAGE,
    "Essa referência não consta no catálogo bibliográfico atual " +
      "do Cálculo Trivial.",
  );
});
