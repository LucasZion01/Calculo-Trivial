import assert from "node:assert/strict";
import test from "node:test";

import {
  LessonContent,
} from "../content/contentTypes";
import {
  CONTENT_CATALOG,
} from "./contentCatalog";
import {
  validateContentCatalog,
} from "./contentIntegrity";

test("initial content catalog has no integrity issues", () => {
  assert.deepEqual(
    validateContentCatalog(CONTENT_CATALOG),
    [],
  );
});

test("detects duplicate question ids", () => {
  const catalog: LessonContent[] = [
    {
      contentVersion: "1.0.0",
      lessonId: "lesson_a",
      subject: "Teste",
      questions: [
        {
          contentVersion: "1.0.0",
          lessonId: "lesson_a",
          questionId: "same_question",
          subject: "Teste",
          statement: "Questão A",
          options: [
            {
              id: "a",
              text: "A",
            },
          ],
          correctOptionId: "a",
          originalExplanation: "Explicação A",
          references: [],
        },
      ],
    },
    {
      contentVersion: "1.0.0",
      lessonId: "lesson_b",
      subject: "Teste",
      questions: [
        {
          contentVersion: "1.0.0",
          lessonId: "lesson_b",
          questionId: "same_question",
          subject: "Teste",
          statement: "Questão B",
          options: [
            {
              id: "a",
              text: "A",
            },
          ],
          correctOptionId: "a",
          originalExplanation: "Explicação B",
          references: [],
        },
      ],
    },
  ];

  const issues = validateContentCatalog(catalog);

  assert.equal(
    issues.some(
      (issue) =>
        issue.code === "DUPLICATE_QUESTION_ID",
    ),
    true,
  );
});

test("detects a question without a valid correct answer", () => {
  const catalog: LessonContent[] = [
    {
      contentVersion: "1.0.0",
      lessonId: "lesson_a",
      subject: "Teste",
      questions: [
        {
          contentVersion: "1.0.0",
          lessonId: "lesson_a",
          questionId: "question_a",
          subject: "Teste",
          statement: "Questão",
          options: [
            {
              id: "a",
              text: "A",
            },
          ],
          correctOptionId: "missing",
          originalExplanation: "Explicação",
          references: [],
        },
      ],
    },
  ];

  const issues = validateContentCatalog(catalog);

  assert.equal(
    issues.some(
      (issue) =>
        issue.code === "MISSING_CORRECT_ANSWER",
    ),
    true,
  );
});

test("detects a question linked to the wrong lesson", () => {
  const catalog: LessonContent[] = [
    {
      contentVersion: "1.0.0",
      lessonId: "lesson_a",
      subject: "Teste",
      questions: [
        {
          contentVersion: "1.0.0",
          lessonId: "lesson_b",
          questionId: "question_a",
          subject: "Teste",
          statement: "Questão",
          options: [
            {
              id: "a",
              text: "A",
            },
          ],
          correctOptionId: "a",
          originalExplanation: "Explicação",
          references: [],
        },
      ],
    },
  ];

  const issues = validateContentCatalog(catalog);

  assert.equal(
    issues.some(
      (issue) =>
        issue.code === "QUESTION_LESSON_MISMATCH",
    ),
    true,
  );
});

test("detects a reference absent from bibliography", () => {
  const catalog: LessonContent[] = [
    {
      contentVersion: "1.0.0",
      lessonId: "lesson_a",
      subject: "Teste",
      questions: [
        {
          contentVersion: "1.0.0",
          lessonId: "lesson_a",
          questionId: "question_a",
          subject: "Teste",
          statement: "Questão",
          options: [
            {
              id: "a",
              text: "A",
            },
          ],
          correctOptionId: "a",
          originalExplanation: "Explicação",
          references: [
            {
              sourceId: "unknown_source",
              sectionId: "unknown_section",
            },
          ],
        },
      ],
    },
  ];

  const issues = validateContentCatalog(catalog);

  assert.equal(
    issues.some(
      (issue) => issue.code === "UNKNOWN_REFERENCE",
    ),
    true,
  );
});

test("detects an invalid content version", () => {
  const catalog: LessonContent[] = [
    {
      contentVersion: "version-one",
      lessonId: "lesson_a",
      subject: "Teste",
      questions: [],
    },
  ];

  const issues = validateContentCatalog(catalog);

  assert.equal(
    issues.some(
      (issue) =>
        issue.code === "INVALID_CONTENT_VERSION",
    ),
    true,
  );
});
