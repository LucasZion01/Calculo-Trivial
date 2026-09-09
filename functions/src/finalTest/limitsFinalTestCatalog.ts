import {
  PublicFinalTestQuestion,
  TrustedFinalTestQuestion,
} from "./algebraFinalTestCatalog";

/**
 * Canonical server-exclusive Limits final-test catalog.
 *
 * These questions must not be copied into the Flutter application.
 * Only the backend owns correctOptionId.
 */
export const LIMITS_FINAL_TEST_CATALOG:
readonly TrustedFinalTestQuestion[] = [
  {
    id: "final-limits-v1-01",
    statement: "Calcule: lim x -> 2 de (3x^2 - x + 2).",
    correctOptionId: "c",
    options: [
      {id: "a", text: "8"},
      {id: "b", text: "10"},
      {id: "c", text: "12"},
      {id: "d", text: "14"},
    ],
  },
  {
    id: "final-limits-v1-02",
    statement: "Calcule: lim x -> 3 de (x^2 - 9) / (x - 3).",
    correctOptionId: "d",
    options: [
      {id: "a", text: "0"},
      {id: "b", text: "3"},
      {id: "c", text: "9"},
      {id: "d", text: "6"},
    ],
  },
  {
    id: "final-limits-v1-03",
    statement: "Calcule: lim x -> 0 de (sqrt(x + 16) - 4) / x.",
    correctOptionId: "b",
    options: [
      {id: "a", text: "1/4"},
      {id: "b", text: "1/8"},
      {id: "c", text: "8"},
      {id: "d", text: "0"},
    ],
  },
  {
    id: "final-limits-v1-04",
    statement: "Calcule: lim x -> 0 de sen(x) / x.",
    correctOptionId: "a",
    options: [
      {id: "a", text: "1"},
      {id: "b", text: "0"},
      {id: "c", text: "+infinito"},
      {id: "d", text: "Nao existe"},
    ],
  },
  {
    id: "final-limits-v1-05",
    statement: "Calcule: lim x -> infinito de (4x^2 + x - 1) / (2x^2 + 3).",
    correctOptionId: "c",
    options: [
      {id: "a", text: "0"},
      {id: "b", text: "1"},
      {id: "c", text: "2"},
      {id: "d", text: "4"},
    ],
  },
  {
    id: "final-limits-v1-06",
    statement:
      "Se f(x) se aproxima de 7 quando x se aproxima de 4 pelos dois lados, " +
      "qual e lim x -> 4 de f(x)?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "4"},
      {id: "b", text: "7"},
      {id: "c", text: "11"},
      {id: "d", text: "Nao existe"},
    ],
  },
  {
    id: "final-limits-v1-07",
    statement: "Calcule: lim x -> 5 de (x^2 - 25) / (x - 5).",
    correctOptionId: "c",
    options: [
      {id: "a", text: "0"},
      {id: "b", text: "5"},
      {id: "c", text: "10"},
      {id: "d", text: "25"},
    ],
  },
  {
    id: "final-limits-v1-08",
    statement: "Calcule: lim x -> infinito de (3x + 1) / (x^2 + 2).",
    correctOptionId: "a",
    options: [
      {id: "a", text: "0"},
      {id: "b", text: "1"},
      {id: "c", text: "3"},
      {id: "d", text: "+infinito"},
    ],
  },
  {
    id: "final-limits-v1-09",
    statement: "Calcule o limite lateral: lim x -> 0+ de |x| / x.",
    correctOptionId: "d",
    options: [
      {id: "a", text: "-1"},
      {id: "b", text: "0"},
      {id: "c", text: "Nao existe"},
      {id: "d", text: "1"},
    ],
  },
  {
    id: "final-limits-v1-10",
    statement: "Calcule: lim x -> 0 de |x| / x.",
    correctOptionId: "c",
    options: [
      {id: "a", text: "-1"},
      {id: "b", text: "0"},
      {id: "c", text: "Nao existe"},
      {id: "d", text: "1"},
    ],
  },
  {
    id: "final-limits-v1-11",
    statement: "Calcule: lim x -> -2 de (x^3 + x).",
    correctOptionId: "b",
    options: [
      {id: "a", text: "-6"},
      {id: "b", text: "-10"},
      {id: "c", text: "10"},
      {id: "d", text: "-8"},
    ],
  },
  {
    id: "final-limits-v1-12",
    statement: "Calcule: lim x -> 4 de (x^2 - 16) / (x - 4).",
    correctOptionId: "d",
    options: [
      {id: "a", text: "0"},
      {id: "b", text: "4"},
      {id: "c", text: "16"},
      {id: "d", text: "8"},
    ],
  },
  {
    id: "final-limits-v1-13",
    statement: "Calcule: lim x -> 9 de (sqrt(x) - 3) / (x - 9).",
    correctOptionId: "c",
    options: [
      {id: "a", text: "1/3"},
      {id: "b", text: "1/9"},
      {id: "c", text: "1/6"},
      {id: "d", text: "6"},
    ],
  },
  {
    id: "final-limits-v1-14",
    statement: "Calcule: lim x -> 0 de sen(3x) / x.",
    correctOptionId: "a",
    options: [
      {id: "a", text: "3"},
      {id: "b", text: "1"},
      {id: "c", text: "0"},
      {id: "d", text: "Nao existe"},
    ],
  },
  {
    id: "final-limits-v1-15",
    statement: "Calcule: lim x -> 0 de (1 - cos(x)) / x.",
    correctOptionId: "b",
    options: [
      {id: "a", text: "1"},
      {id: "b", text: "0"},
      {id: "c", text: "1/2"},
      {id: "d", text: "+infinito"},
    ],
  },
  {
    id: "final-limits-v1-16",
    statement: "Calcule: lim x -> infinito de (6x^3 - x) / (3x^3 + 2).",
    correctOptionId: "c",
    options: [
      {id: "a", text: "0"},
      {id: "b", text: "1/2"},
      {id: "c", text: "2"},
      {id: "d", text: "+infinito"},
    ],
  },
  {
    id: "final-limits-v1-17",
    statement: "Calcule: lim x -> infinito de x^2 / (2x + 1).",
    correctOptionId: "d",
    options: [
      {id: "a", text: "0"},
      {id: "b", text: "1/2"},
      {id: "c", text: "-infinito"},
      {id: "d", text: "+infinito"},
    ],
  },
  {
    id: "final-limits-v1-18",
    statement: "Calcule o limite lateral: lim x -> 0+ de 1/x.",
    correctOptionId: "a",
    options: [
      {id: "a", text: "+infinito"},
      {id: "b", text: "-infinito"},
      {id: "c", text: "0"},
      {id: "d", text: "1"},
    ],
  },
  {
    id: "final-limits-v1-19",
    statement: "Calcule o limite lateral: lim x -> 0- de 1/x.",
    correctOptionId: "b",
    options: [
      {id: "a", text: "+infinito"},
      {id: "b", text: "-infinito"},
      {id: "c", text: "0"},
      {id: "d", text: "-1"},
    ],
  },
  {
    id: "final-limits-v1-20",
    statement: "Calcule: lim x -> 0 de 1/x.",
    correctOptionId: "c",
    options: [
      {id: "a", text: "+infinito"},
      {id: "b", text: "-infinito"},
      {id: "c", text: "Nao existe"},
      {id: "d", text: "0"},
    ],
  },
];

/**
 * Returns a trusted Limits final-test question by id.
 * @param {string} questionId Question identifier.
 * @return {TrustedFinalTestQuestion|undefined} Trusted question when found.
 */
export function getLimitsFinalTestQuestion(
  questionId: string,
): TrustedFinalTestQuestion | undefined {
  return LIMITS_FINAL_TEST_CATALOG.find(
    (question) => question.id === questionId,
  );
}

/**
 * Removes the answer key before sending a Limits question to the client.
 * @param {TrustedFinalTestQuestion} question Trusted server question.
 * @return {PublicFinalTestQuestion} Question safe for the client.
 */
export function toPublicLimitsFinalTestQuestion(
  question: TrustedFinalTestQuestion,
): PublicFinalTestQuestion {
  return {
    id: question.id,
    statement: question.statement,
    options: question.options,
  };
}
