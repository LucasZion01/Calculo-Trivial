import {
  LessonContent,
} from "../content/contentTypes";
import {
  LocalContentRepository,
} from "../content/LocalContentRepository";

export const CONTENT_VERSION = "1.0.0";

export const CONTENT_CATALOG:
readonly LessonContent[] = [
  {
    contentVersion: CONTENT_VERSION,
    lessonId: "limites_indeterminacao_01",
    subject: "Limites e indeterminações",
    questions: [
      {
        contentVersion: CONTENT_VERSION,
        lessonId: "limites_indeterminacao_01",
        questionId: "limites_q_014",
        subject: "Limites com fatoração",
        statement:
          "Calcule lim x→2 de (x² − 4) / (x − 2).",
        options: [
          {
            id: "a",
            text: "0",
          },
          {
            id: "b",
            text: "2",
          },
          {
            id: "c",
            text: "4",
          },
          {
            id: "d",
            text: "O limite não existe",
          },
        ],
        correctOptionId: "c",
        originalExplanation:
          "Fatore x² − 4 como (x − 2)(x + 2). " +
          "Para x ≠ 2, a expressão equivale a x + 2. " +
          "Assim, quando x tende a 2, o limite é 4.",
        references: [
          {
            sourceId: "stewart_calculo_v1_8ed",
            sectionId: "limites_continuidade",
          },
          {
            sourceId: "thomas_calculo_v1_12ed",
            sectionId: "limites_continuidade",
          },
        ],
      },
      {
        contentVersion: CONTENT_VERSION,
        lessonId: "limites_indeterminacao_01",
        questionId: "limites_q_015",
        subject: "Limites com racionalização",
        statement:
          "Calcule lim x→9 de " +
          "(√x − 3) / (x − 9).",
        options: [
          {
            id: "a",
            text: "1/3",
          },
          {
            id: "b",
            text: "1/6",
          },
          {
            id: "c",
            text: "3",
          },
          {
            id: "d",
            text: "6",
          },
        ],
        correctOptionId: "b",
        originalExplanation:
          "Multiplique numerador e denominador pelo conjugado " +
          "√x + 3. A expressão se reduz a 1 / (√x + 3) " +
          "para x ≠ 9. O limite é 1/6.",
        references: [
          {
            sourceId: "guidorizzi_calculo_v1_6ed",
            sectionId: "limites_continuidade",
          },
        ],
      },
      {
        contentVersion: CONTENT_VERSION,
        lessonId: "limites_indeterminacao_01",
        questionId: "limites_q_016",
        subject: "Teorema do confronto",
        statement:
          "Se −x² ≤ f(x) ≤ x² perto de x = 0, " +
          "qual é lim x→0 de f(x)?",
        options: [
          {
            id: "a",
            text: "−1",
          },
          {
            id: "b",
            text: "0",
          },
          {
            id: "c",
            text: "1",
          },
          {
            id: "d",
            text: "Não é possível determinar",
          },
        ],
        correctOptionId: "b",
        originalExplanation:
          "Tanto −x² quanto x² tendem a 0 quando x tende " +
          "a 0. Pelo teorema do confronto, f(x) também " +
          "tende a 0.",
        references: [
          {
            sourceId: "guidorizzi_calculo_v1_6ed",
            sectionId: "teorema_confronto",
          },
          {
            sourceId: "iezzi_fme_v8_7ed",
            sectionId: "teorema_confronto",
          },
        ],
      },
    ],
  },
  {
    contentVersion: CONTENT_VERSION,
    lessonId: "limites_continuidade_01",
    subject: "Continuidade",
    questions: [
      {
        contentVersion: CONTENT_VERSION,
        lessonId: "limites_continuidade_01",
        questionId: "continuidade_q_001",
        subject: "Continuidade em um ponto",
        statement:
          "Uma função satisfaz lim x→3 f(x) = 7 e f(3) = 7. " +
          "O que podemos concluir?",
        options: [
          {
            id: "a",
            text: "A função é contínua em x = 3",
          },
          {
            id: "b",
            text: "A função é descontínua em x = 3",
          },
          {
            id: "c",
            text: "O limite não existe",
          },
          {
            id: "d",
            text: "f(3) deve ser 3",
          },
        ],
        correctOptionId: "a",
        originalExplanation:
          "Uma função é contínua em um ponto quando o limite " +
          "nesse ponto existe e é igual ao valor da função. " +
          "Aqui, ambos são iguais a 7.",
        references: [
          {
            sourceId: "thomas_calculo_v1_12ed",
            sectionId: "continuidade",
          },
          {
            sourceId: "guidorizzi_calculo_v1_6ed",
            sectionId: "continuidade",
          },
        ],
      },
      {
        contentVersion: CONTENT_VERSION,
        lessonId: "limites_continuidade_01",
        questionId: "continuidade_q_002",
        subject: "Limites laterais",
        statement:
          "Se lim x→2− f(x) = 4 e lim x→2+ f(x) = 5, " +
          "qual é lim x→2 f(x)?",
        options: [
          {
            id: "a",
            text: "4",
          },
          {
            id: "b",
            text: "5",
          },
          {
            id: "c",
            text: "4,5",
          },
          {
            id: "d",
            text: "O limite não existe",
          },
        ],
        correctOptionId: "d",
        originalExplanation:
          "O limite bilateral só existe quando os limites " +
          "laterais existem e são iguais. Como 4 ≠ 5, " +
          "o limite bilateral não existe.",
        references: [
          {
            sourceId: "thomas_calculo_v1_12ed",
            sectionId: "limites_laterais",
          },
          {
            sourceId: "guidorizzi_calculo_v1_6ed",
            sectionId: "limites_laterais",
          },
        ],
      },
    ],
  },
] as const;

export const contentRepository =
  new LocalContentRepository(CONTENT_CATALOG);
