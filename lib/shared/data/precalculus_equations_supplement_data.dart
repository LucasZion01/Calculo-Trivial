import 'package:flutter/widgets.dart';

import 'package:calcquest/shared/domain/course_lesson_data.dart';

List<CourseLessonData> localizedPrecalculusEquationsSupplementLessons(
  Locale locale,
) {
  if (locale.languageCode == 'en') {
    return _englishLessons;
  }
  return precalculusEquationsSupplementLessons;
}

const List<CourseLessonData> precalculusEquationsSupplementLessons = [
  CourseLessonData(
    id: 'equations-09-radicais',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Pré-Cálculo',
    title: 'Equações com radicais',
    description: 'isolamento, potenciação e verificação',
    duration: '≈ 15 min',
    objective:
        'resolver equações simples com radicais reconhecendo quando a potenciação pode introduzir soluções estranhas',
    symbol: '√x',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Isole antes de elevar',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'A raiz deve ficar sozinha',
            content:
                'Em uma equação radical, primeiro isolamos a expressão que contém a raiz. Depois elevamos ambos os lados a uma potência adequada. A nova equação pode ter soluções que não pertenciam à original, por isso a verificação final é obrigatória.',
            emphasis:
                'Potenciar preserva toda solução original, mas pode criar candidatas extras.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Resolver e verificar',
            problem: 'Resolva √(x + 1) = x − 1.',
            steps: [
              'Como a raiz é não negativa, precisamos ter x − 1 ≥ 0, então x ≥ 1.',
              'Eleve os dois lados ao quadrado: x + 1 = (x − 1)².',
              'Expanda: x + 1 = x² − 2x + 1.',
              'Reorganize: x² − 3x = 0, então x(x − 3) = 0.',
              'Os candidatos são x = 0 e x = 3.',
              'A restrição x ≥ 1 já elimina x = 0; verificando x = 3, √4 = 2 e 3 − 1 = 2.',
            ],
            result: 'A única solução é x = 3.',
            interpretation:
                'A verificação remove candidatos incompatíveis com a equação original.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Não pare na equação transformada',
            content:
                'Uma solução da equação obtida após elevar ao quadrado não é automaticamente solução da equação original.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Por que devemos testar as respostas ao final de uma equação com radical?',
      choices: [
        'Porque elevar ao quadrado pode introduzir soluções estranhas',
        'Porque raízes nunca admitem soluções positivas',
        'Porque toda equação radical tem duas soluções',
      ],
      correctIndex: 0,
      explanation:
          'A potenciação não é uma transformação reversível em todos os casos, então pode criar candidatos que não satisfazem a equação original.',
    ),
    takeaways: [
      'Isole o radical antes de elevar a uma potência.',
      'Observe restrições impostas pela raiz.',
      'Resolva a equação transformada.',
      'Verifique cada candidato na equação original.',
    ],
    closing:
        'Equações com radicais treinam uma habilidade essencial: transformar sem esquecer as condições do problema.',
  ),
  CourseLessonData(
    id: 'equations-10-inequacoes-quadraticas',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Pré-Cálculo',
    title: 'Inequações quadráticas',
    description: 'raízes críticas, sinal e intervalos',
    duration: '≈ 15 min',
    objective:
        'resolver inequações quadráticas por fatoração e estudo de sinal em intervalos',
    symbol: 'x²≥0',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'As raízes dividem a reta',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Pontos críticos organizam o sinal',
            content:
                'Depois de levar todos os termos para um lado, fatoramos a expressão quando possível. Os zeros dos fatores dividem a reta em intervalos. Em cada intervalo, o sinal do produto permanece constante até atravessarmos uma raiz.',
            emphasis:
                'A inequação pede intervalos, não apenas as raízes da equação associada.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Produto positivo',
            problem: 'Resolva x² − 5x + 6 > 0.',
            steps: [
              'Fatore: x² − 5x + 6 = (x − 2)(x − 3).',
              'Os pontos críticos são x = 2 e x = 3.',
              'Para x < 2, os dois fatores são negativos e o produto é positivo.',
              'Para 2 < x < 3, os fatores têm sinais opostos e o produto é negativo.',
              'Para x > 3, os dois fatores são positivos.',
              'Como a desigualdade é estrita, 2 e 3 não entram.',
            ],
            result: 'A solução é (−∞, 2) ∪ (3, +∞).',
            interpretation:
                'A solução reúne os intervalos onde o gráfico da quadrática está acima do eixo x.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Conexão com gráficos',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Sinal é posição vertical',
            content:
                'Quando f(x) > 0, o gráfico está acima do eixo x. Quando f(x) < 0, está abaixo. O estudo de sinal antecipa a análise de crescimento e comportamento usada no Cálculo.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Se (x − 1)(x + 4) ≤ 0, qual intervalo resolve a inequação?',
      choices: ['[−4, 1]', '(−∞, −4] ∪ [1, +∞)', '(−4, 1)'],
      correctIndex: 0,
      explanation:
          'O produto é não positivo entre as raízes. Como ≤ inclui os zeros, entram −4 e 1.',
    ),
    takeaways: [
      'Leve a inequação para a forma expressão comparada com zero.',
      'As raízes são pontos críticos do estudo de sinal.',
      'Teste o sinal em cada intervalo.',
      'Use colchetes quando a igualdade também for aceita.',
    ],
    closing:
        'Resolver uma inequação quadrática é descobrir em quais regiões uma função é positiva ou negativa.',
  ),
  CourseLessonData(
    id: 'equations-11-inequacoes-racionais',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equações e Inequações',
    eyebrow: 'Pré-Cálculo',
    title: 'Inequações racionais',
    description: 'zeros, pontos proibidos e tabela de sinais',
    duration: '≈ 18 min',
    objective:
        'resolver inequações racionais distinguindo zeros do numerador de valores proibidos do denominador',
    symbol: 'P/Q',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Nem todo ponto crítico pode entrar',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Denominador zero é sempre proibido',
            content:
                'Em uma inequação racional, zeros do numerador podem pertencer à solução quando a desigualdade inclui igualdade. Zeros do denominador nunca pertencem ao domínio e devem permanecer excluídos.',
            emphasis:
                'Marque separadamente zeros e pontos proibidos antes de montar a tabela de sinais.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Zero permitido, denominador proibido',
            problem: 'Resolva (x − 2)/(x + 1) ≥ 0.',
            steps: [
              'O numerador zera em x = 2.',
              'O denominador zera em x = −1; esse valor é proibido.',
              'Os pontos −1 e 2 dividem a reta em três intervalos.',
              'Em (−∞, −1), numerador e denominador são negativos: quociente positivo.',
              'Em (−1, 2), os sinais são opostos: quociente negativo.',
              'Em (2, +∞), ambos são positivos.',
              'Como ≥ aceita zero, x = 2 entra; x = −1 nunca entra.',
            ],
            result: 'A solução é (−∞, −1) ∪ [2, +∞).',
            interpretation:
                'A exclusão de −1 vem do domínio, não do sinal da inequação.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Conexão com Cálculo',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.infinity,
            title: 'Pontos proibidos antecipam assíntotas',
            content:
                'Em funções racionais, zeros do denominador são candidatos a descontinuidades e assíntotas verticais. Reconhecê-los já no Pré-Cálculo prepara a análise de limites.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Em (x + 3)/(x − 5) < 0, qual valor jamais pode pertencer à solução?',
      choices: ['−3', '0', '5'],
      correctIndex: 2,
      explanation:
          'x = 5 zera o denominador, então a expressão não está definida nesse ponto.',
    ),
    takeaways: [
      'Zeros do numerador e do denominador têm papéis diferentes.',
      'Denominador zero é sempre excluído.',
      'Pontos críticos dividem a reta para o estudo de sinal.',
      'Inequações racionais preparam domínio e assíntotas.',
    ],
    closing:
        'O estudo de sinal de quocientes conecta álgebra, domínio e comportamento de funções.',
  ),
];

