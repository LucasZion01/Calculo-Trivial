import 'package:calcquest/shared/domain/course_lesson_data.dart';

const List<CourseLessonData> limitsCourseLessons = [
  CourseLessonData(
    id: 'limites-01-intuicao',
    topicId: 'limites',
    trailTitle: 'Limites • Unidade 1',
    eyebrow: 'Aula 1 de 7 • Ideia central',
    title: 'Aproximar antes de calcular',
    description:
        'Construa a intuição de limite e aprenda a ler cada parte da notação.',
    duration: '12–15 min',
    objective:
        'explicar com suas palavras o que um limite descreve',
    symbol: 'lim',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Observe o comportamento',
        subtitle: 'O ponto de interesse orienta a aproximação.',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'A estrada e a altitude',
            content:
                'Imagine que x marca a posição de um carro e f(x) informa sua altitude. Quando o carro se aproxima do quilômetro 2, observamos para qual altitude os valores de f(x) caminham. Essa previsão é o limite.',
            emphasis:
                'O carro não precisa estacionar no quilômetro 2: o limite estuda o comportamento nas proximidades.',
          ),
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Por que engenheiros usam limites?',
            content:
                'Sensores registram medidas em instantes separados, mas frequentemente queremos estimar um comportamento instantâneo. Limites conectam aproximações sucessivas ao valor ideal usado em velocidade, deformação, fluxo e controle.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Leia a notação como uma frase',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'lim x→a f(x) = L',
            content:
                'Lemos: “o limite de f(x), quando x tende a a, é L”. A expressão x→a informa de onde nos aproximamos; f(x) é a quantidade observada; L é o valor previsto para as saídas.',
            emphasis:
                'x tende a a não significa necessariamente x = a.',
          ),
          WorkedExampleBlockData(
            title: 'Uma primeira aproximação',
            problem: 'f(x) = 2x + 1, quando x→3',
            steps: [
              'Use valores próximos de 3: 2,9; 2,99; 3,01; 3,1.',
              'Calcule as saídas: 6,8; 6,98; 7,02; 7,2.',
              'Perceba que, quanto mais x se aproxima de 3, mais f(x) se aproxima de 7.',
            ],
            result: 'Conclusão: lim x→3 (2x + 1) = 7.',
            interpretation:
                'A tabela numérica sustenta a previsão de que a saída tende a 7.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Para estudar lim x→4 f(x), qual informação é mais importante?',
      choices: [
        'Somente o valor exato de f(4).',
        'O comportamento de f(x) para valores próximos de 4.',
        'A quantidade de termos na expressão.',
      ],
      correctIndex: 1,
      explanation:
          'O limite é determinado pela aproximação ao redor do ponto; f(4) pode até estar ausente.',
    ),
    takeaways: [
      'Limite descreve uma tendência das saídas da função.',
      'O valor no ponto e o limite são conceitos relacionados, mas diferentes.',
      'A notação informa função observada, ponto de aproximação e valor previsto.',
    ],
    closing:
        'Na próxima aula, você aprenderá a comparar aproximações pela esquerda e pela direita.',
  ),
  CourseLessonData(
    id: 'limites-02-laterais',
    topicId: 'limites',
    trailTitle: 'Limites • Unidade 1',
    eyebrow: 'Aula 2 de 7 • Duas direções',
    title: 'Limites laterais, tabelas e gráficos',
    description:
        'Aprenda a investigar um ponto pelos dois lados e a reconhecer quando o limite não existe.',
    duration: '15–18 min',
    objective:
        'calcular limites laterais e comparar seus resultados',
    symbol: '→',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Chegue pela esquerda e pela direita',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Duas aproximações independentes',
            content:
                'O limite pela esquerda usa valores menores que a, indicado por x→a⁻. O limite pela direita usa valores maiores que a, indicado por x→a⁺. O limite bilateral existe somente quando os dois resultados coincidem.',
            emphasis:
                'lim x→a f(x) existe ⇔ os dois limites laterais existem e são iguais.',
          ),
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Leia o gráfico sem confundir os pontos',
            content:
                'Acompanhe a curva enquanto x se aproxima do ponto. Um círculo aberto pode indicar o valor de aproximação; um ponto fechado informa o valor assumido pela função. Eles não precisam estar na mesma altura.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Reconheça um salto',
        blocks: [
          WorkedExampleBlockData(
            title: 'Função definida por partes',
            problem: 'f(x)=1, se x<0; e f(x)=3, se x≥0',
            steps: [
              'Pela esquerda de 0, todos os valores da função são 1.',
              'Pela direita de 0, os valores da função são 3.',
              'Compare os limites laterais: 1 ≠ 3.',
            ],
            result: 'Conclusão: lim x→0 f(x) não existe.',
            interpretation:
                'O gráfico salta de uma altura para outra. O fato de f(0)=3 não corrige a diferença entre os lados.',
          ),
          ConceptBlockData(
            visual: LessonVisual.table,
            title: 'Use tabelas com critério',
            content:
                'Escolha valores progressivamente mais próximos do ponto em ambos os lados. Tabelas sugerem o comportamento, mas alguns fenômenos oscilatórios exigem uma análise algébrica ou teórica.',
            emphasis:
                'Não conclua usando apenas um valor à esquerda e um à direita.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Se lim x→2⁻ f(x)=5 e lim x→2⁺ f(x)=5, o que podemos afirmar?',
      choices: [
        'O limite bilateral vale 5.',
        'f(2) obrigatoriamente vale 5.',
        'A função não está definida em 2.',
      ],
      correctIndex: 0,
      explanation:
          'A igualdade dos limites laterais garante o limite bilateral. Ela não determina sozinha o valor de f(2).',
    ),
    takeaways: [
      'O sinal ⁻ indica aproximação pela esquerda e ⁺ pela direita.',
      'O limite bilateral exige igualdade entre os dois lados.',
      'Ponto fechado representa f(a); aproximação é lida pela curva próxima.',
      'Um salto produz limites laterais diferentes.',
    ],
    closing:
        'Agora que você sabe verificar a existência do limite, vamos aprender as propriedades que tornam o cálculo mais rápido.',
  ),
  CourseLessonData(
    id: 'limites-03-propriedades',
    topicId: 'limites',
    trailTitle: 'Limites • Unidade 1',
    eyebrow: 'Aula 3 de 7 • Regras',
    title: 'Propriedades e substituição direta',
    description:
        'Descubra quando basta substituir e como combinar limites conhecidos com segurança.',
    duration: '15–18 min',
    objective:
        'usar as propriedades algébricas e reconhecer funções contínuas',
    symbol: 'L',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Combine limites existentes',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'Soma, produto e potência',
            content:
                'Se lim f(x)=L e lim g(x)=M, então o limite da soma é L+M, o do produto é L·M e o de uma potência inteira positiva é Lⁿ. No quociente, também precisamos garantir M≠0.',
            emphasis:
                'As propriedades só podem ser usadas quando os limites envolvidos existem.',
          ),
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'Substituição direta é uma consequência',
            content:
                'Polinômios são contínuos em todos os números reais. Por isso, seu limite em a é obtido calculando o próprio valor no ponto. Funções racionais seguem a mesma regra onde o denominador não zera.',
            tone: LearningCardTone.success,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Organize expressões maiores',
        blocks: [
          WorkedExampleBlockData(
            title: 'Aplicação das propriedades',
            problem: 'lim x→2 (3x² − 4x + 5)',
            steps: [
              'A expressão é um polinômio, portanto é contínua em x=2.',
              'Substitua x por 2: 3·(2²) − 4·2 + 5.',
              'Calcule na ordem correta: 12 − 8 + 5.',
            ],
            result: 'Resultado: o limite vale 9.',
            interpretation:
                'As propriedades justificam distribuir o limite por cada termo do polinômio.',
          ),
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Denominador zero interrompe o atalho',
            content:
                'Em uma função racional, substitua primeiro. Se o denominador for diferente de zero, conclua. Se surgir 0/0, há uma indeterminação; se surgir número não nulo dividido por zero, investigue limites laterais ou comportamento infinito.',
            emphasis:
                'Nem toda divisão por zero representa a mesma situação.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual limite pode ser resolvido imediatamente por substituição?',
      choices: [
        'lim x→2 (x²−4)/(x−2)',
        'lim x→1 (x²+3x)/(x+2)',
        'lim x→0 1/x',
      ],
      correctIndex: 1,
      explanation:
          'Em x=1, o denominador x+2 vale 3. A função racional é contínua nesse ponto.',
    ),
    takeaways: [
      'Polinômios permitem substituição direta em qualquer número real.',
      'Funções racionais permitem substituição onde o denominador não zera.',
      'Soma, produto e potência preservam limites existentes.',
      '0/0 é um sinal para transformar a expressão.',
    ],
    closing:
        'A próxima aula é dedicada justamente ao caso 0/0 resolvido por fatoração.',
  ),
  CourseLessonData(
    id: 'limites-04-fatoracao',
    topicId: 'limites',
    trailTitle: 'Limites • Unidade 2',
    eyebrow: 'Aula 4 de 7 • Indeterminação',
    title: 'Fatoração revela o limite escondido',
    description:
        'Transforme expressões equivalentes para remover fatores responsáveis pela forma 0/0.',
    duration: '18–22 min',
    objective:
        'resolver limites indeterminados usando fator comum e produtos notáveis',
    symbol: '0/0',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Interprete 0/0 corretamente',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Indeterminação não é resposta',
            content:
                'Quando numerador e denominador tendem a zero, diferentes funções podem produzir limites completamente diferentes. Por isso, 0/0 apenas informa que a forma atual da expressão não revela o comportamento.',
            emphasis:
                'Nunca conclua “o limite é zero” apenas porque encontrou 0/0.',
            tone: LearningCardTone.warning,
          ),
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Procure um fator comum',
            content:
                'Produtos notáveis frequentemente criam o mesmo fator no numerador e no denominador. Depois de fatorar, simplificamos esse fator para x diferente do ponto. Isso é suficiente porque o limite observa valores próximos, não a substituição exata.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Resolva e justifique cada passo',
        blocks: [
          WorkedExampleBlockData(
            title: 'Diferença de quadrados',
            problem: 'lim x→2 (x² − 4)/(x − 2)',
            steps: [
              'Substitua x=2 e identifique a forma 0/0.',
              'Fatore x²−4 como (x−2)(x+2).',
              'Para x≠2, simplifique o fator x−2.',
              'Calcule lim x→2 (x+2) por substituição.',
            ],
            result: 'Resultado: 4.',
            interpretation:
                'A expressão simplificada descreve o mesmo comportamento em todos os pontos próximos de 2.',
          ),
          WorkedExampleBlockData(
            title: 'Trinômio fatorável',
            problem: 'lim x→3 (x² − 5x + 6)/(x − 3)',
            steps: [
              'Fatore o numerador: x²−5x+6=(x−2)(x−3).',
              'Simplifique o fator x−3 para x≠3.',
              'Avalie x−2 quando x→3.',
            ],
            result: 'Resultado: 1.',
            interpretation:
                'Reconhecer raízes do trinômio transforma uma fração indeterminada em uma função linear.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Não cancele termos',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Cancelamento exige fatores',
            content:
                'Só podemos cancelar elementos que multiplicam o numerador e o denominador inteiros. Partes separadas por soma ou subtração não são fatores.',
            emphasis:
                'Fatore primeiro; simplifique depois.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Depois de fatorar (x²−9)/(x−3), qual expressão descreve o comportamento para x≠3?',
      choices: ['x−3', 'x+3', '1'],
      correctIndex: 1,
      explanation:
          'x²−9=(x−3)(x+3). O fator x−3 é simplificado, restando x+3.',
    ),
    takeaways: [
      '0/0 indica indeterminação, não um resultado.',
      'Diferença de quadrados: a²−b²=(a−b)(a+b).',
      'Trinômios podem revelar o fator que zera o denominador.',
      'Cancelamento só ocorre entre fatores.',
    ],
    closing:
        'Nem toda indeterminação é polinomial. Na próxima aula, usaremos conjugados para trabalhar com raízes.',
  ),
  CourseLessonData(
    id: 'limites-05-racionalizacao',
    topicId: 'limites',
    trailTitle: 'Limites • Unidade 2',
    eyebrow: 'Aula 5 de 7 • Raízes',
    title: 'Racionalização com expressões conjugadas',
    description:
        'Elimine indeterminações envolvendo raízes sem alterar o valor da expressão.',
    duration: '18–22 min',
    objective:
        'identificar conjugados e racionalizar numeradores ou denominadores',
    symbol: '√',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Use a diferença de quadrados',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'O conjugado troca o sinal',
            content:
                'O conjugado de √A−√B é √A+√B. Ao multiplicá-los, obtemos (√A−√B)(√A+√B)=A−B, eliminando as raízes dessa parte da expressão.',
            emphasis:
                'Multiplique numerador e denominador pelo mesmo conjugado para preservar a equivalência.',
          ),
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Racionalize o lado que causa a indeterminação',
            content:
                'Às vezes a raiz está no numerador; em outros casos, no denominador. Identifique onde a subtração de radicais produz zero e aplique o conjugado correspondente.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Acompanhe a simplificação',
        blocks: [
          WorkedExampleBlockData(
            title: 'Raiz no numerador',
            problem: 'lim x→0 (√(x+4) − 2)/x',
            steps: [
              'A substituição gera (2−2)/0=0/0.',
              'Multiplique por (√(x+4)+2)/(√(x+4)+2).',
              'No numerador, use a diferença de quadrados: (x+4)−4=x.',
              'Simplifique o fator x e avalie 1/(√(x+4)+2) em x=0.',
            ],
            result: 'Resultado: 1/4.',
            interpretation:
                'O conjugado revelou uma expressão equivalente e contínua perto de zero.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o conjugado de √(x+1) − 3?',
      choices: ['√(x+1) + 3', '−√(x+1) + 3', '√(x−1) + 3'],
      correctIndex: 0,
      explanation:
          'Mantemos os termos e trocamos apenas o sinal entre eles.',
    ),
    takeaways: [
      'Conjugados transformam produtos em diferenças de quadrados.',
      'Multiplique a fração por uma razão igual a 1.',
      'Simplifique somente depois de desenvolver o produto.',
      'Ao final, volte à substituição direta.',
    ],
    closing:
        'A última técnica principal examina o comportamento quando x cresce sem limite.',
  ),
  CourseLessonData(
    id: 'limites-06-infinito',
    topicId: 'limites',
    trailTitle: 'Limites • Unidade 3',
    eyebrow: 'Aula 6 de 7 • Longo prazo',
    title: 'Limites no infinito e assíntotas',
    description:
        'Compare termos dominantes para prever o comportamento de funções racionais.',
    duration: '18–22 min',
    objective:
        'calcular limites no infinito e interpretar assíntotas horizontais',
    symbol: '∞',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Identifique quem domina',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.infinity,
            title: 'Termos de maior grau comandam o crescimento',
            content:
                'Quando |x| fica muito grande, x² domina x e constantes; x³ domina x². Em funções racionais, compare os maiores graus do numerador e do denominador.',
            emphasis:
                'Dividir todos os termos pela maior potência do denominador torna essa comparação explícita.',
          ),
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Três casos fundamentais',
            content:
                'Se o grau do numerador é menor, o limite é 0. Se os graus são iguais, o limite é a razão dos coeficientes líderes. Se o numerador possui grau maior, a função não tende a um valor finito.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Calcule sem usar números gigantes',
        blocks: [
          WorkedExampleBlockData(
            title: 'Graus iguais',
            problem: 'lim x→∞ (3x² − x + 4)/(2x² + 5)',
            steps: [
              'O maior grau do denominador é 2. Divida todos os termos por x².',
              'Obtenha (3 − 1/x + 4/x²)/(2 + 5/x²).',
              'Quando x→∞, 1/x e 1/x² tendem a zero.',
              'Resta a razão 3/2.',
            ],
            result: 'Resultado: 3/2.',
            interpretation:
                'A reta y=3/2 é uma assíntota horizontal: o gráfico se aproxima dela no longo prazo.',
          ),
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Interpretação de regime permanente',
            content:
                'Em modelos de controle e circuitos, o limite no infinito pode representar o valor de estabilização de uma resposta ao longo do tempo. A assíntota descreve esse regime permanente.',
            tone: LearningCardTone.success,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é lim x→∞ (5x+1)/(x²+2)?',
      choices: ['0', '5', '∞'],
      correctIndex: 0,
      explanation:
          'O denominador possui grau 2 e cresce mais rapidamente que o numerador de grau 1.',
    ),
    takeaways: [
      'Compare os graus antes de realizar operações.',
      'Grau menor no numerador produz limite zero.',
      'Graus iguais produzem a razão dos coeficientes líderes.',
      'Limites finitos no infinito indicam assíntotas horizontais.',
    ],
    closing:
        'A aula final reúne todas as estratégias em um único roteiro de decisão.',
  ),
  CourseLessonData(
    id: 'limites-07-sintese',
    topicId: 'limites',
    trailTitle: 'Limites • Unidade 3',
    eyebrow: 'Aula 7 de 7 • Síntese',
    title: 'Como escolher a técnica certa',
    description:
        'Organize as ideias do módulo em um método de análise confiável.',
    duration: '15–18 min',
    objective:
        'diagnosticar um limite e justificar a técnica escolhida',
    symbol: '?',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Siga uma sequência de diagnóstico',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Um roteiro em cinco perguntas',
            content:
                '1) É limite lateral ou bilateral? 2) A substituição direta funciona? 3) Surgiu 0/0? 4) Há polinômios para fatorar ou raízes para racionalizar? 5) x tende ao infinito, exigindo comparação de graus?',
            emphasis:
                'Escolha a técnica pela estrutura encontrada, não por tentativa aleatória.',
          ),
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Revise o significado do resultado',
            content:
                'Depois do cálculo, pergunte se o valor combina com a tabela, o gráfico ou o crescimento esperado. Um resultado algébrico sem interpretação é mais difícil de verificar.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Combine técnicas quando necessário',
        blocks: [
          WorkedExampleBlockData(
            title: 'Diagnóstico completo',
            problem: 'lim x→1 (x²−1)/(√(x+3)−2)',
            steps: [
              'A substituição gera 0/0; há fatoração no numerador e radical no denominador.',
              'Fatore x²−1=(x−1)(x+1).',
              'Racionalize o denominador usando √(x+3)+2.',
              'A diferença de quadrados transforma o denominador em x−1.',
              'Simplifique x−1 e substitua x=1 na expressão restante.',
            ],
            result: 'Resultado: (1+1)(√4+2)=2·4=8.',
            interpretation:
                'O problema exige reconhecer duas estruturas e combiná-las na ordem correta.',
          ),
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Limite como ferramenta de modelagem',
            content:
                'Em Engenharia, limites avaliam estabilidade, tolerâncias, aproximações numéricas e comportamento de modelos perto de pontos críticos. A técnica algébrica é o meio; a previsão do fenômeno é o objetivo.',
            tone: LearningCardTone.success,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Uma substituição produz 0/0 e o numerador é x²−a². Qual é a primeira transformação mais promissora?',
      choices: [
        'Fatorar como (x−a)(x+a).',
        'Declarar que o limite é zero.',
        'Comparar apenas os graus.',
      ],
      correctIndex: 0,
      explanation:
          'A diferença de quadrados pode revelar o fator responsável pela indeterminação.',
    ),
    takeaways: [
      'Comece sempre analisando tipo de aproximação e substituição direta.',
      'Use fatoração para estruturas polinomiais e conjugados para radicais.',
      'No infinito, compare os termos dominantes.',
      'Interprete o resultado no contexto algébrico, gráfico ou físico.',
    ],
    closing:
        'Você concluiu a teoria essencial de Limites. Agora a prática consolidará o roteiro de decisão.',
  ),
];
