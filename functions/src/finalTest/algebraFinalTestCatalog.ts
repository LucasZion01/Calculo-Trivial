/**
 * Public option sent to a final-test client.
 */
export interface FinalTestOption {
  id: string;
  text: string;
}

/**
 * Trusted final-test question stored exclusively on the backend.
 */
export interface TrustedFinalTestQuestion {
  id: string;
  statement: string;
  options: readonly FinalTestOption[];
  correctOptionId: string;
}

/**
 * Public representation of a final-test question.
 *
 * The correct answer must never be included here.
 */
export interface PublicFinalTestQuestion {
  id: string;
  statement: string;
  options: readonly FinalTestOption[];
}

/**
 * Canonical server-exclusive Algebra final-test catalog.
 *
 * These questions must not be copied into the Flutter application.
 * Only the backend owns correctOptionId.
 */
export const ALGEBRA_FINAL_TEST_CATALOG:
readonly TrustedFinalTestQuestion[] = [
  {
    id: "final-algebra-v1-01",
    statement: "Simplifique:\n9x + 4x - 6x",
    correctOptionId: "c",
    options: [
      {id: "a", text: "5x"},
      {id: "b", text: "6x"},
      {id: "c", text: "7x"},
      {id: "d", text: "19x"},
    ],
  },
  {
    id: "final-algebra-v1-02",
    statement: "Simplifique:\n11a - 3a + 5a",
    correctOptionId: "b",
    options: [
      {id: "a", text: "8a"},
      {id: "b", text: "13a"},
      {id: "c", text: "9a"},
      {id: "d", text: "19a"},
    ],
  },
  {
    id: "final-algebra-v1-03",
    statement: "Calcule 3x^2 - 2x para x = -3.",
    correctOptionId: "d",
    options: [
      {id: "a", text: "21"},
      {id: "b", text: "-33"},
      {id: "c", text: "27"},
      {id: "d", text: "33"},
    ],
  },
  {
    id: "final-algebra-v1-04",
    statement: "Qual e o coeficiente de -12y^4?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "-12"},
      {id: "b", text: "12"},
      {id: "c", text: "4"},
      {id: "d", text: "y"},
    ],
  },
  {
    id: "final-algebra-v1-05",
    statement: "Simplifique:\n4(2x - 3) + 2x",
    correctOptionId: "b",
    options: [
      {id: "a", text: "8x - 12"},
      {id: "b", text: "10x - 12"},
      {id: "c", text: "10x - 3"},
      {id: "d", text: "6x - 12"},
    ],
  },
  {
    id: "final-algebra-v1-06",
    statement: "Simplifique:\n7a - 3(a + 2)",
    correctOptionId: "c",
    options: [
      {id: "a", text: "4a + 6"},
      {id: "b", text: "10a - 6"},
      {id: "c", text: "4a - 6"},
      {id: "d", text: "4a - 2"},
    ],
  },
  {
    id: "final-algebra-v1-07",
    statement: "Efetue a multiplicacao:\n(-4x^3)(3x^2)",
    correctOptionId: "d",
    options: [
      {id: "a", text: "-12x^6"},
      {id: "b", text: "12x^5"},
      {id: "c", text: "-7x^5"},
      {id: "d", text: "-12x^5"},
    ],
  },
  {
    id: "final-algebra-v1-08",
    statement: "Desenvolva:\n(x + 5)(x - 3)",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x^2 + 2x - 15"},
      {id: "b", text: "x^2 - 2x - 15"},
      {id: "c", text: "x^2 + 8x + 15"},
      {id: "d", text: "x^2 + 2x + 15"},
    ],
  },
  {
    id: "final-algebra-v1-09",
    statement: "Simplifique:\n(18x^4 y^3) / (6x^2 y)",
    correctOptionId: "b",
    options: [
      {id: "a", text: "3x^2 y"},
      {id: "b", text: "3x^2 y^2"},
      {id: "c", text: "12x^2 y^2"},
      {id: "d", text: "3x^6 y^4"},
    ],
  },
  {
    id: "final-algebra-v1-10",
    statement: "Fatore:\n10x + 15",
    correctOptionId: "c",
    options: [
      {id: "a", text: "10(x + 5)"},
      {id: "b", text: "3(5x + 5)"},
      {id: "c", text: "5(2x + 3)"},
      {id: "d", text: "5(2x + 15)"},
    ],
  },
  {
    id: "final-algebra-v1-11",
    statement: "Simplifique, considerando x diferente de zero:\nx^7 / x^3",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x^4"},
      {id: "b", text: "x^10"},
      {id: "c", text: "x^3"},
      {id: "d", text: "4x"},
    ],
  },
  {
    id: "final-algebra-v1-12",
    statement: "Simplifique:\n(3x^2)^2",
    correctOptionId: "d",
    options: [
      {id: "a", text: "6x^4"},
      {id: "b", text: "9x^2"},
      {id: "c", text: "6x^2"},
      {id: "d", text: "9x^4"},
    ],
  },
  {
    id: "final-algebra-v1-13",
    statement: "Simplifique:\n5(x - 1) - 2(x + 4)",
    correctOptionId: "b",
    options: [
      {id: "a", text: "3x + 3"},
      {id: "b", text: "3x - 13"},
      {id: "c", text: "7x - 13"},
      {id: "d", text: "3x - 9"},
    ],
  },
  {
    id: "final-algebra-v1-14",
    statement: "Calcule 4a^2 + 2a para a = -2.",
    correctOptionId: "c",
    options: [
      {id: "a", text: "20"},
      {id: "b", text: "8"},
      {id: "c", text: "12"},
      {id: "d", text: "-12"},
    ],
  },
  {
    id: "final-algebra-v1-15",
    statement: "Desenvolva:\n(x + 6)^2",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x^2 + 12x + 36"},
      {id: "b", text: "x^2 + 6x + 36"},
      {id: "c", text: "x^2 + 36"},
      {id: "d", text: "x^2 - 12x + 36"},
    ],
  },
  {
    id: "final-algebra-v1-16",
    statement: "Fatore:\nx^2 - 25",
    correctOptionId: "d",
    options: [
      {id: "a", text: "(x - 25)(x + 1)"},
      {id: "b", text: "(x - 5)^2"},
      {id: "c", text: "(x + 5)^2"},
      {id: "d", text: "(x - 5)(x + 5)"},
    ],
  },
  {
    id: "final-algebra-v1-17",
    statement: "Simplifique:\nx/4 + x/6",
    correctOptionId: "b",
    options: [
      {id: "a", text: "x/10"},
      {id: "b", text: "5x/12"},
      {id: "c", text: "2x/5"},
      {id: "d", text: "x/24"},
    ],
  },
  {
    id: "final-algebra-v1-18",
    statement: "Simplifique:\n8x^2 y - 5x^2 y - 4x^2 y",
    correctOptionId: "c",
    options: [
      {id: "a", text: "7x^2 y"},
      {id: "b", text: "-9x^2 y"},
      {id: "c", text: "-x^2 y"},
      {id: "d", text: "x^2 y"},
    ],
  },
  {
    id: "final-algebra-v1-19",
    statement: "Simplifique:\n3(x + 2) + (x - 4)(x + 4)",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x^2 + 3x - 10"},
      {id: "b", text: "x^2 + 3x + 10"},
      {id: "c", text: "2x^2 - 10"},
      {id: "d", text: "x^2 - 3x - 10"},
    ],
  },
  {
    id: "final-algebra-v1-20",
    statement: "Simplifique:\n2(3x - 5) - (x - 7)",
    correctOptionId: "d",
    options: [
      {id: "a", text: "5x - 17"},
      {id: "b", text: "7x - 3"},
      {id: "c", text: "5x + 3"},
      {id: "d", text: "5x - 3"},
    ],
  },
];

/**
 * Returns a trusted Algebra question by ID.
 *
 * @param {string} questionId Question identifier.
 * @return {TrustedFinalTestQuestion | undefined} Trusted question.
 */
export function getAlgebraFinalTestQuestion(
  questionId: string,
): TrustedFinalTestQuestion | undefined {
  return ALGEBRA_FINAL_TEST_CATALOG.find(
    (question) =>
      question.id === questionId,
  );
}

/**
 * Removes the answer key before a question leaves the backend.
 *
 * @param {TrustedFinalTestQuestion} question Trusted question.
 * @return {PublicFinalTestQuestion} Safe public question.
 */
export function toPublicFinalTestQuestion(
  question: TrustedFinalTestQuestion,
): PublicFinalTestQuestion {
  return {
    id: question.id,
    statement: question.statement,
    options: question.options,
  };
}
