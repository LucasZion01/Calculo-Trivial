import {
  BIBLIOGRAPHIC_SOURCES,
  BibliographicSource,
  RESERVED_BIBLIOGRAPHIC_SOURCE_IDS,
} from "./bibliography";

export interface ReferenceKey {
  sourceId: string;
  sectionId: string;
}

export interface ResolvedReference {
  sourceId: string;
  displayText: string;
  section: string;
}

export const UNKNOWN_REFERENCE_MESSAGE =
  "Essa referência não consta no catálogo bibliográfico atual " +
  "do Cálculo Trivial.";

const reservedIds = new Set<string>(
  RESERVED_BIBLIOGRAPHIC_SOURCE_IDS,
);

const sourceById = new Map<string, BibliographicSource>(
  BIBLIOGRAPHIC_SOURCES.map((source) => [
    source.sourceId,
    source,
  ]),
);

/**
 * Indicates whether a source id is reserved.
 *
 * @param {string} sourceId Source identifier.
 * @return {boolean} True when the id is reserved.
 */
export function isReservedBibliographicSourceId(
  sourceId: string,
): boolean {
  return reservedIds.has(sourceId);
}

/**
 * Resolves a model reference key.
 *
 * @param {ReferenceKey} key Internal model reference key.
 * @return {ResolvedReference|null} Resolved reference or null.
 */
export function resolveReference(
  key: ReferenceKey,
): ResolvedReference | null {
  const source = sourceById.get(key.sourceId);

  if (!source) {
    return null;
  }

  const section = source.sections.find(
    (item) => item.id === key.sectionId,
  );

  if (!section) {
    return null;
  }

  const authorText = source.authors.join("; ");

  return {
    sourceId: source.sourceId,
    displayText:
      `${authorText}. ${source.title}. ` +
      `${source.edition} ${source.publicationPlace}: ` +
      `${source.publisher}, ${source.year}. ` +
      `v. ${source.volume}. ISBN ${source.isbn13}.`,
    section: section.section,
  };
}

/**
 * Resolves all keys or rejects the complete set.
 *
 * @param {ReadonlyArray<ReferenceKey>} keys Reference keys.
 * @return {Array<ResolvedReference>|null} References or null.
 */
export function resolveReferences(
  keys: readonly ReferenceKey[],
): ResolvedReference[] | null {
  const resolved: ResolvedReference[] = [];

  for (const key of keys) {
    const reference = resolveReference(key);

    if (!reference) {
      return null;
    }

    resolved.push(reference);
  }

  return resolved;
}
