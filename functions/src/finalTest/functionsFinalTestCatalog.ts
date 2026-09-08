import {
  PublicFinalTestQuestion,
  TrustedFinalTestQuestion,
} from "./algebraFinalTestCatalog";

/**
 * Canonical server-exclusive Functions final-test catalog.
 *
 * These questions must not be copied into the Flutter application.
 * Only the backend owns correctOptionId.
 */
export const FUNCTIONS_FINAL_TEST_CATALOG:
readonly TrustedFinalTestQuestion[] = [
  {
    id: "final-functions-v1-01",
    statement: "Considere f(x) = sqrt(x - 5). Qual e o dominio de f?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "x < 5"},
      {id: "b", text: "x <= 5"},
      {id: "c", text: "x >= 5"},
      {id: "d", text: "Todos os numeros reais"},
    ],
  },
  {
    id: "final-functions-v1-02",
    statement: "Se f(x) = 2x + 3 e g(x) = x - 1, determine (f o g)(x).",
    correctOptionId: "b",
    options: [
      {id: "a", text: "2x + 3"},
      {id: "b", text: "2x + 1"},
      {id: "c", text: "2x - 1"},
      {id: "d", text: "x + 2"},
    ],
  },
  {
    id: "final-functions-v1-03",
    statement: "Se f(x) = 4x - 8, qual e a funcao inversa de f?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "f^-1(x) = (x + 8) / 4"},
      {id: "b", text: "f^-1(x) = (x - 8) / 4"},
      {id: "c", text: "f^-1(x) = 4x + 8"},
      {id: "d", text: "f^-1(x) = 1 / (4x - 8)"},
    ],
  },
  {
    id: "final-functions-v1-04",
    statement: "Considere f(x) = x^4 + 2x^2 + 1. Quanto a paridade, f e:",
    correctOptionId: "a",
    options: [
      {id: "a", text: "Par"},
      {id: "b", text: "Impar"},
      {id: "c", text: "Nem par nem impar"},
      {id: "d", text: "Constante"},
    ],
  },
  {
    id: "final-functions-v1-05",
    statement: "Considere f(x) = x^2 - 6x + 5. Qual e o menor valor de f?",
    correctOptionId: "d",
    options: [
      {id: "a", text: "5"},
      {id: "b", text: "0"},
      {id: "c", text: "-3"},
      {id: "d", text: "-4"},
    ],
  },
  {
    id: "final-functions-v1-06",
    statement: "Se f(x) = 3x^2 - 2x + 4, qual e o valor de f(2)?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "8"},
      {id: "b", text: "10"},
      {id: "c", text: "12"},
      {id: "d", text: "16"},
    ],
  },
  {
    id: "final-functions-v1-07",
    statement: "Quais sao os zeros de f(x) = x^2 - 7x + 12?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "x = 2 e x = 6"},
      {id: "b", text: "x = 3 e x = 4"},
      {id: "c", text: "x = -3 e x = -4"},
      {id: "d", text: "x = 1 e x = 12"},
    ],
  },
  {
    id: "final-functions-v1-08",
    statement: "Na funcao f(x) = -5x + 7, qual e o coeficiente angular?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "-5"},
      {id: "b", text: "5"},
      {id: "c", text: "7"},
      {id: "d", text: "-7"},
    ],
  },
  {
    id: "final-functions-v1-09",
    statement: "Se f(x) = x + 4 e g(x) = 2x, determine (g o f)(x).",
    correctOptionId: "d",
    options: [
      {id: "a", text: "2x + 4"},
      {id: "b", text: "x + 8"},
      {id: "c", text: "2x + 6"},
      {id: "d", text: "2x + 8"},
    ],
  },
  {
    id: "final-functions-v1-10",
    statement: "Qual e a imagem da funcao f(x) = |x| + 2?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "y <= 2"},
      {id: "b", text: "y > 2"},
      {id: "c", text: "y >= 2"},
      {id: "d", text: "Todos os numeros reais"},
    ],
  },
  {
    id: "final-functions-v1-11",
    statement: "Qual e o dominio de f(x) = 1 / (x - 4)?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "Todos os reais"},
      {id: "b", text: "Todos os reais, exceto x = 4"},
      {id: "c", text: "x > 4"},
      {id: "d", text: "x >= 4"},
    ],
  },
  {
    id: "final-functions-v1-12",
    statement: "Se f(x) = x^3 - 2x + 1, qual e o valor de f(-1)?",
    correctOptionId: "d",
    options: [
      {id: "a", text: "-4"},
      {id: "b", text: "-2"},
      {id: "c", text: "0"},
      {id: "d", text: "2"},
    ],
  },
  {
    id: "final-functions-v1-13",
    statement: "Qual e o vertice da parabola f(x) = x^2 - 4x + 1?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "(2, -3)"},
      {id: "b", text: "(-2, -3)"},
      {id: "c", text: "(2, 3)"},
      {id: "d", text: "(4, 1)"},
    ],
  },
  {
    id: "final-functions-v1-14",
    statement: "A funcao f(x) = 6x - 2 e:",
    correctOptionId: "c",
    options: [
      {id: "a", text: "Decrescente"},
      {id: "b", text: "Constante"},
      {id: "c", text: "Crescente"},
      {id: "d", text: "Nem crescente nem decrescente"},
    ],
  },
  {
    id: "final-functions-v1-15",
    statement: "Em que ponto f(x) = 3x - 9 intercepta o eixo y?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "(3, 0)"},
      {id: "b", text: "(0, -9)"},
      {id: "c", text: "(0, 9)"},
      {id: "d", text: "(-9, 0)"},
    ],
  },
  {
    id: "final-functions-v1-16",
    statement: "Se f(x) = 5x + 10, qual e f^-1(x)?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "(x + 10) / 5"},
      {id: "b", text: "5x - 10"},
      {id: "c", text: "(x - 10) / 5"},
      {id: "d", text: "1 / (5x + 10)"},
    ],
  },
  {
    id: "final-functions-v1-17",
    statement: "Se f(x) = x^2 e g(x) = x - 2, determine (f o g)(x).",
    correctOptionId: "a",
    options: [
      {id: "a", text: "(x - 2)^2"},
      {id: "b", text: "x^2 - 2"},
      {id: "c", text: "x^2 + 2"},
      {id: "d", text: "2x - 2"},
    ],
  },
  {
    id: "final-functions-v1-18",
    statement: "Considere f(x) = x^5 - 3x. Quanto a paridade, f e:",
    correctOptionId: "d",
    options: [
      {id: "a", text: "Par"},
      {id: "b", text: "Constante"},
      {id: "c", text: "Nem par nem impar"},
      {id: "d", text: "Impar"},
    ],
  },
  {
    id: "final-functions-v1-19",
    statement: "Se f(x) = 3^x, qual e o valor de f(2)?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "6"},
      {id: "b", text: "9"},
      {id: "c", text: "8"},
      {id: "d", text: "12"},
    ],
  },
  {
    id: "final-functions-v1-20",
    statement: "Qual e a imagem de f(x) = -(x + 2)^2 + 5?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "y <= 5"},
      {id: "b", text: "y >= 5"},
      {id: "c", text: "y <= -2"},
      {id: "d", text: "Todos os numeros reais"},
    ],
  },
];

/**
 * Returns a trusted Functions question by ID.
 *
 * @param {string} questionId Question identifier.
 * @return {TrustedFinalTestQuestion | undefined} Trusted question.
 */
export function getFunctionsFinalTestQuestion(
  questionId: string,
): TrustedFinalTestQuestion | undefined {
  return FUNCTIONS_FINAL_TEST_CATALOG.find(
    (question) =>
      question.id === questionId,
  );
}

/**
 * Removes the answer key before a Functions question leaves the backend.
 *
 * @param {TrustedFinalTestQuestion} question Trusted question.
 * @return {PublicFinalTestQuestion} Safe public question.
 */
export function toPublicFunctionsFinalTestQuestion(
  question: TrustedFinalTestQuestion,
): PublicFinalTestQuestion {
  return {
    id: question.id,
    statement: question.statement,
    options: question.options,
  };
}
