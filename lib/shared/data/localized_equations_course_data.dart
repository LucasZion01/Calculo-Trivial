import 'package:flutter/widgets.dart';

import 'equations_course_data.dart';
import '../domain/course_lesson_data.dart';

List<CourseLessonData> localizedEquationsCourseLessons(Locale locale) {
  if (locale.languageCode == 'en') {
    return _englishEquationsCourseLessons;
  }
  return equationsCourseLessons;
}

const List<CourseLessonData> _englishEquationsCourseLessons = [
  CourseLessonData(
    id: 'equations-01-equilibrio',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Foundations',
    title: 'Equations and balance',
    description: 'equality, unknowns, and equivalence',
    duration: '≈ 5 min',
    objective:
        'understand an equation as an equality and preserve its balance during transformations',
    symbol: '=',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Understand the idea',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'Think of a balance scale',
            content:
                'An equation states that two expressions have the same value. Solving the equation means finding which values of the unknown make that equality true.',
            emphasis:
                'Everything you do to one side of the equation must preserve the equality.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'One operation at a time',
            problem: 'Solve x + 7 = 12.',
            steps: [
              'We want to leave x by itself.',
              'Subtract 7 from both sides: x + 7 − 7 = 12 − 7.',
              'Simplify: x = 5.',
              'Check: 5 + 7 = 12.',
            ],
            result: 'The solution is x = 5.',
            interpretation:
                'Subtracting 7 from both sides produced an equivalent equation.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'If x − 4 = 9, which operation isolates x?',
      choices: [
        'Subtract 4 from both sides',
        'Add 4 to both sides',
        'Multiply both sides by 4',
      ],
      correctIndex: 1,
      explanation:
          'Adding 4 to both sides gives x = 13 without changing the equality.',
    ),
    takeaways: [
      'An equation represents an equality.',
      'The unknown is the value we want to determine.',
      'Equivalent operations preserve equality.',
      'A solution must make the original equation true.',
    ],
    closing:
        'Solving an equation means preserving balance until the unknown is isolated.',
  ),
  CourseLessonData(
    id: 'equations-02-primeiro-grau',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Linear equations',
    title: 'First-degree equations',
    description: 'inverse operations and isolation',
    duration: '≈ 5 min',
    objective:
        'solve linear equations using inverse operations in an organized way',
    symbol: 'ax+b',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Build a strategy',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Undo operations in the right order',
            content:
                'In an equation such as 3x + 4 = 19, the unknown was first multiplied by 3 and then increased by 4. To isolate it, follow the reverse path: remove 4 and then divide by 3.',
            emphasis:
                'There is no magic “move it to the other side.” There are inverse operations applied to both sides.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Solve step by step',
        blocks: [
          WorkedExampleBlockData(
            title: 'Two operations',
            problem: 'Solve 5x − 7 = 18.',
            steps: [
              'Add 7 to both sides: 5x = 25.',
              'Divide both sides by 5: x = 5.',
              'Substitute into the original equation: 5·5 − 7 = 18.',
            ],
            result: 'x = 5.',
            interpretation:
                'The check confirms that the value found satisfies the equation.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'What is the solution of 4x + 3 = 19?',
      choices: ['x = 4', 'x = 5', 'x = 16'],
      correctIndex: 0,
      explanation: 'Subtracting 3 gives 4x = 16. Dividing by 4 gives x = 4.',
    ),
    takeaways: [
      'Use inverse operations.',
      'Remove addition or subtraction first.',
      'Then remove multiplication or division.',
      'Whenever possible, check the answer.',
    ],
    closing:
        'Organization matters more than speed when solving equations.',
  ),
  CourseLessonData(
    id: 'equations-03-parenteses-fracoes',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Linear equations',
    title: 'Parentheses and fractions',
    description: 'distribution and denominators',
    duration: '≈ 5 min',
    objective:
        'solve equations with parentheses and fractions by preparing the expression before isolating the unknown',
    symbol: 'x/3',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Prepare before isolating',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Simplify the structure',
            content:
                'When parentheses or fractions appear, simplify the expression before trying to leave x alone. Use distribution, combine like terms, or clear denominators.',
            emphasis:
                'A complicated equation can become a simple linear equation.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'See it in action',
        blocks: [
          WorkedExampleBlockData(
            title: 'Parentheses on both sides',
            problem: 'Solve 3(x + 1) = 2x + 7.',
            steps: [
              'Distribute: 3x + 3 = 2x + 7.',
              'Subtract 2x from both sides: x + 3 = 7.',
              'Subtract 3 from both sides: x = 4.',
            ],
            result: 'x = 4.',
            interpretation: 'Distribution revealed an ordinary linear equation.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'If x/5 + 2 = 6, what is x?',
      choices: ['4', '8', '20'],
      correctIndex: 2,
      explanation:
          'Subtracting 2 gives x/5 = 4. Multiplying by 5 gives x = 20.',
    ),
    takeaways: [
      'Use distribution to remove parentheses.',
      'Combine like terms.',
      'Clear denominators when that simplifies the equation.',
      'Preserve equivalence at every transformation.',
    ],
    closing:
        'Before attacking the unknown, make the equation work in your favor.',
  ),
  CourseLessonData(
    id: 'equations-04-casos-especiais',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Interpretation',
    title: 'One, none, or infinitely many solutions',
    description: 'identities and contradictions',
    duration: '≈ 5 min',
    objective:
        'distinguish equations with one solution, no solution, or infinitely many solutions',
    symbol: '∅',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Not every equation ends with x = number',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'Look at what remains',
            content:
                'During simplification, the unknown may disappear. A false statement represents a contradiction; a statement that is always true represents an identity.',
            emphasis:
                '2 = 5 means no solution. 2 = 2 means infinitely many solutions.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Interpret the result',
        blocks: [
          WorkedExampleBlockData(
            title: 'Contradiction',
            problem: 'Solve 2(x + 1) = 2x + 5.',
            steps: [
              'Distribute: 2x + 2 = 2x + 5.',
              'Subtract 2x from both sides: 2 = 5.',
              'The resulting statement is false.',
            ],
            result: 'The equation has no solution.',
            interpretation:
                'No value of x can make 2 = 5 true.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'What does it mean if an equation ends with 7 = 7?',
      choices: ['No solution', 'Only x = 7', 'Infinitely many solutions'],
      correctIndex: 2,
      explanation:
          'Because the equality is always true, every allowed value satisfies the equation.',
    ),
    takeaways: [
      'One solution produces x = number.',
      'A contradiction means no solution.',
      'An identity means infinitely many solutions.',
      'The solution set must be interpreted.',
    ],
    closing:
        'Solving also means recognizing when there is not a single answer.',
  ),
  CourseLessonData(
    id: 'equations-05-sistemas-lineares',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Two unknowns',
    title: 'Systems of equations',
    description: 'substitution and elimination',
    duration: '≈ 5 min',
    objective:
        'solve simple linear systems and interpret the solution as an ordered pair',
    symbol: '{x,y}',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Two conditions at the same time',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'The solution must satisfy both equations',
            content:
                'A system combines two or more equations. In a system with x and y, we look for a pair of values that makes every equation true at the same time.',
            emphasis: 'Solving only one equation does not solve the system.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Eliminate one unknown',
        blocks: [
          WorkedExampleBlockData(
            title: 'Addition method',
            problem: 'x + y = 7\nx − y = 1',
            steps: [
              'Add the two equations.',
              'y and −y cancel: 2x = 8.',
              'Divide by 2: x = 4.',
              'Substitute into x + y = 7: y = 3.',
            ],
            result: 'The solution is (4, 3).',
            interpretation:
                'The pair x = 4 and y = 3 satisfies both equations simultaneously.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'If x + y = 10 and x − y = 2, what is x?',
      choices: ['4', '6', '8'],
      correctIndex: 1,
      explanation: 'Adding the equations gives 2x = 12. Therefore, x = 6.',
    ),
    takeaways: [
      'A system imposes several conditions simultaneously.',
      'Substitution replaces an unknown with an equivalent expression.',
      'Elimination cancels one unknown.',
      'The answer can be represented by an ordered pair.',
    ],
    closing:
        'Systems turn multiple pieces of information into one compatible solution.',
  ),
  CourseLessonData(
    id: 'equations-06-quadraticas',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Quadratics',
    title: 'Quadratic equations',
    description: 'roots, factoring, and the zero-product property',
    duration: '≈ 5 min',
    objective:
        'solve simple quadratic equations using factoring and the zero-product property',
    symbol: 'x²',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Now there may be two roots',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.idea,
            title: 'The degree changes the behavior',
            content:
                'A quadratic equation contains an x² term. It may have two real roots, one repeated root, or no real roots.',
            emphasis: 'If AB = 0, then A = 0 or B = 0.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Turn it into a product',
        blocks: [
          WorkedExampleBlockData(
            title: 'Factoring and zero product',
            problem: 'Solve x² − 5x + 6 = 0.',
            steps: [
              'Factor: (x − 2)(x − 3) = 0.',
              'Then x − 2 = 0 or x − 3 = 0.',
              'Solve each equation.',
            ],
            result: 'x = 2 or x = 3.',
            interpretation: 'Either factor can make the product equal to zero.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'What are the solutions of x² − 9 = 0?',
      choices: ['Only x = 3', 'x = −3 or x = 3', 'x = 9'],
      correctIndex: 1,
      explanation: 'x² − 9 = (x − 3)(x + 3), so x = 3 or x = −3.',
    ),
    takeaways: [
      'Quadratic equations contain an x² term.',
      'Factoring can reveal the roots.',
      'The zero-product property separates factors.',
      'A quadratic equation can have more than one solution.',
    ],
    closing:
        'Factoring directly connects Algebra to solving quadratic equations.',
  ),
  CourseLessonData(
    id: 'equations-07-inequacoes',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Inequalities',
    title: 'Inequalities',
    description: 'intervals and reversing the sign',
    duration: '≈ 5 min',
    objective:
        'solve linear inequalities and interpret the solution as a set of values',
    symbol: '≤',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'The answer is now a region',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'We are not looking for just one number',
            content:
                'An inequality compares values using <, >, ≤, or ≥. The solution is usually a set of numbers.',
            emphasis: 'x > 4 represents every real number greater than 4.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'The most important caution',
        blocks: [
          WorkedExampleBlockData(
            title: 'Division by a negative number',
            problem: 'Solve −3x > 12.',
            steps: [
              'Divide both sides by −3.',
              'Because the divisor is negative, reverse > to <.',
              'Obtain x < −4.',
            ],
            result: 'The solution is x < −4.',
            interpretation:
                'Without reversing the sign, the solution set would be wrong.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'What is the solution of −2x ≤ 8?',
      choices: ['x ≤ −4', 'x ≥ −4', 'x ≥ 4'],
      correctIndex: 1,
      explanation: 'Dividing by −2 reverses ≤ to ≥. Therefore, x ≥ −4.',
    ),
    takeaways: [
      'Inequalities describe sets of values.',
      'Addition and subtraction preserve the inequality direction.',
      'Multiplying or dividing by a negative reverses the sign.',
      'The solution can be represented on a number line.',
    ],
    closing:
        'In inequalities, preserving order is as important as isolating the unknown.',
  ),
  CourseLessonData(
    id: 'equations-08-modulo-revisao',
    topicId: 'equacoes-inequacoes',
    trailTitle: 'Equations and Inequalities',
    eyebrow: 'Consolidation',
    title: 'Absolute value and final strategy',
    description: 'distance, two possibilities, and review',
    duration: '≈ 5 min',
    objective:
        'interpret simple absolute-value equations and choose appropriate strategies for different problems',
    symbol: '|x|',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Absolute value represents distance',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'Distance is never negative',
            content:
                'The absolute value |x| represents the distance between x and zero. That is why |x| = 5 has two solutions: 5 and −5.',
            emphasis:
                '|x| = a, with a > 0, usually gives x = a or x = −a.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Choose the tool',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Classify before calculating',
            content:
                'Look for parentheses, fractions, x², two unknowns, an inequality, or an absolute value. The structure tells you which strategy to use.',
            emphasis:
                'Recognizing the problem type reduces errors and avoids unnecessary formulas.',
          ),
          WorkedExampleBlockData(
            title: 'Absolute-value equation',
            problem: 'Solve |x| = 7.',
            steps: [
              'Interpret |x| as distance from zero.',
              'There are two points seven units from zero.',
              'Those points are 7 and −7.',
            ],
            result: 'x = −7 or x = 7.',
            interpretation: 'Both solutions have the same absolute value.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Which values solve |x| = 3?',
      choices: ['Only x = 3', 'x = −3 or x = 3', 'x = 0 or x = 3'],
      correctIndex: 1,
      explanation:
          'Both −3 and 3 are three units away from zero.',
    ),
    takeaways: [
      'Absolute value represents distance.',
      'Absolute-value equations can produce two solutions.',
      'The structure indicates the appropriate strategy.',
      'Checking the solution remains essential.',
    ],
    closing:
        'You now have a solid foundation for handling different equations and inequalities.',
  ),
];
