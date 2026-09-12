import 'package:flutter/widgets.dart';

import 'package:calcquest/shared/domain/course_lesson_data.dart';

List<CourseLessonData> localizedPrecalculusFoundationsCourseLessons(
  Locale locale,
) {
  if (locale.languageCode == 'en') {
    return _englishPrecalculusFoundationsCourseLessons;
  }

  return precalculusFoundationsCourseLessons;
}

const List<CourseLessonData> precalculusFoundationsCourseLessons = [
  CourseLessonData(
    id: 'precalculo-00-01-reais',
    topicId: 'algebra-fundamental',
    trailTitle: 'Pré-Cálculo — Fundamentos',
    eyebrow: 'Unidade 0',
    title: 'Números reais e reta real',
    description: 'conjuntos numéricos, inclusão e intervalos',
    duration: '≈ 12 min',
    objective:
        'classificar números reais, interpretar inclusões entre conjuntos e representar desigualdades por intervalos na reta real',
    symbol: 'ℝ',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Organize os números antes de calcular',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Os reais reúnem diferentes tipos de números',
            content:
                'Os naturais ℕ aparecem em contagens. Os inteiros ℤ acrescentam os negativos e o zero. Os racionais ℚ são números que podem ser escritos como fração de inteiros, com denominador diferente de zero. Irracionais, como √2 e π, não podem ser escritos dessa forma. Racionais e irracionais formam o conjunto dos reais ℝ.',
            emphasis:
                'Uma inclusão útil é ℕ ⊂ ℤ ⊂ ℚ ⊂ ℝ. Um número pode pertencer a mais de um desses conjuntos.',
          ),
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Intervalos traduzem desigualdades',
            content:
                'A desigualdade 2 < x ≤ 5 descreve todos os reais maiores que 2 e menores ou iguais a 5. Em notação de intervalo, escrevemos (2, 5]. Parêntese indica extremidade excluída; colchete indica extremidade incluída.',
            emphasis:
                'Com ±∞ usamos sempre parênteses, porque infinito não é um número real que possa pertencer ao intervalo.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Da desigualdade para o intervalo',
            problem: 'Represente −3 ≤ x < 4 em notação de intervalo.',
            steps: [
              'A extremidade −3 está incluída porque aparece ≤.',
              'A extremidade 4 está excluída porque aparece <.',
              'Escreva os valores em ordem crescente: [−3, 4).',
            ],
            result: 'O conjunto solução é [−3, 4).',
            interpretation:
                'Na reta real, o ponto −3 é fechado e o ponto 4 é aberto; todos os pontos entre eles pertencem ao conjunto.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Não confunda intervalo com dois números isolados',
            content:
                'O intervalo [1, 3] contém infinitos números reais: 1, 1,2, √2, 2,5, 3 e todos os demais reais entre 1 e 3.',
            emphasis:
                'Intervalo é um conjunto contínuo de valores, não apenas suas extremidades.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual intervalo representa x > −2?',
      choices: ['[−2, +∞)', '(−2, +∞)', '(−∞, −2]'],
      correctIndex: 1,
      explanation:
          'Como −2 não está incluído, usamos parêntese. Todos os valores maiores seguem até +∞: (−2, +∞).',
    ),
    takeaways: [
      'ℕ, ℤ e ℚ estão contidos em ℝ.',
      'Racionais podem ser escritos como razão de inteiros; irracionais não.',
      'Parêntese exclui uma extremidade e colchete inclui.',
      'Intervalos serão usados para domínio, limites e análise de funções.',
    ],
    closing:
        'A reta real é o espaço básico onde o Pré-Cálculo descreve valores possíveis e restrições.',
  ),
  CourseLessonData(
    id: 'precalculo-00-02-operacoes',
    topicId: 'algebra-fundamental',
    trailTitle: 'Pré-Cálculo — Fundamentos',
    eyebrow: 'Unidade 0',
    title: 'Operações, sinais e prioridade',
    description: 'ordem das operações, parênteses e frações',
    duration: '≈ 12 min',
    objective:
        'executar operações respeitando prioridade, sinais e agrupamentos, reduzindo erros que se propagam em álgebra e cálculo',
    symbol: '()÷×',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'A ordem faz parte da expressão',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Agrupamentos vêm antes',
            content:
                'Resolva primeiro parênteses e outros agrupamentos, depois potências e raízes, em seguida multiplicações e divisões, e por fim adições e subtrações. Operações de mesma prioridade são feitas da esquerda para a direita.',
            emphasis:
                'A expressão 2 + 3·4 vale 14, não 20, porque a multiplicação vem antes da adição.',
          ),
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'O sinal pode pertencer ao número ou à operação',
            content:
                'Em (−3)², o número −3 inteiro é elevado ao quadrado e o resultado é 9. Em −3², a potência atua primeiro sobre 3 e depois aplicamos o sinal negativo: −9.',
            emphasis:
                'Parênteses mudam o objeto sobre o qual a potência atua.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Uma expressão com várias prioridades',
            problem: 'Calcule 18 ÷ 3·2 − (5 − 8).',
            steps: [
              'Resolva o parêntese: 5 − 8 = −3.',
              'Faça divisão e multiplicação da esquerda para a direita: 18 ÷ 3 = 6 e 6·2 = 12.',
              'Subtraia o número negativo: 12 − (−3) = 12 + 3 = 15.',
            ],
            result: 'O valor da expressão é 15.',
            interpretation:
                'Cada etapa preserva a expressão original e evita alterar sua estrutura por uma regra inexistente.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Não existe prioridade da multiplicação sobre a divisão',
            content:
                'Multiplicação e divisão têm a mesma prioridade. Quando aparecem no mesmo nível, calculamos da esquerda para a direita.',
            emphasis:
                'O mesmo vale para adição e subtração.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual é o valor de −2² + (−2)²?',
      choices: ['−8', '0', '8'],
      correctIndex: 1,
      explanation:
          '−2² = −4, enquanto (−2)² = 4. Logo, −4 + 4 = 0.',
    ),
    takeaways: [
      'Agrupamentos antecedem potências, produtos e somas.',
      'Operações de mesma prioridade seguem da esquerda para a direita.',
      'Parênteses determinam se um sinal participa de uma potência.',
      'Erros de prioridade se propagam para equações, funções e limites.',
    ],
    closing:
        'Ler a estrutura antes de calcular é mais importante do que calcular rápido.',
  ),
  CourseLessonData(
    id: 'precalculo-00-03-linguagem',
    topicId: 'algebra-fundamental',
    trailTitle: 'Pré-Cálculo — Fundamentos',
    eyebrow: 'Unidade 0',
    title: 'Variáveis, constantes e expressões',
    description: 'termos, coeficientes, símbolos e valor numérico',
    duration: '≈ 12 min',
    objective:
        'identificar a estrutura de expressões algébricas e interpretar corretamente variáveis, constantes, coeficientes e termos',
    symbol: '3x+2',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Leia uma expressão como linguagem',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Cada parte tem uma função',
            content:
                'Na expressão 4x² − 3x + 7, x é a variável; 4 e −3 são coeficientes dos termos com variável; 7 é termo constante. Os termos são separados por adições ou subtrações consideradas no nível principal da expressão.',
            emphasis:
                'Uma expressão descreve um valor; uma equação acrescenta uma igualdade a ser satisfeita.',
          ),
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'A variável representa possibilidade',
            content:
                'Uma letra não é um objeto misterioso: ela representa um número ainda não fixado ou uma quantidade que pode variar. Quando atribuímos um valor à variável, podemos calcular o valor numérico da expressão.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Substituição com sinais',
            problem: 'Calcule 2x² − 5x + 1 para x = −2.',
            steps: [
              'Substitua x por −2 usando parênteses: 2(−2)² − 5(−2) + 1.',
              'Calcule a potência: (−2)² = 4.',
              'Efetue os produtos: 2·4 = 8 e −5(−2) = +10.',
              'Some: 8 + 10 + 1 = 19.',
            ],
            result: 'O valor numérico é 19.',
            interpretation:
                'Usar parênteses na substituição conserva o sinal do valor inserido.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'x² e 2x não significam a mesma coisa',
            content:
                'x² significa x·x. Já 2x significa 2·x. Expoente e coeficiente desempenham papéis diferentes.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Na expressão −6a³ + 4, qual é o coeficiente do termo com a³?',
      choices: ['−6', '3', '4'],
      correctIndex: 0,
      explanation:
          'O coeficiente é o fator numérico que multiplica a parte literal; portanto, é −6.',
    ),
    takeaways: [
      'Variável representa uma quantidade que pode assumir valores.',
      'Coeficiente multiplica a parte literal de um termo.',
      'Constantes não dependem da variável.',
      'Substituições com números negativos devem preservar parênteses.',
    ],
    closing:
        'Com a linguagem algébrica clara, as próximas técnicas deixam de parecer regras isoladas.',
  ),
  CourseLessonData(
    id: 'precalculo-00-04-potencias-raizes',
    topicId: 'algebra-fundamental',
    trailTitle: 'Pré-Cálculo — Fundamentos',
    eyebrow: 'Unidade 0',
    title: 'Potências, raízes e expoentes',
    description: 'expoentes inteiros, racionais e restrições reais',
    duration: '≈ 15 min',
    objective:
        'usar propriedades de expoentes e interpretar raízes e expoentes racionais no conjunto dos números reais',
    symbol: 'xᵃ',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Potências condensam multiplicações',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'As regras dependem da base',
            content:
                'Para a ≠ 0, valem a⁰ = 1 e a⁻ⁿ = 1/aⁿ. Em produtos de mesma base, somamos expoentes: aᵐaⁿ = aᵐ⁺ⁿ. Em quocientes, subtraímos: aᵐ/aⁿ = aᵐ⁻ⁿ. Em potência de potência, multiplicamos expoentes.',
            emphasis:
                'Essas regras não autorizam distribuir expoente sobre soma: (a + b)² geralmente não é a² + b².',
          ),
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Expoente racional conecta potência e raiz',
            content:
                'Quando a expressão é real e está definida, a^(1/n) representa a raiz n-ésima de a e a^(m/n) pode ser interpretado como a raiz n-ésima de a elevada a m. Para índice par, o radicando precisa ser não negativo no conjunto dos reais.',
            emphasis:
                '√x é real apenas para x ≥ 0; já ∛x é real para qualquer x real.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Expoente negativo e racional',
            problem: 'Simplifique 16^(3/4) e escreva 2⁻³ como fração.',
            steps: [
              '16^(1/4) = 2, pois 2⁴ = 16.',
              'Então 16^(3/4) = (16^(1/4))³ = 2³ = 8.',
              'Para o expoente negativo, 2⁻³ = 1/2³ = 1/8.',
            ],
            result: '16^(3/4) = 8 e 2⁻³ = 1/8.',
            interpretation:
                'O expoente informa tanto a operação de potência quanto, em forma racional, uma operação de raiz.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Erro comum',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'A raiz principal é não negativa',
            content:
                'Embora x² = 9 tenha duas soluções, x = ±3, a expressão √9 representa especificamente a raiz principal 3.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual expressão é equivalente a x^(−2), para x ≠ 0?',
      choices: ['−x²', '1/x²', '1/(2x)'],
      correctIndex: 1,
      explanation:
          'Expoente negativo indica o inverso da potência correspondente: x^(−2) = 1/x².',
    ),
    takeaways: [
      'Produtos de mesma base somam expoentes.',
      'Expoente negativo representa inverso multiplicativo.',
      'Expoente racional relaciona potência e raiz.',
      'Raízes de índice par impõem restrições no conjunto dos reais.',
    ],
    closing:
        'Potências e raízes reaparecem em funções, limites, derivadas e modelos exponenciais.',
  ),
  CourseLessonData(
    id: 'precalculo-00-05-modulo',
    topicId: 'algebra-fundamental',
    trailTitle: 'Pré-Cálculo — Fundamentos',
    eyebrow: 'Unidade 0',
    title: 'Valor absoluto e distância',
    description: 'módulo, distância e inequações simples',
    duration: '≈ 15 min',
    objective:
        'interpretar valor absoluto como distância e resolver relações simples de igualdade e desigualdade envolvendo módulo',
    symbol: '|x|',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Módulo mede distância, não sinal',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Distância até zero',
            content:
                '|x| representa a distância entre x e 0 na reta real. Por isso |5| = 5 e |−5| = 5. Em forma por casos, |x| = x quando x ≥ 0 e |x| = −x quando x < 0.',
            emphasis:
                'O valor absoluto nunca é negativo.',
          ),
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Distância entre dois números',
            content:
                'A distância entre x e a pode ser escrita como |x − a|. Assim, |x − 3| < 2 significa que x está a menos de 2 unidades do número 3.',
            emphasis:
                'Geometricamente, |x − 3| < 2 descreve o intervalo (1, 5).',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Veja funcionando',
        blocks: [
          WorkedExampleBlockData(
            title: 'Uma inequação como distância',
            problem: 'Resolva |x − 4| ≤ 3.',
            steps: [
              'Leia como distância: x está a no máximo 3 unidades de 4.',
              'A extremidade esquerda é 4 − 3 = 1.',
              'A extremidade direita é 4 + 3 = 7.',
              'Como a distância pode ser exatamente 3, as extremidades são incluídas.',
            ],
            result: '1 ≤ x ≤ 7, ou [1, 7].',
            interpretation:
                'A solução é um intervalo centrado em 4 com raio 3.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Conexão com o Cálculo',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.infinity,
            title: 'Distâncias aparecem na definição de limite',
            content:
                'Mais adiante, expressões como |x − a| e |f(x) − L| permitirão medir quão perto x está de a e quão perto f(x) está de L. Entender módulo como distância prepara a linguagem formal de limites.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Qual intervalo resolve |x − 2| < 4?',
      choices: ['(−2, 6)', '[−2, 6]', '(−6, 2)'],
      correctIndex: 0,
      explanation:
          'A distância de x até 2 deve ser menor que 4. As extremidades são 2 − 4 = −2 e 2 + 4 = 6, sem inclusão.',
    ),
    takeaways: [
      'Valor absoluto representa distância até zero.',
      '|x − a| representa a distância entre x e a.',
      'Inequações com módulo podem ser interpretadas geometricamente.',
      'A linguagem de distância será essencial na definição de limite.',
    ],
    closing:
        'Quando módulo vira distância, muitas regras passam a ter significado geométrico.',
  ),
];

