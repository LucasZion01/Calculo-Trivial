import {
  PublicFinalTestQuestion,
  TrustedFinalTestQuestion,
} from "./algebraFinalTestCatalog";

export const CONTINUITY_FINAL_TEST_CATALOG:
readonly TrustedFinalTestQuestion[] = [
  {
    id: "final-continuity-v1-01",
    statement:
      "Para uma funcao f ser continua em x = a, " +
      "quais condicoes devem ser satisfeitas?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "Somente f(a) deve existir"},
      {id: "b", text: "Somente o limite deve existir"},
      {
        id: "c",
        text: "f(a) existe, o limite existe e lim x -> a f(x) = f(a)",
      },
      {id: "d", text: "A derivada de f deve ser zero"},
    ],
  },
  {
    id: "final-continuity-v1-02",
    statement: "Em quais numeros reais f(x) = 3x^2 - 2x + 5 e continua?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "Em todos os numeros reais"},
      {id: "b", text: "Somente para x > 0"},
      {id: "c", text: "Somente para x != 0"},
      {id: "d", text: "Somente nos numeros inteiros"},
    ],
  },
  {
    id: "final-continuity-v1-03",
    statement:
      "Onde f(x) = (x + 1) / (x - 2) nao e continua?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "x = -1"},
      {id: "b", text: "x = 2"},
      {id: "c", text: "x = 0"},
      {id: "d", text: "Ela e continua em todo R"},
    ],
  },
  {
    id: "final-continuity-v1-04",
    statement:
      "Considere f(x) = (x^2 - 1)/(x - 1), se x != 1, " +
      "e f(1) = 2. A funcao e continua em x = 1?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "Sim, pois o limite e f(1) valem 2"},
      {id: "b", text: "Nao, pois o limite vale 0"},
      {id: "c", text: "Nao, pois f(1) nao existe"},
      {id: "d", text: "Sim, pois toda funcao racional e continua"},
    ],
  },
  {
    id: "final-continuity-v1-05",
    statement:
      "Considere f(x) = (x^2 - 1)/(x - 1), se x != 1, " +
      "e f(1) = 3. Que tipo de descontinuidade ocorre em x = 1?",
    correctOptionId: "d",
    options: [
      {id: "a", text: "Nenhuma; a funcao e continua"},
      {id: "b", text: "Descontinuidade infinita"},
      {id: "c", text: "Descontinuidade de salto"},
      {id: "d", text: "Descontinuidade removivel"},
    ],
  },
  {
    id: "final-continuity-v1-06",
    statement:
      "Se f(x) = x + 1 para x < 1 e f(x) = 2x para x >= 1, " +
      "f e continua em x = 1?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "Nao, pois os limites laterais nao existem"},
      {id: "b", text: "Sim, pois os dois limites e f(1) valem 2"},
      {id: "c", text: "Nao, pois f(1) = 1"},
      {id: "d", text: "Sim, pois f(1) = 0"},
    ],
  },
  {
    id: "final-continuity-v1-07",
    statement:
      "Se f(x) = -1 para x < 0 e f(x) = 1 para x >= 0, o que ocorre em x = 0?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "A funcao e continua"},
      {id: "b", text: "Ha uma descontinuidade removivel"},
      {id: "c", text: "Ha uma descontinuidade de salto"},
      {id: "d", text: "Ha uma descontinuidade infinita"},
    ],
  },
  {
    id: "final-continuity-v1-08",
    statement:
      "Qual tipo de descontinuidade f(x) = 1/(x - 2) " +
      "possui em x = 2?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "Infinita"},
      {id: "b", text: "Removivel"},
      {id: "c", text: "De salto finito"},
      {id: "d", text: "Nenhuma"},
    ],
  },
  {
    id: "final-continuity-v1-09",
    statement: "A funcao f(x) = |x| e continua em x = 0?",
    correctOptionId: "d",
    options: [
      {id: "a", text: "Nao, porque existe uma ponta no grafico"},
      {id: "b", text: "Nao, porque o limite vale 1"},
      {id: "c", text: "Somente pela direita"},
      {id: "d", text: "Sim"},
    ],
  },
  {
    id: "final-continuity-v1-10",
    statement:
      "A funcao parte inteira f(x) = floor(x) apresenta qual " +
      "comportamento nos numeros inteiros?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "E continua em todos eles"},
      {id: "b", text: "Possui descontinuidades de salto"},
      {id: "c", text: "Possui somente furos removiveis"},
      {id: "d", text: "Tende sempre ao infinito"},
    ],
  },
  {
    id: "final-continuity-v1-11",
    statement: "Em qual conjunto a funcao f(x) = sen(x) e continua?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "Somente em [0, 2pi]"},
      {id: "b", text: "Somente para x != 0"},
      {id: "c", text: "Em todo R"},
      {id: "d", text: "Somente nos multiplos de pi"},
    ],
  },
  {
    id: "final-continuity-v1-12",
    statement: "Em seu dominio real, onde f(x) = sqrt(x) e continua?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "[0, +infinito)"},
      {id: "b", text: "(-infinito, 0]"},
      {id: "c", text: "R exceto 0"},
      {id: "d", text: "Somente em x = 0"},
    ],
  },
  {
    id: "final-continuity-v1-13",
    statement:
      "Se g e continua em a e f e continua em g(a), " +
      "o que podemos afirmar sobre f(g(x)) em a?",
    correctOptionId: "d",
    options: [
      {id: "a", text: "E sempre descontinua"},
      {id: "b", text: "Seu limite e necessariamente zero"},
      {id: "c", text: "Nada pode ser concluido"},
      {id: "d", text: "E continua em a"},
    ],
  },
  {
    id: "final-continuity-v1-14",
    statement:
      "Uma funcao f e continua em [1, 2], com f(1) = -3 e f(2) = 4. " +
      "O que o Teorema do Valor Intermediario garante?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "f e uma funcao linear"},
      {id: "b", text: "Existe c em (1, 2) com f(c) = 0"},
      {id: "c", text: "f possui exatamente uma raiz"},
      {id: "d", text: "f(1,5) = 0 obrigatoriamente"},
    ],
  },
  {
    id: "final-continuity-v1-15",
    statement:
      "Se f(x) = x^2 para x != 2 e f(2) = k, " +
      "qual valor de k torna f continua em x = 2?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "0"},
      {id: "b", text: "2"},
      {id: "c", text: "4"},
      {id: "d", text: "8"},
    ],
  },
  {
    id: "final-continuity-v1-16",
    statement:
      "Se f(x) = 2x + 1 para x < 1 e f(x) = x + k para x >= 1, " +
      "qual valor de k torna f continua em x = 1?",
    correctOptionId: "a",
    options: [
      {id: "a", text: "2"},
      {id: "b", text: "1"},
      {id: "c", text: "3"},
      {id: "d", text: "-2"},
    ],
  },
  {
    id: "final-continuity-v1-17",
    statement:
      "O limite lim x -> a f(x) existe e e finito, " +
      "mas f(a) nao esta definida. f e continua em a?",
    correctOptionId: "c",
    options: [
      {id: "a", text: "Sim, pois basta o limite existir"},
      {id: "b", text: "Sim, se a for positivo"},
      {id: "c", text: "Nao, pois f(a) precisa existir"},
      {id: "d", text: "Nao, pois o limite deveria ser infinito"},
    ],
  },
  {
    id: "final-continuity-v1-18",
    statement:
      "Para verificar a continuidade de f no extremo esquerdo a de [a, b], " +
      "qual limite e usado?",
    correctOptionId: "d",
    options: [
      {id: "a", text: "Somente o limite pela esquerda"},
      {id: "b", text: "Nenhum limite"},
      {id: "c", text: "Sempre um limite no infinito"},
      {id: "d", text: "O limite pela direita"},
    ],
  },
  {
    id: "final-continuity-v1-19",
    statement: "Quando uma descontinuidade e chamada de removivel?",
    correctOptionId: "a",
    options: [
      {
        id: "a",
        text: "Quando redefinir o valor no ponto pode tornar a funcao continua",
      },
      {id: "b", text: "Quando os limites laterais sao diferentes"},
      {id: "c", text: "Quando existe uma assintota vertical"},
      {id: "d", text: "Quando a funcao nao possui dominio"},
    ],
  },
  {
    id: "final-continuity-v1-20",
    statement: "Em quais intervalos f(x) = 1/x e continua?",
    correctOptionId: "b",
    options: [
      {id: "a", text: "Somente em (0, +infinito)"},
      {id: "b", text: "Em (-infinito, 0) e (0, +infinito)"},
      {id: "c", text: "Em todo R"},
      {id: "d", text: "Somente em x = 1"},
    ],
  },
];

/**
 * Returns a trusted continuity question by id.
 * @param {string} questionId Trusted question id.
 * @return {TrustedFinalTestQuestion|undefined} Trusted question when found.
 */
export function getContinuityFinalTestQuestion(
  questionId: string,
): TrustedFinalTestQuestion | undefined {
  return CONTINUITY_FINAL_TEST_CATALOG.find(
    (question) => question.id === questionId,
  );
}

/**
 * Removes the trusted answer key before returning a question to the client.
 * @param {TrustedFinalTestQuestion} question Trusted question.
 * @return {PublicFinalTestQuestion} Public question without the answer key.
 */
export function toPublicContinuityFinalTestQuestion(
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
