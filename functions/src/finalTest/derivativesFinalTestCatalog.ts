import {
  PublicFinalTestQuestion,
  TrustedFinalTestQuestion,
} from "./algebraFinalTestCatalog";

export const DERIVATIVES_FINAL_TEST_CATALOG:
readonly TrustedFinalTestQuestion[] = [
  {
    id: "final-derivatives-v1-01",
    statement:
      "Qual e a principal interpretacao geometrica da derivada f'(a)?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "A area sob o grafico"},
      {id: "b", text: "A inclinacao da reta tangente"},
      {id: "c", text: "O valor maximo da funcao"},
      {id: "d", text: "A distancia ate a origem"},
    ],
  },
  {
    id: "final-derivatives-v1-02",
    statement: "Se f(x) = x^3, qual e f'(x)?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "x^2"},
      {id: "b", text: "3x"},
      {id: "c", text: "3x^2"},
      {id: "d", text: "x^4/4"},
    ],
  },
  {
    id: "final-derivatives-v1-03",
    statement: "Calcule a derivada de f(x) = 5x^2 - 3x + 4.",
    correctOptionId: "a",
    options: [
      {id: "a", text: "10x - 3"},
      {id: "b", text: "5x - 3"},
      {id: "c", text: "10x + 4"},
      {id: "d", text: "10x^2 - 3"},
    ],
  },
  {
    id: "final-derivatives-v1-04",
    statement: "Qual e a derivada da funcao constante f(x) = 12?",
    correctOptionId: "d",
    options: [
      {id: "a", text: "12"},
      {id: "b", text: "1"},
      {id: "c", text: "12x"},
      {id: "d", text: "0"},
    ],
  },
  {
    id: "final-derivatives-v1-05",
    statement: "Se f(x) = x, qual e o valor de f'(x)?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "0"},
      {id: "b", text: "1"},
      {id: "c", text: "x"},
      {id: "d", text: "2x"},
    ],
  },
  {
    id: "final-derivatives-v1-06",
    statement: "Para x > 0, qual e a derivada de f(x) = sqrt(x)?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "sqrt(x)/2"},
      {id: "b", text: "2sqrt(x)"},
      {id: "c", text: "1/(2sqrt(x))"},
      {id: "d", text: "1/sqrt(x)"},
    ],
  },
  {
    id: "final-derivatives-v1-07",
    statement: "Para x != 0, qual e a derivada de f(x) = 1/x?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "-1/x^2"},
      {id: "b", text: "1/x^2"},
      {id: "c", text: "-1/x"},
      {id: "d", text: "0"},
    ],
  },
  {
    id: "final-derivatives-v1-08",
    statement: "Calcule a derivada de f(x) = x^2(x + 1).",
    correctOptionId: "d",
    options: [
      {id: "a", text: "2x(x + 1)"},
      {id: "b", text: "3x^2 + 1"},
      {id: "c", text: "x^2 + 2x"},
      {id: "d", text: "3x^2 + 2x"},
    ],
  },
  {
    id: "final-derivatives-v1-09",
    statement: "Para x != 0, derive f(x) = (x^2 + 1)/x.",
    correctOptionId: "b",
    options: [
      {id: "a", text: "1 + 1/x^2"},
      {id: "b", text: "1 - 1/x^2"},
      {id: "c", text: "2x/x"},
      {id: "d", text: "x^2 - 1"},
    ],
  },
  {
    id: "final-derivatives-v1-10",
    statement: "Calcule a derivada de f(x) = (2x + 1)^3.",
    correctOptionId: "c",
    options: [
      {id: "a", text: "3(2x + 1)^2"},
      {id: "b", text: "6(2x + 1)"},
      {id: "c", text: "6(2x + 1)^2"},
      {id: "d", text: "(2x + 1)^2"},
    ],
  },
  {
    id: "final-derivatives-v1-11",
    statement: "Qual e a derivada de f(x) = sen(x)?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "cos(x)"},
      {id: "b", text: "-cos(x)"},
      {id: "c", text: "sen(x)"},
      {id: "d", text: "-sen(x)"},
    ],
  },
  {
    id: "final-derivatives-v1-12",
    statement: "Qual e a derivada de f(x) = cos(x)?",
    correctOptionId: "d",
    options: [
      {id: "a", text: "sen(x)"},
      {id: "b", text: "cos(x)"},
      {id: "c", text: "-cos(x)"},
      {id: "d", text: "-sen(x)"},
    ],
  },
  {
    id: "final-derivatives-v1-13",
    statement: "Qual e a derivada de f(x) = e^x?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "x * e^(x - 1)"},
      {id: "b", text: "e^x"},
      {id: "c", text: "1/e^x"},
      {id: "d", text: "ln(x)"},
    ],
  },
  {
    id: "final-derivatives-v1-14",
    statement: "Para x > 0, qual e a derivada de f(x) = ln(x)?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "ln(x)/x"},
      {id: "b", text: "x"},
      {id: "c", text: "1/x"},
      {id: "d", text: "e^x"},
    ],
  },
  {
    id: "final-derivatives-v1-15",
    statement:
      "Qual e a inclinacao da reta tangente a f(x) = x^2 " +
      "no ponto em que x = 2?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "4"},
      {id: "b", text: "2"},
      {id: "c", text: "1"},
      {id: "d", text: "0"},
    ],
  },
  {
    id: "final-derivatives-v1-16",
    statement: "Qual e a reta tangente a f(x) = x^2 no ponto (1, 1)?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "y = x + 1"},
      {id: "b", text: "y = x - 1"},
      {id: "c", text: "y = 2x - 1"},
      {id: "d", text: "y = 2x + 1"},
    ],
  },
  {
    id: "final-derivatives-v1-17",
    statement:
      "Em qual valor de x a funcao f(x) = x^2 - 4x " +
      "possui derivada igual a zero?",
    correctOptionId: "d",
    options: [
      {id: "a", text: "-4"},
      {id: "b", text: "-2"},
      {id: "c", text: "0"},
      {id: "d", text: "2"},
    ],
  },
  {
    id: "final-derivatives-v1-18",
    statement:
      "Se uma funcao e derivavel em x = a, " +
      "o que obrigatoriamente podemos afirmar?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "Ela possui maximo em a"},
      {id: "b", text: "Ela e continua em a"},
      {id: "c", text: "Sua derivada e zero em a"},
      {id: "d", text: "Ela e uma funcao polinomial"},
    ],
  },
  {
    id: "final-derivatives-v1-19",
    statement: "Por que f(x) = |x| nao e derivavel em x = 0?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "As derivadas laterais sao diferentes"},
      {id: "b", text: "A funcao nao esta definida em zero"},
      {id: "c", text: "O limite da funcao e infinito"},
      {id: "d", text: "A funcao nao e continua em zero"},
    ],
  },
  {
    id: "final-derivatives-v1-20",
    statement:
      "A posicao de um movel e s(t) = t^2 + 3t, em metros. " +
      "Qual e sua velocidade instantanea em t = 2 s?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "4 m/s"},
      {id: "b", text: "5 m/s"},
      {id: "c", text: "7 m/s"},
      {id: "d", text: "10 m/s"},
    ],
  },
];

/**
 * Returns a trusted derivatives question by id.
 * @param {string} questionId Trusted question id.
 * @return {TrustedFinalTestQuestion|undefined} Trusted question when found.
 */
export function getDerivativesFinalTestQuestion(
  questionId: string,
): TrustedFinalTestQuestion | undefined {
  return DERIVATIVES_FINAL_TEST_CATALOG.find(
    (question) => question.id === questionId,
  );
}

/**
 * Removes the trusted answer key before returning a question to the client.
 * @param {TrustedFinalTestQuestion} question Trusted question.
 * @return {PublicFinalTestQuestion} Public question without the answer key.
 */
export function toPublicDerivativesFinalTestQuestion(
  question: TrustedFinalTestQuestion,
): PublicFinalTestQuestion {
  return {
    id: question.id,
    statement: question.statement,
    options: question.options.map((option) => ({
      id: option.id,
      text: option.text,
    })),
  };
}
