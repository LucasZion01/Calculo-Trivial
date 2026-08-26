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
  "stewart_calculo_v1_8ed",
  "thomas_calculo_v1_14ed",
  "guidorizzi_calculo_v1_5ed",
  "iezzi_fme_v1_9ed",
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
