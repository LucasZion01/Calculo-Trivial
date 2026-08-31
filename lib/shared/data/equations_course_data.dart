import 'package:calcquest/shared/domain/course_lesson_data.dart';

const List<CourseLessonData> equationsCourseLessons = [
  CourseLessonData(
    id: 'equations-01-equilibrio',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Fundamentos',
    title: 'Equações e equilíbrio',
    description: 'igualdade, incógnita e equivalência',
    duration: '≈ 5 min',
    objective:
        'compreender uma equação como uma igualdade e preservar seu equilíbrio durante as transformações',
    symbol: '=',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Entenda a ideia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'Pense em uma balança',
            content:
                'Uma equação afirma que duas expressões possuem o mesmo valor. '
                'Resolver a equação significa descobrir quais valores da incógnita '
                'fazem essa igualdade ser verdadeira.',
            emphasis:
                'Tudo o que você fizer de um lado da equação deve preservar a igualdade.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Uma operação de cada vez',
            problem: 'Resolva x + 7 = 12.',
            steps: [
              'Queremos deixar x sozinho.',
              'Subtraia 7 dos dois lados: x + 7 − 7 = 12 − 7.',
              'Simplifique: x = 5.',
              'Verifique: 5 + 7 = 12.',
            ],
            result: 'A solução é x = 5.',
            interpretation:
                'Subtrair 7 dos dois lados produziu uma equação equivalente.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Se x − 4 = 9, qual operação isola x?',
      choices: [
        'Subtrair 4 dos dois lados',
        'Somar 4 aos dois lados',
        'Multiplicar os dois lados por 4',
      ],
      correctIndex: 1,
      explanation:
          'Somando 4 aos dois membros, obtemos x = 13 sem alterar a igualdade.',
    ),
    takeaways: [
      'Equação representa uma igualdade.',
      'A incógnita é o valor que queremos determinar.',
      'Operações equivalentes preservam a igualdade.',
      'A solução deve tornar a equação original verdadeira.',
    ],
    closing:
        'Resolver uma equação é preservar o equilíbrio até que a incógnita fique isolada.',
  ),
  CourseLessonData(
    id: 'equations-02-primeiro-grau',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Equações lineares',
    title: 'Equações do primeiro grau',
    description: 'operações inversas e isolamento',
    duration: '≈ 5 min',
    objective:
        'resolver equações lineares usando operações inversas de forma organizada',
    symbol: 'ax+b',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Construa uma estratégia',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Desfaça as operações na ordem certa',
            content:
                'Em uma equação como 3x + 4 = 19, a incógnita foi primeiro '
                'multiplicada por 3 e depois recebeu 4. Para isolá-la, fazemos '
                'o caminho inverso: retiramos 4 e depois dividimos por 3.',
            emphasis:
                'Não existe “passar para o outro lado”. Existem operações inversas aplicadas aos dois membros.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Resolva passo a passo',
        blocks: [
          WorkedExampleBlockData(
            title: 'Duas operações',
            problem: 'Resolva 5x − 7 = 18.',
            steps: [
              'Some 7 aos dois lados: 5x = 25.',
              'Divida os dois lados por 5: x = 5.',
              'Substitua na equação original: 5·5 − 7 = 18.',
            ],
            result: 'x = 5.',
            interpretation:
                'A verificação confirma que o valor encontrado satisfaz a equação.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é a solução de 4x + 3 = 19?',
      choices: ['x = 4', 'x = 5', 'x = 16'],
      correctIndex: 0,
      explanation: 'Subtraindo 3, temos 4x = 16. Dividindo por 4, x = 4.',
    ),
    takeaways: [
      'Use operações inversas.',
      'Elimine primeiro soma ou subtração.',
      'Depois elimine multiplicação ou divisão.',
      'Sempre que possível, verifique a resposta.',
    ],
    closing:
        'Organização é mais importante que velocidade ao resolver equações.',
  ),
  CourseLessonData(
    id: 'equations-03-parenteses-fracoes',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Equações lineares',
    title: 'Parênteses e frações',
    description: 'distributiva e denominadores',
    duration: '≈ 5 min',
    objective:
        'resolver equações com parênteses e frações preparando a expressão antes de isolar a incógnita',
    symbol: 'x/3',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Prepare antes de isolar',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Simplifique a estrutura',
            content:
                'Quando aparecem parênteses ou frações, simplifique a expressão '
                'antes de tentar deixar x sozinho. Use distributiva, reduza termos '
                'semelhantes ou elimine denominadores.',
            emphasis:
                'Uma equação complicada pode se transformar em uma equação linear simples.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Parênteses nos dois membros',
            problem: 'Resolva 3(x + 1) = 2x + 7.',
            steps: [
              'Aplique a distributiva: 3x + 3 = 2x + 7.',
              'Subtraia 2x dos dois lados: x + 3 = 7.',
              'Subtraia 3 dos dois lados: x = 4.',
            ],
            result: 'x = 4.',
            interpretation: 'A distributiva revelou uma equação linear comum.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Se x/5 + 2 = 6, qual é o valor de x?',
      choices: ['4', '8', '20'],
      correctIndex: 2,
      explanation:
          'Subtraindo 2, x/5 = 4. Multiplicando por 5, obtemos x = 20.',
    ),
    takeaways: [
      'Resolva parênteses com distributiva.',
      'Reduza termos semelhantes.',
      'Elimine denominadores quando isso facilitar.',
      'Preserve a equivalência em cada transformação.',
    ],
    closing:
        'Antes de atacar a incógnita, deixe a equação trabalhar a seu favor.',
  ),
  CourseLessonData(
    id: 'equations-04-casos-especiais',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Interpretação',
    title: 'Uma, nenhuma ou infinitas soluções',
    description: 'identidades e contradições',
    duration: '≈ 5 min',
    objective:
        'distinguir equações com solução única, nenhuma solução ou infinitas soluções',
    symbol: '∅',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Nem toda equação termina em x = número',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Observe o que sobra',
            content:
                'Durante a simplificação, a incógnita pode desaparecer. '
                'Uma afirmação falsa representa contradição; uma afirmação '
                'sempre verdadeira representa identidade.',
            emphasis:
                '2 = 5 significa nenhuma solução. 2 = 2 significa infinitas soluções.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Interprete o resultado',
        blocks: [
          WorkedExampleBlockData(
            title: 'Contradição',
            problem: 'Resolva 2(x + 1) = 2x + 5.',
            steps: [
              'Distribua: 2x + 2 = 2x + 5.',
              'Subtraia 2x dos dois lados: 2 = 5.',
              'A afirmação obtida é falsa.',
            ],
            result: 'A equação não possui solução.',
            interpretation:
                'Não existe valor de x capaz de tornar 2 = 5 verdadeiro.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'O que significa terminar uma equação com 7 = 7?',
      choices: ['Nenhuma solução', 'Apenas x = 7', 'Infinitas soluções'],
      correctIndex: 2,
      explanation:
          'Como a igualdade é sempre verdadeira, todos os valores permitidos satisfazem a equação.',
    ),
    takeaways: [
      'Uma solução produz x = número.',
      'Contradição significa nenhuma solução.',
      'Identidade significa infinitas soluções.',
      'O conjunto solução precisa ser interpretado.',
    ],
    closing:
        'Resolver também significa reconhecer quando não existe uma única resposta.',
  ),
  CourseLessonData(
    id: 'equations-05-sistemas-lineares',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Duas incógnitas',
    title: 'Sistemas de equações',
    description: 'substituição e eliminação',
    duration: '≈ 5 min',
    objective:
        'resolver sistemas lineares simples e interpretar a solução como um par ordenado',
    symbol: '{x,y}',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Duas condições ao mesmo tempo',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'A solução precisa satisfazer as duas equações',
            content:
                'Um sistema reúne duas ou mais equações. Em um sistema com x e y, '
                'buscamos um par de valores que torne todas as equações verdadeiras simultaneamente.',
            emphasis: 'Resolver apenas uma das equações não resolve o sistema.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Elimine uma incógnita',
        blocks: [
          WorkedExampleBlockData(
            title: 'Método da adição',
            problem: 'x + y = 7\nx − y = 1',
            steps: [
              'Some as duas equações.',
              'y e −y se cancelam: 2x = 8.',
              'Divida por 2: x = 4.',
              'Substitua em x + y = 7: y = 3.',
            ],
            result: 'A solução é (4, 3).',
            interpretation:
                'O par x = 4 e y = 3 satisfaz simultaneamente as duas equações.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Se x + y = 10 e x − y = 2, quanto vale x?',
      choices: ['4', '6', '8'],
      correctIndex: 1,
      explanation: 'Somando as equações, obtemos 2x = 12. Portanto, x = 6.',
    ),
    takeaways: [
      'Um sistema impõe várias condições simultâneas.',
      'Substituição troca uma incógnita por expressão equivalente.',
      'Eliminação cancela uma incógnita.',
      'A resposta pode ser representada por um par ordenado.',
    ],
    closing:
        'Sistemas transformam várias informações em uma solução compatível.',
  ),
  CourseLessonData(
    id: 'equations-06-quadraticas',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Segundo grau',
    title: 'Equações quadráticas',
    description: 'raízes, fatoração e produto nulo',
    duration: '≈ 5 min',
    objective:
        'resolver equações quadráticas simples usando fatoração e produto nulo',
    symbol: 'x²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Agora podem existir duas raízes',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'O grau muda o comportamento',
            content:
                'Uma equação quadrática possui termo com x². Ela pode possuir '
                'duas raízes reais, uma raiz repetida ou nenhuma raiz real.',
            emphasis: 'Se AB = 0, então A = 0 ou B = 0.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Transforme em produto',
        blocks: [
          WorkedExampleBlockData(
            title: 'Fatoração e produto nulo',
            problem: 'Resolva x² − 5x + 6 = 0.',
            steps: [
              'Fatore: (x − 2)(x − 3) = 0.',
              'Então x − 2 = 0 ou x − 3 = 0.',
              'Resolva cada equação.',
            ],
            result: 'x = 2 ou x = 3.',
            interpretation: 'Cada fator pode tornar o produto igual a zero.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Quais são as soluções de x² − 9 = 0?',
      choices: ['Somente x = 3', 'x = −3 ou x = 3', 'x = 9'],
      correctIndex: 1,
      explanation: 'x² − 9 = (x − 3)(x + 3), então x = 3 ou x = −3.',
    ),
    takeaways: [
      'Equações quadráticas possuem termo x².',
      'Fatoração pode revelar as raízes.',
      'Produto nulo permite separar fatores.',
      'Uma equação quadrática pode ter mais de uma solução.',
    ],
    closing:
        'A fatoração conecta diretamente a Álgebra à resolução de equações quadráticas.',
  ),
  CourseLessonData(
    id: 'equations-07-inequacoes',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Desigualdades',
    title: 'Inequações',
    description: 'intervalos e inversão do sinal',
    duration: '≈ 5 min',
    objective:
        'resolver inequações lineares e interpretar a solução como conjunto de valores',
    symbol: '≤',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'A resposta agora é uma região',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Não buscamos apenas um número',
            content:
                'Uma inequação compara valores usando <, >, ≤ ou ≥. '
                'A solução costuma ser um conjunto de números.',
            emphasis: 'x > 4 representa todos os números reais maiores que 4.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'O cuidado mais importante',
        blocks: [
          WorkedExampleBlockData(
            title: 'Divisão por número negativo',
            problem: 'Resolva −3x > 12.',
            steps: [
              'Divida os dois lados por −3.',
              'Como a divisão é por número negativo, inverta > para <.',
              'Obtenha x < −4.',
            ],
            result: 'A solução é x < −4.',
            interpretation:
                'Sem inverter o sinal, o conjunto solução seria incorreto.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é a solução de −2x ≤ 8?',
      choices: ['x ≤ −4', 'x ≥ −4', 'x ≥ 4'],
      correctIndex: 1,
      explanation: 'Dividindo por −2, invertemos ≤ para ≥. Portanto, x ≥ −4.',
    ),
    takeaways: [
      'Inequações descrevem conjuntos de valores.',
      'Soma e subtração preservam a desigualdade.',
      'Multiplicar ou dividir por negativo inverte o sinal.',
      'A solução pode ser representada na reta numérica.',
    ],
    closing:
        'Nas inequações, preservar a ordem é tão importante quanto isolar a incógnita.',
  ),
  CourseLessonData(
    id: 'equations-08-modulo-revisao',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Consolidação',
    title: 'Módulo e estratégia final',
    description: 'distância, duas possibilidades e revisão',
    duration: '≈ 5 min',
    objective:
        'interpretar equações modulares simples e escolher estratégias adequadas para diferentes problemas',
    symbol: '|x|',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Módulo representa distância',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Distância nunca é negativa',
            content:
                'O valor absoluto |x| representa a distância entre x e zero. '
                'Por isso, |x| = 5 possui duas soluções: 5 e −5.',
            emphasis: '|x| = a, com a > 0, normalmente produz x = a ou x = −a.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Escolha a ferramenta',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Antes de calcular, classifique',
            content:
                'Observe se existem parênteses, frações, x², duas incógnitas, '
                'desigualdade ou valor absoluto. A estrutura indica a estratégia.',
            emphasis:
                'Reconhecer o tipo do problema reduz erros e evita fórmulas desnecessárias.',
          ),
          WorkedExampleBlockData(
            title: 'Equação modular',
            problem: 'Resolva |x| = 7.',
            steps: [
              'Interprete |x| como distância até zero.',
              'Existem dois pontos a sete unidades do zero.',
              'Esses pontos são 7 e −7.',
            ],
            result: 'x = −7 ou x = 7.',
            interpretation: 'As duas soluções possuem o mesmo valor absoluto.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Quais valores resolvem |x| = 3?',
      choices: ['Somente x = 3', 'x = −3 ou x = 3', 'x = 0 ou x = 3'],
      correctIndex: 1,
      explanation:
          'Tanto −3 quanto 3 estão a três unidades de distância do zero.',
    ),
    takeaways: [
      'Valor absoluto representa distância.',
      'Equações modulares podem produzir duas soluções.',
      'A estrutura indica a estratégia adequada.',
      'Verificar a solução continua sendo fundamental.',
    ],
    closing:
        'Você agora possui uma base sólida para enfrentar diferentes equações e inequações.',
  ),
];