const List<CourseLessonData> _englishLessons = [
  CourseLessonData(
    id: 'equations-09-radicais',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Precalculus',
    title: 'Radical equations',
    description: 'isolation, powers, and verification',
    duration: '≈ 15 min',
    objective:
        'solve simple radical equations while recognizing that raising powers can introduce extraneous solutions',
    symbol: '√x',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Isolate before raising powers',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Leave the radical by itself',
            content:
                'First isolate the radical expression, then raise both sides to a suitable power. The transformed equation may contain candidates that were not solutions of the original equation, so final verification is required.',
            emphasis:
                'Raising powers preserves original solutions but may introduce extra candidates.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Solve and verify',
            problem: 'Solve √(x + 1) = x − 1.',
            steps: [
              'Because a square root is nonnegative, require x − 1 ≥ 0, so x ≥ 1.',
              'Square both sides: x + 1 = (x − 1)².',
              'Expand and rearrange: x² − 3x = 0.',
              'Candidates are x = 0 and x = 3.',
              'The restriction removes x = 0; checking x = 3 gives 2 = 2.',
            ],
            result: 'The only solution is x = 3.',
            interpretation:
                'Verification removes candidates that do not satisfy the original equation.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Common mistake',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Do not stop at the transformed equation',
            content:
                'A solution of the squared equation is not automatically a solution of the original radical equation.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Why must answers be checked after solving a radical equation?',
      choices: [
        'Squaring can introduce extraneous solutions',
        'Square roots never allow positive solutions',
        'Every radical equation has two solutions',
      ],
      correctIndex: 0,
      explanation:
          'Raising powers is not reversible in every case and can create candidates that fail the original equation.',
    ),
    takeaways: [
      'Isolate the radical first.',
      'Respect restrictions from the radical.',
      'Solve the transformed equation.',
      'Verify every candidate in the original equation.',
    ],
    closing:
        'Radical equations train you to transform equations without losing their conditions.',
  ),
  CourseLessonData(
    id: 'equations-10-inequacoes-quadraticas',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Precalculus',
    title: 'Quadratic inequalities',
    description: 'critical roots, signs, and intervals',
    duration: '≈ 15 min',
    objective:
        'solve quadratic inequalities by factoring and analyzing signs across intervals',
    symbol: 'x²≥0',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Roots split the real line',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Critical points organize signs',
            content:
                'Move all terms to one side and factor when possible. The zeros split the real line into intervals, and the sign remains constant inside each interval until a root is crossed.',
            emphasis: 'An inequality asks for intervals, not only roots.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Positive product',
            problem: 'Solve x² − 5x + 6 > 0.',
            steps: [
              'Factor: (x − 2)(x − 3).',
              'Critical points are 2 and 3.',
              'The product is positive for x < 2, negative for 2 < x < 3, and positive for x > 3.',
              'Because the inequality is strict, exclude both roots.',
            ],
            result: 'The solution is (−∞, 2) ∪ (3, +∞).',
            interpretation:
                'These are the intervals where the quadratic graph lies above the x-axis.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Graph connection',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Sign is vertical position',
            content:
                'f(x) > 0 means the graph is above the x-axis; f(x) < 0 means it is below. Sign analysis prepares later function analysis in Calculus.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'If (x − 1)(x + 4) ≤ 0, which interval is the solution?',
      choices: ['[−4, 1]', '(−∞, −4] ∪ [1, +∞)', '(−4, 1)'],
      correctIndex: 0,
      explanation:
          'The product is nonpositive between the roots, and ≤ includes both roots.',
    ),
    takeaways: [
      'Compare a single expression with zero.',
      'Roots are critical points.',
      'Analyze the sign in every interval.',
      'Include roots when equality is allowed.',
    ],
    closing:
        'A quadratic inequality identifies where a function is positive or negative.',
  ),
  CourseLessonData(
    id: 'equations-11-inequacoes-racionais',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Precalculus',
    title: 'Rational inequalities',
    description: 'zeros, forbidden points, and sign charts',
    duration: '≈ 18 min',
    objective:
        'solve rational inequalities while distinguishing numerator zeros from forbidden denominator values',
    symbol: 'P/Q',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Not every critical point can be included',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'A zero denominator is always forbidden',
            content:
                'Numerator zeros may belong to the solution when equality is allowed. Denominator zeros never belong to the domain and must always remain excluded.',
            emphasis: 'Mark zeros and forbidden points separately before building a sign chart.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Allowed zero, forbidden denominator',
            problem: 'Solve (x − 2)/(x + 1) ≥ 0.',
            steps: [
              'The numerator is zero at x = 2.',
              'The denominator is zero at x = −1, which is forbidden.',
              'These points split the line into three intervals.',
              'The quotient is positive on (−∞, −1), negative on (−1, 2), and positive on (2, +∞).',
              'Include x = 2 because ≥ allows zero; never include x = −1.',
            ],
            result: 'The solution is (−∞, −1) ∪ [2, +∞).',
            interpretation: 'The exclusion of −1 comes from the domain, not from the inequality sign.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Connection to Calculus',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.infinity,
            title: 'Forbidden points anticipate asymptotes',
            content:
                'In rational functions, denominator zeros are candidates for discontinuities and vertical asymptotes. Recognizing them now prepares limit analysis.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'In (x + 3)/(x − 5) < 0, which value can never belong to the solution?',
      choices: ['−3', '0', '5'],
      correctIndex: 2,
      explanation: 'x = 5 makes the denominator zero, so the expression is undefined there.',
    ),
    takeaways: [
      'Numerator and denominator zeros play different roles.',
      'A zero denominator is always excluded.',
      'Critical points split the line for sign analysis.',
      'Rational inequalities prepare domains and asymptotes.',
    ],
    closing:
        'Sign analysis of quotients connects algebra, domain, and function behavior.',
  ),
];
