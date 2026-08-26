import assert from "node:assert/strict";
import test from "node:test";

import {
  LessonContent,
} from "./contentTypes";
import {
  LocalContentRepository,
} from "./LocalContentRepository";

const SAMPLE_CONTENT: readonly LessonContent[] = [
  {
    contentVersion: "1.0.0",
    lessonId: "lesson_01",
    subject: "Limites",
    questions: [
      {
        contentVersion: "1.0.0",
        lessonId: "lesson_01",
        questionId: "question_01",
        subject: "Limites",
        statement: "Qual é o limite de x quando x tende a 2?",
        options: [
          {
            id: "a",
            text: "1",
          },
          {
            id: "b",
            text: "2",
          },
        ],
        correctOptionId: "b",
        originalExplanation:
          "Quando x tende a 2, a própria função identidade tende a 2.",
        references: [
          {
            sourceId: "stewart_calculo_v1_8ed",
            sectionId: "limites_continuidade",
          },
        ],
      },
    ],
  },
];

test("returns an existing lesson", async () => {
  const repository =
    new LocalContentRepository(SAMPLE_CONTENT);

  const lesson =
    await repository.getLesson("lesson_01");

  assert.notEqual(lesson, null);
  assert.equal(lesson?.lessonId, "lesson_01");
});

test("returns null for an unknown lesson", async () => {
  const repository =
    new LocalContentRepository(SAMPLE_CONTENT);

  const lesson =
    await repository.getLesson("unknown");

  assert.equal(lesson, null);
});

test("returns a question inside its lesson", async () => {
  const repository =
    new LocalContentRepository(SAMPLE_CONTENT);

  const question =
    await repository.getQuestion(
      "lesson_01",
      "question_01",
    );

  assert.notEqual(question, null);
  assert.equal(
    question?.correctOptionId,
    "b",
  );
});

test("does not return a question from another lesson", async () => {
  const repository =
    new LocalContentRepository(SAMPLE_CONTENT);

  const question =
    await repository.getQuestion(
      "unknown_lesson",
      "question_01",
    );

  assert.equal(question, null);
});

test("checks question and lesson association", async () => {
  const repository =
    new LocalContentRepository(SAMPLE_CONTENT);

  assert.equal(
    await repository.questionBelongsToLesson(
      "lesson_01",
      "question_01",
    ),
    true,
  );

  assert.equal(
    await repository.questionBelongsToLesson(
      "lesson_01",
      "unknown_question",
    ),
    false,
  );
});
