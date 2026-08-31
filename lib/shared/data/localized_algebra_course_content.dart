import 'package:flutter/widgets.dart';

import 'package:calcquest/shared/data/algebra_course_data.dart';
import 'package:calcquest/shared/domain/course_lesson_data.dart';

List<CourseLessonData> localizedAlgebraCourseLessons(Locale locale) {
  if (locale.languageCode != 'en') {
    return algebraCourseLessons;
  }

  return _englishAlgebraCourseLessons;
}

const List<CourseLessonData> _englishAlgebraCourseLessons = [
  CourseLessonData(
    id: 'algebra-01-linguagem',
    topicId: 'algebra-fundamental',
    trailTitle: 'Fundamental Algebra',
    eyebrow: 'Foundations',
    title: 'The language of Algebra',
    description: 'variables, constants, and expressions',
    duration: '≈ 5 min',
    objective:
        'interpret letters as variable numbers and recognize the structure of an algebraic expression',
    symbol: 'x',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Understand the idea',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.notation,
            title: 'A variable represents a possibility',
            content:
                'When we write 3x + 2, the letter x represents a number that can vary. The expression does not ask for a single answer; it describes a rule that produces different values as x changes.',
            emphasis:
                'In Calculus, almost everything starts this way: one quantity varies and another responds to that variation.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Evaluating without mystery',
            problem: 'Evaluate 2x² − 3x + 1 for x = 4.',
            steps: [
              'Substitute 4 for x: 2(4)² − 3(4) + 1.',
              'Evaluate the power before multiplication: 2·16 − 12 + 1.',
              'Calculate from left to right: 32 − 12 + 1 = 21.',
            ],
            result: 'The numerical value is 21.',
            interpretation:
                'The expression stays the same, but a numerical value appears when we choose an input.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'In the expression 5a² − 7, which part varies?',
      choices: ['The number 5', 'The letter a', 'The number −7'],
      correctIndex: 1,
      explanation:
          'The letter a is the variable. The numbers 5 and −7 are constants.',
    ),
    takeaways: [
      'A variable represents a number that can change.',
      'Coefficients multiply literal parts.',
      'Substituting a value for a variable produces a numerical value.',
      'The order of operations prevents incorrect interpretations.',
    ],
    closing:
        'Understanding algebraic language turns symbols into clear instructions.',
  ),
  CourseLessonData(
    id: 'algebra-02-termos-semelhantes',
    topicId: 'algebra-fundamental',
    trailTitle: 'Fundamental Algebra',
    eyebrow: 'Foundations',
    title: 'Like terms',
    description: 'coefficients, constants, and simplification',
    duration: '≈ 5 min',
    objective:
        'simplify sums and differences by combining only terms with the same literal part',
    symbol: '3x',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Understand the idea',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Only terms from the same family combine',
            content:
                'Like terms have exactly the same literal part, with the same variables and the same exponents. That is why 4x and −7x can be combined, while 4x and 4x² cannot.',
            emphasis:
                'The rule is simple: add the coefficients and preserve the literal part.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Grouping carefully',
            problem: 'Simplify 6x² − 3x + 5x² + 8x − 4.',
            steps: [
              'Group the x² terms: 6x² + 5x² = 11x².',
              'Group the x terms: −3x + 8x = 5x.',
              'The constant −4 remains unchanged.',
            ],
            result: 'The simplified form is 11x² + 5x − 4.',
            interpretation:
                'No term changed its nature; we only combined compatible parts.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Which expression is equivalent to 2x + 5x − 3?',
      choices: ['7x − 3', '10x − 3', '4x'],
      correctIndex: 0,
      explanation:
          'We add only 2x and 5x, obtaining 7x. The constant −3 remains.',
    ),
    takeaways: [
      'Like terms have the same literal part.',
      'Different exponents prevent terms from being combined.',
      'Constants combine only with constants.',
      'Grouping terms makes calculations safer.',
    ],
    closing:
        'Mastering like terms makes equations, functions, and derivatives much easier.',
  ),
  CourseLessonData(
    id: 'algebra-03-distributiva',
    topicId: 'algebra-fundamental',
    trailTitle: 'Fundamental Algebra',
    eyebrow: 'Foundations',
    title: 'Distributive property and signs',
    description: 'parentheses, products, and negative signs',
    duration: '≈ 5 min',
    objective:
        'apply the distributive property without losing signs inside parentheses',
    symbol: 'a(b+c)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Understand the idea',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Distributing means crossing the parentheses',
            content:
                'In a(b + c), the factor a multiplies every term inside the parentheses. Thus, a(b + c) = ab + ac. If there is subtraction, the sign of the term also takes part in the multiplication.',
            emphasis:
                'A classic mistake is multiplying only the first term and forgetting the second.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Parentheses with a negative sign',
            problem: 'Simplify −2(x − 5) + 3x.',
            steps: [
              'Distribute −2: −2x + 10.',
              'Add the remaining term: −2x + 10 + 3x.',
              'Combine like terms: x + 10.',
            ],
            result: 'The simplified expression is x + 10.',
            interpretation:
                'The term −5 became +10 because a negative times a negative is positive.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'What is the expanded form of 3(x − 4)?',
      choices: ['3x − 4', '3x − 12', 'x − 12'],
      correctIndex: 1,
      explanation:
          'The 3 multiplies both x and −4, so 3(x − 4) = 3x − 12.',
    ),
    takeaways: [
      'The distributive property connects multiplication and addition.',
      'Every term inside the parentheses must be multiplied.',
      'Negative signs must be carried carefully.',
      'After distributing, combine like terms.',
    ],
    closing:
        'The distributive property is one of the most common tools for preparing expressions before Calculus.',
  ),
  CourseLessonData(
    id: 'algebra-04-potencias',
    topicId: 'algebra-fundamental',
    trailTitle: 'Fundamental Algebra',
    eyebrow: 'Foundations',
    title: 'Powers and exponents',
    description: 'multiplication and division rules',
    duration: '≈ 5 min',
    objective:
        'use exponent rules to simplify monomials and algebraic expressions',
    symbol: 'x²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Understand the idea',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.calculate,
            title: 'Same base, correct rule',
            content:
                'When multiplying powers with the same base, add the exponents: x²·x³ = x⁵. When dividing, subtract the exponents, provided the base is not zero: x⁵/x² = x³.',
            emphasis: 'Do not add the bases. The exponent is what changes.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Coefficient and variable',
            problem: 'Simplify (−2x³)².',
            steps: [
              'Square the coefficient: (−2)² = 4.',
              'Multiply the variable exponents: (x³)² = x⁶.',
              'Combine the parts: 4x⁶.',
            ],
            result: 'The simplified form is 4x⁶.',
            interpretation:
                'Squaring makes the coefficient positive and doubles the exponent of the variable.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'What is the result of x⁴·x²?',
      choices: ['x⁶', 'x⁸', '2x⁶'],
      correctIndex: 0,
      explanation:
          'The bases are equal, so add the exponents: 4 + 2 = 6.',
    ),
    takeaways: [
      'Multiplying powers with the same base adds exponents.',
      'Dividing powers with the same base subtracts exponents.',
      'A power of a power multiplies exponents.',
      'Coefficients also follow sign rules.',
    ],
    closing:
        'Strong exponent skills simplify polynomials, functions, and limits.',
  ),
  CourseLessonData(
    id: 'algebra-05-produtos-notaveis',
    topicId: 'algebra-fundamental',
    trailTitle: 'Fundamental Algebra',
    eyebrow: 'Foundations',
    title: 'Special products',
    description: 'patterns that speed up calculations',
    duration: '≈ 5 min',
    objective:
        'recognize squares, differences of squares, and common binomial products',
    symbol: '(a+b)²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Understand the idea',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'A special product is meaningful distributive work remembered',
            content:
                'Special products are not isolated tricks. They come from the distributive property and appear so often that recognizing the pattern quickly is useful.',
            emphasis: '(a + b)² = a² + 2ab + b², not just a² + b².',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Expanding with a pattern',
            problem: 'Expand (x − 5)².',
            steps: [
              'Use (a − b)² = a² − 2ab + b².',
              'Here, a = x and b = 5.',
              'Substitute: x² − 2·x·5 + 25.',
            ],
            result: 'The result is x² − 10x + 25.',
            interpretation:
                'The middle term appears because the binomial was multiplied by itself.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'What is the expansion of (x + 3)²?',
      choices: ['x² + 9', 'x² + 6x + 9', 'x² + 3x + 9'],
      correctIndex: 1,
      explanation:
          'The middle term is 2·x·3 = 6x. Therefore, (x + 3)² = x² + 6x + 9.',
    ),
    takeaways: [
      'Special products come from the distributive property.',
      'The square of a sum includes a middle term.',
      'A difference of squares factors as (a − b)(a + b).',
      'Recognizing patterns speeds up simplification.',
    ],
    closing:
        'Special products are reliable shortcuts when you understand where they come from.',
  ),
  CourseLessonData(
    id: 'algebra-06-fatoracao',
    topicId: 'algebra-fundamental',
    trailTitle: 'Fundamental Algebra',
    eyebrow: 'Foundations',
    title: 'Factoring',
    description: 'rewriting expressions as products',
    duration: '≈ 5 min',
    objective:
        'factor expressions using a common factor, grouping, and special patterns',
    symbol: '(x−a)',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Understand the idea',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'From a sum to a product',
            content:
                'Factoring means rewriting an expression as a product of factors. This reveals roots, allows algebraic fractions to cancel, and resolves limits with indeterminate forms.',
            emphasis:
                'In Calculus, factoring often turns a stuck problem into a simple calculation.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Factoring out a common factor',
            problem: 'Factor 8x² − 12x.',
            steps: [
              'Find the greatest common factor: 4x.',
              'Divide each term by 4x: 8x²/(4x) = 2x and −12x/(4x) = −3.',
              'Write the product: 4x(2x − 3).',
            ],
            result: 'The factorization is 4x(2x − 3).',
            interpretation:
                'If you distribute 4x again, you recover the original expression.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'What is the factorization of x² − 16?',
      choices: ['(x − 4)(x + 4)', '(x − 8)(x + 8)', '(x − 4)²'],
      correctIndex: 0,
      explanation:
          'It is a difference of squares: x² − 4² = (x − 4)(x + 4).',
    ),
    takeaways: [
      'Factoring rewrites sums as products.',
      'A common factor is the first pattern to look for.',
      'Difference of squares appears very often.',
      'Always check by distributing back.',
    ],
    closing:
        'Factoring is a direct bridge between Algebra, equations, functions, and limits.',
  ),
  CourseLessonData(
    id: 'algebra-07-fracoes-algebricas',
    topicId: 'algebra-fundamental',
    trailTitle: 'Fundamental Algebra',
    eyebrow: 'Foundations',
    title: 'Algebraic fractions',
    description: 'restrictions, simplification, and denominators',
    duration: '≈ 5 min',
    objective:
        'simplify algebraic fractions while preserving domain restrictions',
    symbol: 'x/y',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Understand the idea',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Not every cancellation is allowed',
            content:
                'Only common multiplicative factors can be canceled. A term inside a sum cannot be canceled as if it were a factor. Also, denominators can never be zero.',
            emphasis:
                'In (x + 2)/x, x cannot cancel with part of the numerator because x + 2 is a sum.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Correct cancellation',
            problem: 'Simplify (x² − 9)/(x − 3), with x ≠ 3.',
            steps: [
              'Factor the numerator: x² − 9 = (x − 3)(x + 3).',
              'Rewrite the fraction: [(x − 3)(x + 3)]/(x − 3).',
              'Cancel the common factor x − 3 while keeping the restriction x ≠ 3.',
            ],
            result: 'The simplified form is x + 3, with x ≠ 3.',
            interpretation:
                'The simplified expression looks unrestricted, but the original restriction still applies.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'In which expression is canceling x valid?',
      choices: ['(x + 5)/x', '(3x)/(x)', '(x − 2)/x'],
      correctIndex: 1,
      explanation:
          'In 3x/x, x is a common factor in the numerator and denominator. In the others, x is inside a sum or difference.',
    ),
    takeaways: [
      'A zero denominator is not allowed.',
      'Cancel factors, not terms in a sum.',
      'Factoring before canceling prevents mistakes.',
      'Original restrictions remain important.',
    ],
    closing:
        'Algebraic fractions explain many details about domain, continuity, and limits.',
  ),
  CourseLessonData(
    id: 'algebra-08-sintese',
    topicId: 'algebra-fundamental',
    trailTitle: 'Fundamental Algebra',
    eyebrow: 'Foundations',
    title: 'Algebra synthesis',
    description: 'choosing the right tool',
    duration: '≈ 5 min',
    objective:
        'decide when to simplify, expand, factor, or substitute values',
    symbol: '✓',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Understand the idea',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'There is no single best form',
            content:
                'Expanding helps combine terms. Factoring helps reveal products, roots, and cancellations. Substituting values helps check results and interpret expressions.',
            emphasis:
                'A strong Calculus student does not just memorize calculations; they choose the form that reveals the idea.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'From clutter to a useful form',
            problem: 'Simplify 2(x + 1) + (x − 3)(x + 3).',
            steps: [
              'Distribute the first term: 2x + 2.',
              'Use the difference of squares: (x − 3)(x + 3) = x² − 9.',
              'Combine: x² + 2x − 7.',
            ],
            result: 'The simplified expression is x² + 2x − 7.',
            interpretation:
                'We used the distributive property and a special product in the same expression.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'To simplify (x² − 25)/(x − 5), which tool should come first?',
      choices: [
        'Factor x² − 25',
        'Substitute x = 5',
        'Add 25 to the denominator',
      ],
      correctIndex: 0,
      explanation:
          'The difference of squares lets us write x² − 25 as (x − 5)(x + 5), revealing the common factor.',
    ),
    takeaways: [
      'Expanding, factoring, and substituting serve different purposes.',
      'Factored form reveals cancellations and roots.',
      'Expanded form makes combining terms easier.',
      'Checking your path reduces hidden mistakes.',
    ],
    closing:
        'With this toolbox ready, the next lessons stop feeling like magic and start feeling like strategy.',
  ),
];
