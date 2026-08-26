import {
  LessonContent,
} from "../content/contentTypes";
import {
  resolveReference,
} from "./referenceResolver";

const CONTENT_VERSION_REGEX =
  /^[1-9][0-9]*\.[0-9]+\.[0-9]+$/;

export interface ContentIntegrityIssue {
  code: string;
  detail: string;
}

/**
 * Validates the structural integrity of a content catalog.
 *
 * @param {LessonContent[]} catalog Content catalog.
 * @return {ContentIntegrityIssue[]} Integrity issues.
 */
export function validateContentCatalog(
  catalog: readonly LessonContent[],
): ContentIntegrityIssue[] {
  const issues: ContentIntegrityIssue[] = [];
  const lessonIds = new Set<string>();
  const questionIds = new Set<string>();

  for (const lesson of catalog) {
    if (lessonIds.has(lesson.lessonId)) {
      issues.push({
        code: "DUPLICATE_LESSON_ID",
        detail: lesson.lessonId,
      });
    }

    lessonIds.add(lesson.lessonId);

    if (!CONTENT_VERSION_REGEX.test(lesson.contentVersion)) {
      issues.push({
        code: "INVALID_CONTENT_VERSION",
        detail: lesson.lessonId,
      });
    }

    for (const question of lesson.questions) {
      if (questionIds.has(question.questionId)) {
        issues.push({
          code: "DUPLICATE_QUESTION_ID",
          detail: question.questionId,
        });
      }

      questionIds.add(question.questionId);

      if (question.lessonId !== lesson.lessonId) {
        issues.push({
          code: "QUESTION_LESSON_MISMATCH",
          detail: question.questionId,
        });
      }

      if (
        question.contentVersion !== lesson.contentVersion ||
        !CONTENT_VERSION_REGEX.test(
          question.contentVersion,
        )
      ) {
        issues.push({
          code: "INVALID_CONTENT_VERSION",
          detail: question.questionId,
        });
      }

      const optionIds = new Set(
        question.options.map((option) => option.id),
      );

      if (
        question.options.length === 0 ||
        !optionIds.has(question.correctOptionId)
      ) {
        issues.push({
          code: "MISSING_CORRECT_ANSWER",
          detail: question.questionId,
        });
      }

      if (optionIds.size !== question.options.length) {
        issues.push({
          code: "DUPLICATE_OPTION_ID",
          detail: question.questionId,
        });
      }

      for (const reference of question.references) {
        if (!resolveReference(reference)) {
          issues.push({
            code: "UNKNOWN_REFERENCE",
            detail:
              `${question.questionId}:` +
              `${reference.sourceId}:` +
              `${reference.sectionId}`,
          });
        }
      }
    }
  }

  return issues;
}
