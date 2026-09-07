import {
  PublicFinalTestQuestion,
  TrustedFinalTestQuestion,
} from "./algebraFinalTestCatalog";

/**
 * Canonical server-exclusive Equations and Inequalities final-test catalog.
 *
 * These questions must not be copied into the Flutter application.
 * Only the backend owns correctOptionId.
 */
export const EQUATIONS_FINAL_TEST_CATALOG:
readonly TrustedFinalTestQuestion[] = [
  {
    id: "final-equations-v1-01",
    statement: "Resolva a equacao:\n3x + 7 = 22",
    correctOptionId: "b",
    options: [
      {id: "a", text: "x = 3"},
      {id: "b", text: "x = 5"},
      {id: "c", text: "x = 7"},
      {id: "d", text: "x = 29/3"},
    ],
  },
  {
    id: "final-equations-v1-02",
    statement: "Resolva a equacao:\n5x - 9 = 2x + 12",
    correctOptionId: "c",
    options: [
      {id: "a", text: "x = 1"},
      {id: "b", text: "x = 3"},
      {id: "c", text: "x = 7"},
      {id: "d", text: "x = 21"},
    ],
  },
  {
    id: "final-equations-v1-03",
    statement: "Resolva a equacao:\n4(x - 2) = 2x + 6",
    correctOptionId: "d",
    options: [
      {id: "a", text: "x = 2"},
      {id: "b", text: "x = 5"},
      {id: "c", text: "x = 6"},
      {id: "d", text: "x = 7"},
    ],
  },
  {
    id: "final-equations-v1-04",
    statement: "Resolva a equacao:\nx/3 + 2 = 7",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x = 15"},
      {id: "b", text: "x = 9"},
      {id: "c", text: "x = 5"},
      {id: "d", text: "x = 27"},
    ],
  },
  {
    id: "final-equations-v1-05",
    statement: "Resolva a equacao:\n(x - 1)/4 = 3",
    correctOptionId: "c",
    options: [
      {id: "a", text: "x = 11"},
      {id: "b", text: "x = 12"},
      {id: "c", text: "x = 13"},
      {id: "d", text: "x = 7"},
    ],
  },
  {
    id: "final-equations-v1-06",
    statement: "Qual e a solucao de:\n2(x + 4) - 3 = 15",
    correctOptionId: "b",
    options: [
      {id: "a", text: "x = 3"},
      {id: "b", text: "x = 5"},
      {id: "c", text: "x = 7"},
      {id: "d", text: "x = 10"},
    ],
  },
  {
    id: "final-equations-v1-07",
    statement: "Resolva:\n7 - 2x = 19",
    correctOptionId: "d",
    options: [
      {id: "a", text: "x = 6"},
      {id: "b", text: "x = -13"},
      {id: "c", text: "x = -5"},
      {id: "d", text: "x = -6"},
    ],
  },
  {
    id: "final-equations-v1-08",
    statement: "Resolva:\n3(x - 1) + 2 = 2(x + 4)",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x = 9"},
      {id: "b", text: "x = 7"},
      {id: "c", text: "x = 3"},
      {id: "d", text: "x = 11"},
    ],
  },
  {
    id: "final-equations-v1-09",
    statement: "A equacao 4x + 8 = 4(x + 2) possui:",
    correctOptionId: "c",
    options: [
      {id: "a", text: "Somente x = 0"},
      {id: "b", text: "Nenhuma solucao"},
      {id: "c", text: "Infinitas solucoes"},
      {id: "d", text: "Somente x = 2"},
    ],
  },
  {
    id: "final-equations-v1-10",
    statement: "A equacao 3(x + 1) = 3x + 8 possui:",
    correctOptionId: "b",
    options: [
      {id: "a", text: "Infinitas solucoes"},
      {id: "b", text: "Nenhuma solucao"},
      {id: "c", text: "Somente x = 5"},
      {id: "d", text: "Somente x = -5"},
    ],
  },
  {
    id: "final-equations-v1-11",
    statement: "Resolva a inequacao:\n2x + 3 > 11",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x > 4"},
      {id: "b", text: "x < 4"},
      {id: "c", text: "x > 7"},
      {id: "d", text: "x < 7"},
    ],
  },
  {
    id: "final-equations-v1-12",
    statement: "Resolva a inequacao:\n5x - 10 <= 15",
    correctOptionId: "d",
    options: [
      {id: "a", text: "x >= 5"},
      {id: "b", text: "x < 5"},
      {id: "c", text: "x > 5"},
      {id: "d", text: "x <= 5"},
    ],
  },
  {
    id: "final-equations-v1-13",
    statement: "Resolva a inequacao:\n-3x > 12",
    correctOptionId: "c",
    options: [
      {id: "a", text: "x > -4"},
      {id: "b", text: "x > 4"},
      {id: "c", text: "x < -4"},
      {id: "d", text: "x < 4"},
    ],
  },
  {
    id: "final-equations-v1-14",
    statement: "Resolva a inequacao:\n4 - 2x >= 10",
    correctOptionId: "b",
    options: [
      {id: "a", text: "x >= -3"},
      {id: "b", text: "x <= -3"},
      {id: "c", text: "x >= 3"},
      {id: "d", text: "x <= 3"},
    ],
  },
  {
    id: "final-equations-v1-15",
    statement: "Resolva o sistema:\nx + y = 9\nx - y = 3",
    correctOptionId: "d",
    options: [
      {id: "a", text: "x = 3, y = 6"},
      {id: "b", text: "x = 9, y = 3"},
      {id: "c", text: "x = 5, y = 4"},
      {id: "d", text: "x = 6, y = 3"},
    ],
  },
  {
    id: "final-equations-v1-16",
    statement: "Resolva o sistema:\n2x + y = 11\nx - y = 1",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x = 4, y = 3"},
      {id: "b", text: "x = 3, y = 5"},
      {id: "c", text: "x = 5, y = 1"},
      {id: "d", text: "x = 4, y = 7"},
    ],
  },
  {
    id: "final-equations-v1-17",
    statement: "Resolva:\nx^2 - 9 = 0",
    correctOptionId: "c",
    options: [
      {id: "a", text: "x = 3"},
      {id: "b", text: "x = -3"},
      {id: "c", text: "x = -3 ou x = 3"},
      {id: "d", text: "x = 9 ou x = -9"},
    ],
  },
  {
    id: "final-equations-v1-18",
    statement: "Quais sao as raizes de:\nx^2 - 5x + 6 = 0",
    correctOptionId: "b",
    options: [
      {id: "a", text: "x = -2 e x = -3"},
      {id: "b", text: "x = 2 e x = 3"},
      {id: "c", text: "x = 1 e x = 6"},
      {id: "d", text: "x = -1 e x = -6"},
    ],
  },
  {
    id: "final-equations-v1-19",
    statement: "Resolva:\n2x^2 - 8 = 0",
    correctOptionId: "d",
    options: [
      {id: "a", text: "x = 4 ou x = -4"},
      {id: "b", text: "x = 2"},
      {id: "c", text: "x = -2"},
      {id: "d", text: "x = -2 ou x = 2"},
    ],
  },
  {
    id: "final-equations-v1-20",
    statement: "Um numero somado ao seu dobro resulta em 27. Qual e o numero?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "9"},
      {id: "b", text: "18"},
      {id: "c", text: "27"},
      {id: "d", text: "6"},
    ],
  },
];

/**
 * Returns a trusted Equations and Inequalities question by ID.
 *
 * @param {string} questionId Question identifier.
 * @return {TrustedFinalTestQuestion | undefined} Trusted question.
 */
export function getEquationsFinalTestQuestion(
  questionId: string,
): TrustedFinalTestQuestion | undefined {
  return EQUATIONS_FINAL_TEST_CATALOG.find(
    (question) =>
      question.id === questionId,
  );
}

/**
 * Removes the answer key before an Equations question leaves the backend.
 *
 * @param {TrustedFinalTestQuestion} question Trusted question.
 * @return {PublicFinalTestQuestion} Safe public question.
 */
export function toPublicEquationsFinalTestQuestion(
  question: TrustedFinalTestQuestion,
): PublicFinalTestQuestion {
  return {
    id: question.id,
    statement: question.statement,
    options: question.options,
  };
}
