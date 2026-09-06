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
 * Canonical Algebra final-test catalog.
 *
 * The correctOptionId field is backend-only.
 */
export const ALGEBRA_FINAL_TEST_CATALOG:
readonly TrustedFinalTestQuestion[] = [
  {
    id: "simplificacao-1",
    statement: "Simplifique a expressão:\n3x + 5x − 2x",
    correctOptionId: "a",
    options: [
      {id: "a", text: "6x"},
      {id: "b", text: "8x"},
      {id: "c", text: "10x"},
      {id: "d", text: "x"},
    ],
  },
  {
    id: "simplificacao-2",
    statement: "Simplifique a expressão:\n7a − 2a + 4a",
    correctOptionId: "c",
    options: [
      {id: "a", text: "5a"},
      {id: "b", text: "7a"},
      {id: "c", text: "9a"},
      {id: "d", text: "13a"},
    ],
  },
  {
    id: "simplificacao-3",
    statement: "Calcule o valor de 2x² − 3x para x = −2.",
    correctOptionId: "d",
    options: [
      {id: "a", text: "−14"},
      {id: "b", text: "−2"},
      {id: "c", text: "8"},
      {id: "d", text: "14"},
    ],
  },
  {
    id: "simplificacao-4",
    statement: "Qual é o coeficiente de −8x³?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "8"},
      {id: "b", text: "−8"},
      {id: "c", text: "3"},
      {id: "d", text: "x"},
    ],
  },
  {
    id: "simplificacao-5",
    statement: "Simplifique a expressão:\n12x − 5x + 2x",
    correctOptionId: "c",
    options: [
      {id: "a", text: "7x"},
      {id: "b", text: "8x"},
      {id: "c", text: "9x"},
      {id: "d", text: "19x"},
    ],
  },
  {
    id: "distributiva-1",
    statement: "Simplifique a expressão:\n2(3x − 4) + x",
    correctOptionId: "b",
    options: [
      {id: "a", text: "6x − 8"},
      {id: "b", text: "7x − 8"},
      {id: "c", text: "7x − 4"},
      {id: "d", text: "5x − 8"},
    ],
  },
  {
    id: "distributiva-2",
    statement: "Simplifique a expressão:\n5a − 2(a + 3)",
    correctOptionId: "c",
    options: [
      {id: "a", text: "3a + 6"},
      {id: "b", text: "7a − 6"},
      {id: "c", text: "3a − 6"},
      {id: "d", text: "5a − 5"},
    ],
  },
  {
    id: "potencias-1",
    statement: "Efetue a multiplicação:\n(−3x²)(2x)",
    correctOptionId: "d",
    options: [
      {id: "a", text: "−6x²"},
      {id: "b", text: "6x³"},
      {id: "c", text: "−5x³"},
      {id: "d", text: "−6x³"},
    ],
  },
  {
    id: "produto-notavel-1",
    statement: "Desenvolva o produto:\n(x + 3)(x − 2)",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x² + x − 6"},
      {id: "b", text: "x² − x − 6"},
      {id: "c", text: "x² + 5x + 6"},
      {id: "d", text: "x² + x + 6"},
    ],
  },
  {
    id: "divisao-monomios-1",
    statement: "Simplifique a expressão:\n(12x³y²) / (3xy)",
    correctOptionId: "b",
    options: [
      {id: "a", text: "4x³y"},
      {id: "b", text: "4x²y"},
      {id: "c", text: "9x²y"},
      {id: "d", text: "4xy²"},
    ],
  },
  {
    id: "fator-comum-1",
    statement: "Fatore a expressão:\n6x + 9",
    correctOptionId: "a",
    options: [
      {id: "a", text: "3(2x + 3)"},
      {id: "b", text: "6(x + 3)"},
      {id: "c", text: "3(2x + 9)"},
      {id: "d", text: "9(6x + 1)"},
    ],
  },
  {
    id: "quociente-potencias-1",
    statement: "Simplifique, considerando x ≠ 0:\nx⁵ / x²",
    correctOptionId: "c",
    options: [
      {id: "a", text: "x²"},
      {id: "b", text: "x⁷"},
      {id: "c", text: "x³"},
      {id: "d", text: "3x"},
    ],
  },
  {
    id: "potencia-potencia-1",
    statement: "Simplifique a expressão:\n(2x²)³",
    correctOptionId: "d",
    options: [
      {id: "a", text: "6x⁵"},
      {id: "b", text: "8x⁵"},
      {id: "c", text: "6x⁶"},
      {id: "d", text: "8x⁶"},
    ],
  },
  {
    id: "distributiva-3",
    statement: "Simplifique a expressão:\n3(x + 2) − 2(x − 1)",
    correctOptionId: "b",
    options: [
      {id: "a", text: "x + 4"},
      {id: "b", text: "x + 8"},
      {id: "c", text: "5x + 4"},
      {id: "d", text: "x − 8"},
    ],
  },
  {
    id: "valor-numerico-1",
    statement: "Calcule 2a² − 3a para a = −2.",
    correctOptionId: "c",
    options: [
      {id: "a", text: "2"},
      {id: "b", text: "8"},
      {id: "c", text: "14"},
      {id: "d", text: "−14"},
    ],
  },
  {
    id: "quadrado-soma-1",
    statement: "Desenvolva o produto notável:\n(x + 4)²",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x² + 8x + 16"},
      {id: "b", text: "x² + 4x + 16"},
      {id: "c", text: "x² + 16"},
      {id: "d", text: "x² − 8x + 16"},
    ],
  },
  {
    id: "diferenca-quadrados-1",
    statement: "Fatore a expressão:\nx² − 9",
    correctOptionId: "d",
    options: [
      {id: "a", text: "(x − 9)(x + 1)"},
      {id: "b", text: "(x − 3)²"},
      {id: "c", text: "(x + 3)²"},
      {id: "d", text: "(x − 3)(x + 3)"},
    ],
  },
  {
    id: "soma-fracoes-algebricas-1",
    statement: "Simplifique a expressão:\nx/2 + x/3",
    correctOptionId: "b",
    options: [
      {id: "a", text: "2x/5"},
      {id: "b", text: "5x/6"},
      {id: "c", text: "x/5"},
      {id: "d", text: "2x/6"},
    ],
  },
  {
    id: "termos-semelhantes-1",
    statement: "Simplifique:\n4x²y − 7x²y + 2x²y",
    correctOptionId: "c",
    options: [
      {id: "a", text: "x²y"},
      {id: "b", text: "−3x²y"},
      {id: "c", text: "−x²y"},
      {id: "d", text: "9x²y"},
    ],
  },
  {
    id: "sintese-algebrica-1",
    statement: "Simplifique:\n2(x + 1) + (x − 3)(x + 3)",
    correctOptionId: "a",
    options: [
      {id: "a", text: "x² + 2x − 7"},
      {id: "b", text: "x² + 2x + 7"},
      {id: "c", text: "2x² − 7"},
      {id: "d", text: "x² − 2x − 7"},
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
