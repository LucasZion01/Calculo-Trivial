import 'package:calcquest/shared/domain/course_lesson_data.dart';

const List<CourseLessonData> algebraCourseLessons = [
  CourseLessonData(
    id: 'algebra-01-linguagem',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'A linguagem da Álgebra',
    description: 'variáveis, constantes e expressões',
    duration: '≈ 5 min',
    objective: 'interpretar letras como números variáveis e reconhecer a estrutura de uma expressão algébrica',
    symbol: 'x',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'A variável guarda uma possibilidade',
            content: 'Quando escrevemos 3x + 2, a letra x representa um número que pode variar. A expressão não pede uma resposta única; ela descreve uma regra que produz valores diferentes conforme x muda.',
            emphasis: 'Em Cálculo, quase tudo começa assim: uma quantidade varia e outra responde a essa variação.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Valor numérico sem mistério',
            problem: 'Calcule 2x² − 3x + 1 para x = 4.',
            steps: [
              'Substitua x por 4: 2(4)² − 3(4) + 1.',
              'Resolva a potência antes da multiplicação: 2·16 − 12 + 1.',
              'Calcule da esquerda para a direita: 32 − 12 + 1 = 21.',
            ],
            result: 'O valor numérico é 21.',
            interpretation: 'A expressão é a mesma, mas o valor aparece quando escolhemos uma entrada.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Na expressão 5a² − 7, qual parte varia?',
      choices: [
        'O número 5',
        'A letra a',
        'O número −7',
      ],
      correctIndex: 1,
      explanation: 'A letra a é a variável. Os números 5 e −7 são constantes.',
    ),
    takeaways: [
      'Variável representa um número que pode mudar.',
      'Coeficientes multiplicam partes literais.',
      'Substituir um valor na variável produz um valor numérico.',
      'A ordem das operações evita leituras erradas.',
    ],
    closing: 'Entender a linguagem algébrica transforma símbolos em instruções claras.',
  ),
  CourseLessonData(
    id: 'algebra-02-termos-semelhantes',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Termos semelhantes',
    description: 'coeficientes, constantes e redução',
    duration: '≈ 5 min',
    objective: 'simplificar somas e subtrações combinando apenas termos com a mesma parte literal',
    symbol: '3x',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Só combina quem é da mesma família',
            content: 'Termos semelhantes possuem exatamente a mesma parte literal, com as mesmas variáveis e os mesmos expoentes. Por isso 4x e −7x podem ser combinados, mas 4x e 4x² não podem.',
            emphasis: 'A regra é simples: some os coeficientes e preserve a parte literal.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Agrupando com cuidado',
            problem: 'Simplifique 6x² − 3x + 5x² + 8x − 4.',
            steps: [
              'Agrupe os termos x²: 6x² + 5x² = 11x².',
              'Agrupe os termos x: −3x + 8x = 5x.',
              'A constante −4 permanece como está.',
            ],
            result: 'A forma simplificada é 11x² + 5x − 4.',
            interpretation: 'Nenhum termo mudou de natureza; apenas juntamos partes compatíveis.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual expressão é equivalente a 2x + 5x − 3?',
      choices: [
        '7x − 3',
        '10x − 3',
        '4x',
      ],
      correctIndex: 0,
      explanation: 'Somamos apenas 2x e 5x, obtendo 7x. A constante −3 permanece.',
    ),
    takeaways: [
      'Termos semelhantes têm a mesma parte literal.',
      'Expoentes diferentes impedem a combinação.',
      'Constantes combinam apenas com constantes.',
      'Escrever por grupos deixa a conta mais segura.',
    ],
    closing: 'Dominar termos semelhantes deixa equações, funções e derivadas muito mais leves.',
  ),
  CourseLessonData(
    id: 'algebra-03-distributiva',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Distributiva e sinais',
    description: 'parênteses, produtos e sinais negativos',
    duration: '≈ 5 min',
    objective: 'aplicar a propriedade distributiva sem perder sinais dentro dos parênteses',
    symbol: 'a(b+c)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Distribuir é atravessar o parêntese',
            content: 'Na forma a(b + c), o fator a multiplica cada termo interno. Assim, a(b + c) = ab + ac. Se houver subtração, o sinal do termo também participa da multiplicação.',
            emphasis: 'O erro clássico é multiplicar apenas o primeiro termo e esquecer o segundo.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Parêntese com sinal negativo',
            problem: 'Simplifique −2(x − 5) + 3x.',
            steps: [
              'Distribua −2: −2x + 10.',
              'Some o termo restante: −2x + 10 + 3x.',
              'Combine termos semelhantes: x + 10.',
            ],
            result: 'A expressão simplificada é x + 10.',
            interpretation: 'O termo −5 virou +10 porque negativo vezes negativo é positivo.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é a forma de 3(x − 4)?',
      choices: [
        '3x − 4',
        '3x − 12',
        'x − 12',
      ],
      correctIndex: 1,
      explanation: 'O 3 multiplica x e também −4, então 3(x − 4) = 3x − 12.',
    ),
    takeaways: [
      'Distributiva conecta multiplicação e soma.',
      'Todos os termos internos devem ser multiplicados.',
      'Sinais negativos precisam ser carregados com atenção.',
      'Depois da distributiva, reduza termos semelhantes.',
    ],
    closing: 'A distributiva é uma das ferramentas mais usadas para preparar expressões antes do Cálculo.',
  ),
  CourseLessonData(
    id: 'algebra-04-potencias',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Potências e expoentes',
    description: 'regras de multiplicação e divisão',
    duration: '≈ 5 min',
    objective: 'usar propriedades de potências para simplificar monômios e expressões algébricas',
    symbol: 'x²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'Mesma base, regra certa',
            content: 'Em produtos de potências de mesma base, somamos expoentes: x²·x³ = x⁵. Em quocientes, subtraímos expoentes, desde que a base não seja zero: x⁵/x² = x³.',
            emphasis: 'Não some bases. O que muda é o expoente.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Coeficiente e variável',
            problem: 'Simplifique (−2x³)².',
            steps: [
              'Eleve o coeficiente: (−2)² = 4.',
              'Multiplique o expoente da variável: (x³)² = x⁶.',
              'Junte as partes: 4x⁶.',
            ],
            result: 'A forma simplificada é 4x⁶.',
            interpretation: 'O quadrado torna o coeficiente positivo e dobra o expoente da variável.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o resultado de x⁴·x²?',
      choices: [
        'x⁶',
        'x⁸',
        '2x⁶',
      ],
      correctIndex: 0,
      explanation: 'As bases são iguais, então somamos os expoentes: 4 + 2 = 6.',
    ),
    takeaways: [
      'Produto de mesma base soma expoentes.',
      'Quociente de mesma base subtrai expoentes.',
      'Potência de potência multiplica expoentes.',
      'Coeficientes também seguem as regras de sinais.',
    ],
    closing: 'Potências bem dominadas simplificam polinômios, funções e limites.',
  ),
  CourseLessonData(
    id: 'algebra-05-produtos-notaveis',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Produtos notáveis',
    description: 'padrões que aceleram cálculos',
    duration: '≈ 5 min',
    objective: 'reconhecer quadrados, diferença de quadrados e produtos binomiais comuns',
    symbol: '(a+b)²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'Produto notável é distributiva memorizada com sentido',
            content: 'Produtos notáveis não são truques soltos. Eles nascem da distributiva e aparecem tantas vezes que vale reconhecer o padrão rapidamente.',
            emphasis: '(a + b)² = a² + 2ab + b², não apenas a² + b².',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Expandindo com padrão',
            problem: 'Desenvolva (x − 5)².',
            steps: [
              'Use (a − b)² = a² − 2ab + b².',
              'Aqui, a = x e b = 5.',
              'Substitua: x² − 2·x·5 + 25.',
            ],
            result: 'O resultado é x² − 10x + 25.',
            interpretation: 'O termo do meio aparece porque o binômio foi multiplicado por ele mesmo.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o desenvolvimento de (x + 3)²?',
      choices: [
        'x² + 9',
        'x² + 6x + 9',
        'x² + 3x + 9',
      ],
      correctIndex: 1,
      explanation: 'O termo do meio é 2·x·3 = 6x. Por isso, (x + 3)² = x² + 6x + 9.',
    ),
    takeaways: [
      'Produtos notáveis vêm da distributiva.',
      'Quadrado da soma possui termo do meio.',
      'Diferença de quadrados fatora como (a − b)(a + b).',
      'Reconhecer padrões acelera simplificações.',
    ],
    closing: 'Produtos notáveis são atalhos seguros quando você sabe de onde eles vieram.',
  ),
  CourseLessonData(
    id: 'algebra-06-fatoracao',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Fatoração',
    description: 'colocar expressões em forma de produto',
    duration: '≈ 5 min',
    objective: 'fatorar expressões por fator comum, agrupamento e padrões notáveis',
    symbol: '(x−a)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Da soma para o produto',
            content: 'Fatorar significa escrever uma expressão como multiplicação de fatores. Isso revela raízes, cancela frações algébricas e resolve limites com indeterminação.',
            emphasis: 'Em Cálculo, fatorar muitas vezes transforma um problema travado em uma conta simples.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Fator comum em evidência',
            problem: 'Fatore 8x² − 12x.',
            steps: [
              'Encontre o maior fator comum: 4x.',
              'Divida cada termo por 4x: 8x²/(4x) = 2x e −12x/(4x) = −3.',
              'Escreva o produto: 4x(2x − 3).',
            ],
            result: 'A fatoração é 4x(2x − 3).',
            interpretation: 'Se distribuir 4x de volta, recuperamos a expressão original.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é a fatoração de x² − 16?',
      choices: [
        '(x − 4)(x + 4)',
        '(x − 8)(x + 8)',
        '(x − 4)²',
      ],
      correctIndex: 0,
      explanation: 'É uma diferença de quadrados: x² − 4² = (x − 4)(x + 4).',
    ),
    takeaways: [
      'Fatorar reescreve somas como produtos.',
      'Fator comum é o primeiro padrão a procurar.',
      'Diferença de quadrados é muito frequente.',
      'Sempre confira distribuindo de volta.',
    ],
    closing: 'A fatoração é uma ponte direta entre Álgebra, equações, funções e limites.',
  ),
  CourseLessonData(
    id: 'algebra-07-fracoes-algebricas',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Frações algébricas',
    description: 'restrições, simplificação e denominadores',
    duration: '≈ 5 min',
    objective: 'simplificar frações algébricas preservando restrições de domínio',
    symbol: 'x/y',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Nem todo cancelamento é permitido',
            content: 'Só podemos cancelar fatores multiplicativos comuns. Não se cancela termo dentro de soma como se fosse fator. Além disso, denominadores nunca podem ser zero.',
            emphasis: 'Em (x + 2)/x, o x não cancela com parte do numerador, porque x + 2 é uma soma.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Cancelamento correto',
            problem: 'Simplifique (x² − 9)/(x − 3), com x ≠ 3.',
            steps: [
              'Fatore o numerador: x² − 9 = (x − 3)(x + 3).',
              'Reescreva a fração: [(x − 3)(x + 3)]/(x − 3).',
              'Cancele o fator comum x − 3, mantendo a restrição x ≠ 3.',
            ],
            result: 'A forma simplificada é x + 3, com x ≠ 3.',
            interpretation: 'A expressão simplificada parece livre, mas a restrição original continua valendo.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Em qual expressão o cancelamento de x é correto?',
      choices: [
        '(x + 5)/x',
        '(3x)/(x)',
        '(x − 2)/x',
      ],
      correctIndex: 1,
      explanation: 'Em 3x/x, o x é fator comum no numerador e no denominador. Nas outras, x aparece dentro de soma ou diferença.',
    ),
    takeaways: [
      'Denominador zero é proibido.',
      'Cancele apenas fatores, não parcelas.',
      'Fatorar antes de cancelar evita erro.',
      'Restrições originais continuam importantes.',
    ],
    closing: 'Frações algébricas explicam muitos detalhes de domínio, continuidade e limites.',
  ),
  CourseLessonData(
    id: 'algebra-08-sintese',
    topicId: 'algebra-fundamental',
    trailTitle: 'Álgebra Fundamental',
    eyebrow: 'Fundamentos',
    title: 'Síntese algébrica',
    description: 'escolher a ferramenta certa',
    duration: '≈ 5 min',
    objective: 'decidir quando simplificar, expandir, fatorar ou substituir valores',
    symbol: '✓',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Não existe uma forma sempre melhor',
            content: 'Expandir ajuda a combinar termos. Fatorar ajuda a enxergar produtos, raízes e cancelamentos. Substituir valores ajuda a conferir resultados e interpretar expressões.',
            emphasis: 'O bom aluno de Cálculo não decora só contas; ele escolhe a forma que revela a ideia.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Do caos à forma útil',
            problem: 'Simplifique 2(x + 1) + (x − 3)(x + 3).',
            steps: [
              'Distribua o primeiro termo: 2x + 2.',
              'Use diferença de quadrados: (x − 3)(x + 3) = x² − 9.',
              'Combine: x² + 2x − 7.',
            ],
            result: 'A expressão simplificada é x² + 2x − 7.',
            interpretation: 'Usamos distributiva e produto notável na mesma expressão.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Para simplificar (x² − 25)/(x − 5), qual ferramenta vem primeiro?',
      choices: [
        'Fatorar x² − 25',
        'Substituir x = 5',
        'Somar 25 ao denominador',
      ],
      correctIndex: 0,
      explanation: 'A diferença de quadrados permite escrever x² − 25 como (x − 5)(x + 5), revelando o fator comum.',
    ),
    takeaways: [
      'Expandir, fatorar e substituir têm objetivos diferentes.',
      'A forma fatorada revela cancelamentos e raízes.',
      'A forma expandida facilita combinação de termos.',
      'Conferir o caminho reduz erros invisíveis.',
    ],
    closing: 'Com essa caixa de ferramentas pronta, as próximas aulas deixam de parecer mágica e começam a parecer estratégia.',
  )
];