const List<CourseLessonData> _englishPrecalculusFoundationsCourseLessons = [
  CourseLessonData(
    id: 'precalculo-00-01-reais',
    topicId: 'algebra-fundamental',
    trailTitle: 'Precalculus — Foundations',
    eyebrow: 'Unit 0',
    title: 'Real numbers and the real line',
    description: 'number sets, inclusion, and intervals',
    duration: '≈ 12 min',
    objective:
        'classify real numbers, interpret set inclusions, and represent inequalities as intervals on the real line',
    symbol: 'ℝ',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Organize numbers before calculating',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'The real numbers contain different number systems',
            content:
                'Natural numbers ℕ arise in counting. Integers ℤ add zero and negative numbers. Rational numbers ℚ can be written as a ratio of integers with nonzero denominator. Irrational numbers, such as √2 and π, cannot. Rational and irrational numbers together form the real numbers ℝ.',
            emphasis:
                'A useful inclusion is ℕ ⊂ ℤ ⊂ ℚ ⊂ ℝ. One number may belong to several of these sets.',
          ),
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Intervals translate inequalities',
            content:
                'The inequality 2 < x ≤ 5 describes every real number greater than 2 and less than or equal to 5. Interval notation writes this as (2, 5]. Parentheses exclude an endpoint; brackets include it.',
            emphasis:
                'We always use parentheses with ±∞ because infinity is not a real endpoint.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'From inequality to interval',
            problem: 'Write −3 ≤ x < 4 in interval notation.',
            steps: [
              'The endpoint −3 is included because the inequality uses ≤.',
              'The endpoint 4 is excluded because the inequality uses <.',
              'Write the endpoints in increasing order: [−3, 4).',
            ],
            result: 'The solution set is [−3, 4).',
            interpretation:
                'On the real line, −3 is closed, 4 is open, and every point between them belongs to the set.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Common mistake',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'An interval is not just two isolated numbers',
            content:
                'The interval [1, 3] contains infinitely many real numbers, including 1, 1.2, √2, 2.5, 3, and every other real number between 1 and 3.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Which interval represents x > −2?',
      choices: ['[−2, +∞)', '(−2, +∞)', '(−∞, −2]'],
      correctIndex: 1,
      explanation:
          'Because −2 is excluded, use a parenthesis. All greater values continue toward +∞: (−2, +∞).',
    ),
    takeaways: [
      'ℕ, ℤ, and ℚ are contained in ℝ.',
      'Rational numbers are ratios of integers; irrational numbers are not.',
      'Parentheses exclude endpoints and brackets include them.',
      'Intervals will describe domains, limits, and function behavior.',
    ],
    closing:
        'The real line is the basic space where Precalculus describes possible values and restrictions.',
  ),
  CourseLessonData(
    id: 'precalculo-00-02-operacoes',
    topicId: 'algebra-fundamental',
    trailTitle: 'Precalculus — Foundations',
    eyebrow: 'Unit 0',
    title: 'Operations, signs, and precedence',
    description: 'order of operations, grouping, and fractions',
    duration: '≈ 12 min',
    objective:
        'perform operations while respecting precedence, signs, and grouping so errors do not propagate into algebra and calculus',
    symbol: '()÷×',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Order is part of the expression',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Grouping comes first',
            content:
                'Evaluate grouping symbols first, then powers and roots, then multiplication and division, and finally addition and subtraction. Operations with the same precedence are handled from left to right.',
            emphasis:
                'The expression 2 + 3·4 equals 14, not 20, because multiplication precedes addition.',
          ),
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'A sign may belong to the number or the operation',
            content:
                'In (−3)², the entire number −3 is squared, giving 9. In −3², the power applies to 3 first and the negative sign is applied afterward, giving −9.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Several precedence levels',
            problem: 'Evaluate 18 ÷ 3·2 − (5 − 8).',
            steps: [
              'Evaluate the parentheses: 5 − 8 = −3.',
              'Perform division and multiplication left to right: 18 ÷ 3 = 6, then 6·2 = 12.',
              'Subtract the negative number: 12 − (−3) = 15.',
            ],
            result: 'The expression equals 15.',
            interpretation:
                'Each step preserves the original structure instead of inventing a new precedence rule.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Common mistake',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Multiplication does not outrank division',
            content:
                'Multiplication and division share the same precedence and are evaluated from left to right. The same is true for addition and subtraction.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'What is −2² + (−2)²?',
      choices: ['−8', '0', '8'],
      correctIndex: 1,
      explanation: '−2² = −4, while (−2)² = 4. Therefore the sum is 0.',
    ),
    takeaways: [
      'Grouping precedes powers, products, and sums.',
      'Equal-precedence operations are evaluated left to right.',
      'Parentheses determine whether a sign is part of a power.',
      'Precedence errors propagate into equations, functions, and limits.',
    ],
    closing:
        'Reading structure before calculating is more valuable than calculating quickly.',
  ),
  CourseLessonData(
    id: 'precalculo-00-03-linguagem',
    topicId: 'algebra-fundamental',
    trailTitle: 'Precalculus — Foundations',
    eyebrow: 'Unit 0',
    title: 'Variables, constants, and expressions',
    description: 'terms, coefficients, symbols, and numerical value',
    duration: '≈ 12 min',
    objective:
        'identify the structure of algebraic expressions and correctly interpret variables, constants, coefficients, and terms',
    symbol: '3x+2',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Read an expression as language',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Each part has a role',
            content:
                'In 4x² − 3x + 7, x is the variable; 4 and −3 are coefficients; and 7 is a constant term. Terms are separated by top-level additions or subtractions.',
            emphasis:
                'An expression describes a value; an equation adds an equality that must be satisfied.',
          ),
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'A variable represents possibility',
            content:
                'A letter represents a number that is not yet fixed or a quantity that may vary. Once a value is assigned, the expression can be evaluated numerically.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Substitution with signs',
            problem: 'Evaluate 2x² − 5x + 1 for x = −2.',
            steps: [
              'Substitute using parentheses: 2(−2)² − 5(−2) + 1.',
              'Evaluate the power: (−2)² = 4.',
              'Multiply: 2·4 = 8 and −5(−2) = +10.',
              'Add: 8 + 10 + 1 = 19.',
            ],
            result: 'The numerical value is 19.',
            interpretation:
                'Parentheses preserve the sign of a substituted negative value.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Common mistake',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'x² and 2x are different structures',
            content:
                'x² means x·x, while 2x means 2·x. Exponents and coefficients have different roles.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'In −6a³ + 4, what is the coefficient of a³?',
      choices: ['−6', '3', '4'],
      correctIndex: 0,
      explanation:
          'The coefficient is the numerical factor multiplying the literal part, so it is −6.',
    ),
    takeaways: [
      'A variable represents a quantity that may take values.',
      'A coefficient multiplies the literal part of a term.',
      'Constants do not depend on the variable.',
      'Negative substitutions should preserve parentheses.',
    ],
    closing:
        'Once algebraic language is clear, later techniques stop looking like isolated rules.',
  ),
  CourseLessonData(
    id: 'precalculo-00-04-potencias-raizes',
    topicId: 'algebra-fundamental',
    trailTitle: 'Precalculus — Foundations',
    eyebrow: 'Unit 0',
    title: 'Powers, roots, and exponents',
    description: 'integer and rational exponents and real restrictions',
    duration: '≈ 15 min',
    objective:
        'use exponent laws and interpret roots and rational exponents over the real numbers',
    symbol: 'xᵃ',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Powers condense multiplication',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'Rules depend on the base',
            content:
                'For a ≠ 0, a⁰ = 1 and a⁻ⁿ = 1/aⁿ. For products with the same base, add exponents: aᵐaⁿ = aᵐ⁺ⁿ. For quotients, subtract them. For a power of a power, multiply exponents.',
            emphasis:
                'These rules do not distribute an exponent over addition: (a + b)² is generally not a² + b².',
          ),
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'Rational exponents connect powers and roots',
            content:
                'When defined over the reals, a^(1/n) is the nth root of a, and a^(m/n) combines a root and a power. For even n, the radicand must be nonnegative.',
            emphasis:
                '√x is real only for x ≥ 0, while ∛x is real for every real x.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Negative and rational exponents',
            problem: 'Simplify 16^(3/4) and write 2⁻³ as a fraction.',
            steps: [
              '16^(1/4) = 2 because 2⁴ = 16.',
              'Then 16^(3/4) = 2³ = 8.',
              'For the negative exponent, 2⁻³ = 1/2³ = 1/8.',
            ],
            result: '16^(3/4) = 8 and 2⁻³ = 1/8.',
            interpretation:
                'A rational exponent encodes both root and power operations.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Common mistake',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'The principal square root is nonnegative',
            content:
                'Although x² = 9 has solutions x = ±3, the expression √9 specifically denotes the principal root 3.',
            tone: LearningCardTone.warning,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Which expression equals x^(−2), for x ≠ 0?',
      choices: ['−x²', '1/x²', '1/(2x)'],
      correctIndex: 1,
      explanation:
          'A negative exponent represents the reciprocal of the corresponding positive power.',
    ),
    takeaways: [
      'Products with the same base add exponents.',
      'Negative exponents represent reciprocals.',
      'Rational exponents connect powers and roots.',
      'Even-index roots impose restrictions over the reals.',
    ],
    closing:
        'Powers and roots return throughout functions, limits, derivatives, and exponential models.',
  ),
  CourseLessonData(
    id: 'precalculo-00-05-modulo',
    topicId: 'algebra-fundamental',
    trailTitle: 'Precalculus — Foundations',
    eyebrow: 'Unit 0',
    title: 'Absolute value and distance',
    description: 'modulus, distance, and simple inequalities',
    duration: '≈ 15 min',
    objective:
        'interpret absolute value as distance and solve simple equalities and inequalities involving absolute value',
    symbol: '|x|',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Absolute value measures distance, not sign',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Distance from zero',
            content:
                '|x| is the distance between x and 0 on the real line. Thus |5| = 5 and |−5| = 5. Piecewise, |x| = x for x ≥ 0 and |x| = −x for x < 0.',
            emphasis: 'Absolute value is never negative.',
          ),
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Distance between two numbers',
            content:
                'The distance between x and a is |x − a|. Thus |x − 3| < 2 means x lies less than 2 units away from 3.',
            emphasis: 'Geometrically, |x − 3| < 2 describes (1, 5).',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'An inequality as distance',
            problem: 'Solve |x − 4| ≤ 3.',
            steps: [
              'Read it as distance: x is at most 3 units from 4.',
              'The left endpoint is 4 − 3 = 1.',
              'The right endpoint is 4 + 3 = 7.',
              'Because distance may equal 3, both endpoints are included.',
            ],
            result: '1 ≤ x ≤ 7, or [1, 7].',
            interpretation: 'The solution is an interval centered at 4 with radius 3.',
          ),
        ],
      ),
      LessonSectionData(
        number: '3',
        title: 'Connection to Calculus',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.infinity,
            title: 'Distances appear in the definition of limit',
            content:
                'Later, expressions such as |x − a| and |f(x) − L| measure how close x is to a and how close f(x) is to L. Absolute value as distance prepares the formal language of limits.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Which interval solves |x − 2| < 4?',
      choices: ['(−2, 6)', '[−2, 6]', '(−6, 2)'],
      correctIndex: 0,
      explanation:
          'x must be less than 4 units from 2. The endpoints are −2 and 6, neither included.',
    ),
    takeaways: [
      'Absolute value represents distance from zero.',
      '|x − a| represents the distance between x and a.',
      'Absolute-value inequalities have a geometric interpretation.',
      'Distance language is essential in the formal definition of a limit.',
    ],
    closing:
        'Once absolute value becomes distance, many rules gain geometric meaning.',
  ),
];
