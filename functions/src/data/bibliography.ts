export interface BibliographicSection {
  id: string;
  section: string;
}

export interface BibliographicSource {
  sourceId: string;
  authors: readonly string[];
  title: string;
  volume: string;
  edition: string;
  publisher: string;
  publicationPlace: string;
  year: number;
  isbn13: string;
  sections: readonly BibliographicSection[];
}

export const RESERVED_BIBLIOGRAPHIC_SOURCE_IDS = [
  "thomas_calculo_v1_14ed",
  "guidorizzi_calculo_v1_5ed",
] as const;

export const BIBLIOGRAPHIC_SOURCES:
readonly BibliographicSource[] = [
  {
    sourceId: "stewart_calculo_v1_8ed",
    authors: [
      "James Stewart",
    ],
    title: "Cálculo",
    volume: "1",
    edition: "8. ed.",
    publisher: "Cengage Learning",
    publicationPlace: "São Paulo",
    year: 2017,
    isbn13: "978-85-221-2583-8",
    sections: [
      {
        id: "funcoes_modelos",
        section: "Capítulo 1 — Funções e modelos",
      },
      {
        id: "limites_continuidade",
        section:
          "Capítulo 2 — Limites e derivadas, seções 2.2–2.6",
      },
    ],
  },
  {
    sourceId: "thomas_calculo_v1_12ed",
    authors: [
      "George B. Thomas",
      "Maurice D. Weir",
      "Joel Hass",
    ],
    title: "Cálculo",
    volume: "1",
    edition: "12. ed.",
    publisher: "Pearson Education do Brasil",
    publicationPlace: "São Paulo",
    year: 2012,
    isbn13: "978-85-8143-086-7",
    sections: [
      {
        id: "funcoes_graficos",
        section: "Capítulo 1 — Funções e seus gráficos",
      },
      {
        id: "transformacoes_graficos",
        section:
          "Capítulo 1 — Combinação de funções, translações " +
          "e escalas de gráficos",
      },
      {
        id: "trigonometria",
        section: "Capítulo 1 — Funções trigonométricas",
      },
      {
        id: "limites_continuidade",
        section: "Capítulo 2 — Limites e continuidade",
      },
      {
        id: "limite_definicao",
        section:
          "Seções 2.2–2.3 — Limite de uma função e definição precisa",
      },
      {
        id: "limites_laterais",
        section: "Seção 2.4 — Limites laterais",
      },
      {
        id: "continuidade",
        section: "Seção 2.5 — Continuidade",
      },
      {
        id: "limites_infinito",
        section:
          "Seção 2.6 — Limites envolvendo o infinito; assíntotas",
      },
    ],
  },
  {
    sourceId: "guidorizzi_calculo_v1_6ed",
    authors: [
      "Hamilton Luiz Guidorizzi",
    ],
    title: "Um curso de cálculo",
    volume: "1",
    edition: "6. ed.",
    publisher: "LTC",
    publicationPlace: "Rio de Janeiro",
    year: 2018,
    isbn13: "978-85-216-3557-4",
    sections: [
      {
        id: "numeros_reais",
        section: "Capítulo 1 — Números reais",
      },
      {
        id: "funcoes",
        section: "Capítulo 2 — Funções",
      },
      {
        id: "trigonometria",
        section:
          "Seções 2.2–2.3 — Funções trigonométricas",
      },
      {
        id: "operacoes_funcoes",
        section: "Seção 2.4 — Operações com funções",
      },
      {
        id: "limites_continuidade",
        section: "Capítulo 3 — Limite e continuidade",
      },
      {
        id: "limite_definicao",
        section: "Seção 3.3 — Definição de limite",
      },
      {
        id: "limites_laterais",
        section: "Seção 3.4 — Limites laterais",
      },
      {
        id: "continuidade",
        section: "Seção 3.2 — Definição de função contínua",
      },
      {
        id: "teorema_confronto",
        section: "Seção 3.6 — Teorema do confronto",
      },
      {
        id: "limites_trigonometricos",
        section:
          "Seções 3.7–3.8 — Trigonometria e limite fundamental",
      },
      {
        id: "limites_infinito",
        section: "Capítulo 4 — Extensões do conceito de limite",
      },
      {
        id: "exponenciais_logaritmos",
        section: "Capítulo 6 — Funções exponencial e logarítmica",
      },
      {
        id: "funcoes_inversas",
        section: "Capítulo 8 — Funções inversas",
      },
    ],
  },
  {
    sourceId: "iezzi_fme_v1_9ed",
    authors: [
      "Gelson Iezzi",
      "Carlos Murakami",
    ],
    title: "Fundamentos de matemática elementar: conjuntos, funções",
    volume: "1",
    edition: "9. ed.",
    publisher: "Atual",
    publicationPlace: "São Paulo",
    year: 2013,
    isbn13: "978-85-357-1680-1",
    sections: [
      {
        id: "conjuntos_numericos",
        section: "Conjuntos numéricos",
      },
      {
        id: "introducao_funcoes",
        section: "Introdução às funções",
      },
      {
        id: "funcoes_elementares",
        section:
          "Funções constante, afim, quadrática, modular " +
          "e outras funções elementares",
      },
      {
        id: "composicao_inversa",
        section: "Função composta e função inversa",
      },
      {
        id: "equacoes_inequacoes_irracionais",
        section: "Equações e inequações irracionais",
      },
    ],
  },
  {
    sourceId: "iezzi_fme_v2_10ed",
    authors: [
      "Gelson Iezzi",
      "Osvaldo Dolce",
      "Carlos Murakami",
    ],
    title: "Fundamentos de matemática elementar: logaritmos",
    volume: "2",
    edition: "10. ed.",
    publisher: "Atual",
    publicationPlace: "São Paulo",
    year: 2013,
    isbn13: "978-85-357-1682-5",
    sections: [
      {
        id: "exponenciais_logaritmos",
        section:
          "Volume 2 — Potências, exponenciais e logaritmos",
      },
    ],
  },
  {
    sourceId: "iezzi_fme_v3_9ed",
    authors: [
      "Gelson Iezzi",
    ],
    title: "Fundamentos de matemática elementar: trigonometria",
    volume: "3",
    edition: "9. ed.",
    publisher: "Atual",
    publicationPlace: "São Paulo",
    year: 2013,
    isbn13: "978-85-357-1684-9",
    sections: [
      {
        id: "trigonometria",
        section: "Volume 3 — Trigonometria",
      },
    ],
  },
  {
    sourceId: "iezzi_fme_v7_6ed",
    authors: [
      "Gelson Iezzi",
    ],
    title: "Fundamentos de matemática elementar: geometria analítica",
    volume: "7",
    edition: "6. ed.",
    publisher: "Atual",
    publicationPlace: "São Paulo",
    year: 2013,
    isbn13: "978-85-357-1754-9",
    sections: [
      {
        id: "geometria_analitica",
        section: "Volume 7 — Geometria analítica",
      },
      {
        id: "conicas",
        section:
          "Volume 7 — Reta, circunferência e cônicas",
      },
    ],
  },
  {
    sourceId: "iezzi_fme_v8_7ed",
    authors: [
      "Gelson Iezzi",
      "Carlos Murakami",
      "Nilson José Machado",
    ],
    title:
      "Fundamentos de matemática elementar: limites, derivadas, " +
      "noções de integral",
    volume: "8",
    edition: "7. ed.",
    publisher: "Atual",
    publicationPlace: "São Paulo",
    year: 2013,
    isbn13: "978-85-357-1756-3",
    sections: [
      {
        id: "limites_continuidade",
        section:
          "Capítulos II–V — Limite, infinito, complementos sobre " +
          "limites e continuidade",
      },
      {
        id: "continuidade",
        section: "Capítulo V — Continuidade",
      },
      {
        id: "limites_infinito",
        section: "Capítulo III — O infinito",
      },
      {
        id: "teorema_confronto",
        section: "Capítulo IV — Complementos sobre limites",
      },
      {
        id: "limites_trigonometricos",
        section: "Capítulo IV — Complementos sobre limites",
      },
    ],
  },
] as const;
