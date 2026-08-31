import 'package:flutter/widgets.dart';

import 'package:calcquest/shared/data/limits_course_data.dart';
import 'package:calcquest/shared/domain/course_lesson_data.dart';

List<CourseLessonData> localizedLimitsCourseLessons(Locale locale) {
  if (locale.languageCode != 'en') return limitsCourseLessons;

  return const [
    CourseLessonData(
      id: 'limites-01-intuicao',
      topicId: 'limites',
      trailTitle: 'Limits • Unit 1',
      eyebrow: 'Lesson 1 of 8 • Core idea',
      title: 'Approach before calculating',
      description: 'Build intuition for limits and learn how to read each part of the notation.',
      duration: '≈ 5 min',
      objective: 'explain in your own words what a limit describes',
      symbol: 'lim',
      sections: [
        LessonSectionData(
          number: '1',
          title: 'Observe the behavior',
          subtitle: 'The point of interest guides the approach.',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.route,
              title: 'The road and the altitude',
              content: 'Imagine that x marks a car’s position and f(x) gives its altitude. As the car approaches kilometer 2, we observe which altitude the values of f(x) approach. That prediction is the limit.',
              emphasis: 'The car does not need to stop at kilometer 2: the limit studies behavior near the point.',
            ),
            ConceptBlockData(
              visual: LessonVisual.engineering,
              title: 'Why do engineers use limits?',
              content: 'Sensors record measurements at separate instants, but we often want to estimate instantaneous behavior. Limits connect successive approximations to the ideal value used in velocity, deformation, flow, and control.',
              tone: LearningCardTone.information,
            ),
          ],
        ),
        LessonSectionData(
          number: '2',
          title: 'Read the notation as a sentence',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.notation,
              title: 'lim x→a f(x) = L',
              content: 'We read: “the limit of f(x), as x approaches a, is L.” The expression x→a tells us the point of approach; f(x) is the observed quantity; L is the predicted value of the outputs.',
              emphasis: 'x approaches a does not necessarily mean x = a.',
            ),
            WorkedExampleBlockData(
              title: 'A first approximation',
              problem: 'f(x) = 2x + 1, as x→3',
              steps: [
                'Use values close to 3: 2.9, 2.99, 3.01, 3.1.',
                'Calculate the outputs: 6.8, 6.98, 7.02, 7.2.',
                'Notice that as x gets closer to 3, f(x) gets closer to 7.',
              ],
              result: 'Conclusion: lim x→3 (2x + 1) = 7.',
              interpretation: 'The numerical table supports the prediction that the output approaches 7.',
            ),
          ],
        ),
      ],
      check: LessonCheckData(
        question: 'To study lim x→4 f(x), which information matters most?',
        choices: [
          'Only the exact value of f(4).',
          'The behavior of f(x) for values near 4.',
          'The number of terms in the expression.',
        ],
        correctIndex: 1,
        explanation: 'The limit is determined by behavior around the point; f(4) may even be undefined.',
      ),
      takeaways: [
        'A limit describes a trend in the outputs of a function.',
        'The value at the point and the limit are related but different concepts.',
        'The notation identifies the observed function, the point of approach, and the predicted value.',
      ],
      closing: 'In the next lesson, you will compare approaches from the left and from the right.',
    ),
    CourseLessonData(
      id: 'limites-02-laterais',
      topicId: 'limites',
      trailTitle: 'Limits • Unit 1',
      eyebrow: 'Lesson 2 of 8 • Two directions',
      title: 'One-sided limits, tables, and graphs',
      description: 'Investigate a point from both sides and recognize when a limit does not exist.',
      duration: '≈ 5 min',
      objective: 'calculate one-sided limits and compare their results',
      symbol: '→',
      sections: [
        LessonSectionData(
          number: '1',
          title: 'Approach from the left and the right',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.compare,
              title: 'Two independent approaches',
              content: 'The left-hand limit uses values smaller than a, written x→a⁻. The right-hand limit uses values larger than a, written x→a⁺. The two-sided limit exists only when both results are equal.',
              emphasis: 'lim x→a f(x) exists ⇔ both one-sided limits exist and are equal.',
            ),
            ConceptBlockData(
              visual: LessonVisual.graph,
              title: 'Read the graph without mixing up the points',
              content: 'Follow the curve as x approaches the point. An open circle may indicate the approached value; a filled point gives the actual function value. They do not need to be at the same height.',
              tone: LearningCardTone.information,
            ),
          ],
        ),
        LessonSectionData(
          number: '2',
          title: 'Recognize a jump',
          blocks: [
            WorkedExampleBlockData(
              title: 'Piecewise function',
              problem: 'f(x)=1 if x<0; and f(x)=3 if x≥0',
              steps: [
                'From the left of 0, all function values are 1.',
                'From the right of 0, all function values are 3.',
                'Compare the one-sided limits: 1 ≠ 3.',
              ],
              result: 'Conclusion: lim x→0 f(x) does not exist.',
              interpretation: 'The graph jumps from one height to another. The fact that f(0)=3 does not remove the mismatch between the sides.',
            ),
            ConceptBlockData(
              visual: LessonVisual.table,
              title: 'Use tables carefully',
              content: 'Choose values progressively closer to the point from both sides. Tables suggest behavior, but oscillatory phenomena may require algebraic or theoretical analysis.',
              emphasis: 'Do not conclude from only one value on the left and one on the right.',
              tone: LearningCardTone.warning,
            ),
          ],
        ),
      ],
      check: LessonCheckData(
        question: 'If lim x→2⁻ f(x)=5 and lim x→2⁺ f(x)=5, what can we conclude?',
        choices: [
          'The two-sided limit is 5.',
          'f(2) must be 5.',
          'The function is not defined at 2.',
        ],
        correctIndex: 0,
        explanation: 'Equal one-sided limits guarantee the two-sided limit. They do not determine f(2) by themselves.',
      ),
      takeaways: [
        'The symbol ⁻ means approach from the left and ⁺ from the right.',
        'A two-sided limit requires the two sides to agree.',
        'A filled point represents f(a); the nearby curve shows the approach.',
        'A jump creates different one-sided limits.',
      ],
      closing: 'Now that you can test whether a limit exists, we will use properties that make calculations faster.',
    ),
    CourseLessonData(
      id: 'limites-03-propriedades',
      topicId: 'limites',
      trailTitle: 'Limits • Unit 1',
      eyebrow: 'Lesson 3 of 8 • Rules',
      title: 'Limit properties and direct substitution',
      description: 'Learn when direct substitution works and how to combine known limits safely.',
      duration: '≈ 5 min',
      objective: 'use algebraic limit properties and recognize continuous functions',
      symbol: 'L',
      sections: [
        LessonSectionData(
          number: '1',
          title: 'Combine existing limits',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.calculate,
              title: 'Sum, product, and power',
              content: 'If lim f(x)=L and lim g(x)=M, then the limit of the sum is L+M, the product is L·M, and a positive integer power is Lⁿ. For a quotient, we also need M≠0.',
              emphasis: 'These properties can be used only when the required limits exist.',
            ),
            ConceptBlockData(
              visual: LessonVisual.idea,
              title: 'Direct substitution follows from continuity',
              content: 'Polynomials are continuous for every real number, so their limit at a is found by evaluating the function at a. Rational functions follow the same rule wherever the denominator is nonzero.',
              tone: LearningCardTone.success,
            ),
          ],
        ),
        LessonSectionData(
          number: '2',
          title: 'Organize larger expressions',
          blocks: [
            WorkedExampleBlockData(
              title: 'Applying the properties',
              problem: 'lim x→2 (3x² − 4x + 5)',
              steps: [
                'The expression is a polynomial, so it is continuous at x=2.',
                'Substitute x=2: 3·(2²) − 4·2 + 5.',
                'Evaluate in the correct order: 12 − 8 + 5.',
              ],
              result: 'Result: the limit is 9.',
              interpretation: 'The limit laws justify evaluating each polynomial term directly.',
            ),
            ConceptBlockData(
              visual: LessonVisual.warning,
              title: 'A zero denominator stops the shortcut',
              content: 'For a rational function, substitute first. If the denominator is nonzero, you are done. If 0/0 appears, the form is indeterminate; if a nonzero number is divided by zero, investigate one-sided limits or infinite behavior.',
              emphasis: 'Not every division by zero represents the same situation.',
              tone: LearningCardTone.warning,
            ),
          ],
        ),
      ],
      check: LessonCheckData(
        question: 'Which limit can be solved immediately by direct substitution?',
        choices: [
          'lim x→2 (x²−4)/(x−2)',
          'lim x→1 (x²+3x)/(x+2)',
          'lim x→0 1/x',
        ],
        correctIndex: 1,
        explanation: 'At x=1, the denominator x+2 is 3. The rational function is continuous there.',
      ),
      takeaways: [
        'Polynomials allow direct substitution at every real number.',
        'Rational functions allow direct substitution where the denominator is nonzero.',
        'Sum, product, and power preserve existing limits.',
        '0/0 is a signal to transform the expression.',
      ],
      closing: 'The next lesson focuses on 0/0 cases resolved through factoring.',
    ),
    CourseLessonData(
      id: 'limites-04-fatoracao',
      topicId: 'limites',
      trailTitle: 'Limits • Unit 2',
      eyebrow: 'Lesson 4 of 8 • Indeterminate form',
      title: 'Factoring reveals the hidden limit',
      description: 'Rewrite equivalent expressions to remove factors responsible for the 0/0 form.',
      duration: '≈ 5 min',
      objective: 'solve indeterminate limits using common factors and special products',
      symbol: '0/0',
      sections: [
        LessonSectionData(
          number: '1',
          title: 'Interpret 0/0 correctly',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.warning,
              title: 'Indeterminate is not an answer',
              content: 'When numerator and denominator both approach zero, different functions can have completely different limits. So 0/0 only tells us that the current form does not reveal the behavior.',
              emphasis: 'Never conclude “the limit is zero” just because you found 0/0.',
              tone: LearningCardTone.warning,
            ),
            ConceptBlockData(
              visual: LessonVisual.transform,
              title: 'Look for a common factor',
              content: 'Special products often create the same factor in numerator and denominator. After factoring, simplify that factor for x different from the target point. This is valid because a limit studies nearby values, not exact substitution.',
            ),
          ],
        ),
        LessonSectionData(
          number: '2',
          title: 'Solve and justify each step',
          blocks: [
            WorkedExampleBlockData(
              title: 'Difference of squares',
              problem: 'lim x→2 (x² − 4)/(x − 2)',
              steps: [
                'Substitute x=2 and identify the 0/0 form.',
                'Factor x²−4 as (x−2)(x+2).',
                'For x≠2, simplify the factor x−2.',
                'Evaluate lim x→2 (x+2) by substitution.',
              ],
              result: 'Result: 4.',
              interpretation: 'The simplified expression has the same behavior at every point near 2.',
            ),
            WorkedExampleBlockData(
              title: 'Factorable trinomial',
              problem: 'lim x→3 (x² − 5x + 6)/(x − 3)',
              steps: [
                'Factor the numerator: x²−5x+6=(x−2)(x−3).',
                'Simplify x−3 for x≠3.',
                'Evaluate x−2 as x→3.',
              ],
              result: 'Result: 1.',
              interpretation: 'Recognizing the trinomial roots turns an indeterminate fraction into a linear function.',
            ),
          ],
        ),
        LessonSectionData(
          number: '3',
          title: 'Do not cancel terms',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.warning,
              title: 'Cancellation requires factors',
              content: 'You can cancel only quantities that multiply the entire numerator and denominator. Terms separated by addition or subtraction are not factors.',
              emphasis: 'Factor first; simplify second.',
              tone: LearningCardTone.warning,
            ),
          ],
        ),
      ],
      check: LessonCheckData(
        question: 'After factoring (x²−9)/(x−3), which expression describes the behavior for x≠3?',
        choices: ['x−3', 'x+3', '1'],
        correctIndex: 1,
        explanation: 'x²−9=(x−3)(x+3). Simplifying the factor x−3 leaves x+3.',
      ),
      takeaways: [
        '0/0 indicates an indeterminate form, not a result.',
        'Difference of squares: a²−b²=(a−b)(a+b).',
        'Trinomials may reveal the factor that makes the denominator zero.',
        'Cancellation happens only between factors.',
      ],
      closing: 'Not every indeterminate form is polynomial. Next, we will use conjugates with radicals.',
    ),
    CourseLessonData(
      id: 'limites-05-racionalizacao',
      topicId: 'limites',
      trailTitle: 'Limits • Unit 2',
      eyebrow: 'Lesson 5 of 8 • Radicals',
      title: 'Rationalization with conjugates',
      description: 'Remove indeterminate forms involving radicals without changing the expression’s value.',
      duration: '≈ 5 min',
      objective: 'identify conjugates and rationalize numerators or denominators',
      symbol: '√',
      sections: [
        LessonSectionData(
          number: '1',
          title: 'Use the difference of squares',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.transform,
              title: 'The conjugate changes the sign',
              content: 'The conjugate of √A−√B is √A+√B. Multiplying them gives (√A−√B)(√A+√B)=A−B, removing the radicals from that part of the expression.',
              emphasis: 'Multiply numerator and denominator by the same conjugate to preserve equivalence.',
            ),
            ConceptBlockData(
              visual: LessonVisual.warning,
              title: 'Rationalize the side causing the indeterminate form',
              content: 'Sometimes the radical is in the numerator; other times it is in the denominator. Identify where subtraction of radicals produces zero and use the corresponding conjugate.',
              tone: LearningCardTone.information,
            ),
          ],
        ),
        LessonSectionData(
          number: '2',
          title: 'Follow the simplification',
          blocks: [
            WorkedExampleBlockData(
              title: 'Radical in the numerator',
              problem: 'lim x→0 (√(x+4) − 2)/x',
              steps: [
                'Substitution gives (2−2)/0=0/0.',
                'Multiply by (√(x+4)+2)/(√(x+4)+2).',
                'In the numerator, use the difference of squares: (x+4)−4=x.',
                'Simplify x and evaluate 1/(√(x+4)+2) at x=0.',
              ],
              result: 'Result: 1/4.',
              interpretation: 'The conjugate reveals an equivalent expression that is continuous near zero.',
            ),
          ],
        ),
      ],
      check: LessonCheckData(
        question: 'What is the conjugate of √(x+1) − 3?',
        choices: ['√(x+1) + 3', '−√(x+1) + 3', '√(x−1) + 3'],
        correctIndex: 0,
        explanation: 'Keep both terms and change only the sign between them.',
      ),
      takeaways: [
        'Conjugates turn products into differences of squares.',
        'Multiply the fraction by a ratio equal to 1.',
        'Simplify only after expanding the product.',
        'At the end, return to direct substitution.',
      ],
      closing: 'The final major technique examines behavior as x grows without bound.',
    ),
    CourseLessonData(
      id: 'limites-06-infinito',
      topicId: 'limites',
      trailTitle: 'Limits • Unit 3',
      eyebrow: 'Lesson 6 of 8 • Long-term behavior',
      title: 'Limits at infinity and asymptotes',
      description: 'Compare dominant terms to predict the behavior of rational functions.',
      duration: '≈ 5 min',
      objective: 'calculate limits at infinity and interpret horizontal asymptotes',
      symbol: '∞',
      sections: [
        LessonSectionData(
          number: '1',
          title: 'Identify what dominates',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.infinity,
              title: 'Highest-degree terms control growth',
              content: 'When |x| becomes very large, x² dominates x and constants; x³ dominates x². For rational functions, compare the highest degrees of numerator and denominator.',
              emphasis: 'Dividing every term by the highest power in the denominator makes the comparison explicit.',
            ),
            ConceptBlockData(
              visual: LessonVisual.graph,
              title: 'Three fundamental cases',
              content: 'If the numerator degree is smaller, the limit is 0. If the degrees are equal, the limit is the ratio of leading coefficients. If the numerator degree is larger, the function does not approach a finite value.',
              tone: LearningCardTone.information,
            ),
          ],
        ),
        LessonSectionData(
          number: '2',
          title: 'Calculate without huge numbers',
          blocks: [
            WorkedExampleBlockData(
              title: 'Equal degrees',
              problem: 'lim x→∞ (3x² − x + 4)/(2x² + 5)',
              steps: [
                'The highest degree in the denominator is 2. Divide every term by x².',
                'Obtain (3 − 1/x + 4/x²)/(2 + 5/x²).',
                'As x→∞, 1/x and 1/x² approach zero.',
                'The ratio 3/2 remains.',
              ],
              result: 'Result: 3/2.',
              interpretation: 'The line y=3/2 is a horizontal asymptote: the graph approaches it in the long run.',
            ),
            ConceptBlockData(
              visual: LessonVisual.engineering,
              title: 'Steady-state interpretation',
              content: 'In control and circuit models, a limit at infinity can represent the stabilized value of a response over time. The asymptote describes that steady state.',
              tone: LearningCardTone.success,
            ),
          ],
        ),
      ],
      check: LessonCheckData(
        question: 'What is lim x→∞ (5x+1)/(x²+2)?',
        choices: ['0', '5', '∞'],
        correctIndex: 0,
        explanation: 'The denominator has degree 2 and grows faster than the degree-1 numerator.',
      ),
      takeaways: [
        'Compare degrees before doing algebra.',
        'A lower degree in the numerator gives limit zero.',
        'Equal degrees give the ratio of leading coefficients.',
        'Finite limits at infinity indicate horizontal asymptotes.',
      ],
      closing: 'In the next lesson, you will study the fundamental trigonometric limits.',
    ),
    CourseLessonData(
      id: 'limites-07-trigonometricos',
      topicId: 'limites',
      trailTitle: 'Limits • Unit 3',
      eyebrow: 'Lesson 7 of 8 • Trigonometry',
      title: 'Fundamental trigonometric limits',
      description: 'Understand why sin(x)/x approaches 1 and learn how to adapt this pattern.',
      duration: '≈ 5 min',
      objective: 'recognize and apply trigonometric limits in radians',
      symbol: 'sin',
      sections: [
        LessonSectionData(
          number: '1',
          title: 'Angular units matter',
          subtitle: 'The fundamental limit requires angles measured in radians.',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.idea,
              title: 'The sin(u)/u pattern',
              content: 'As u approaches zero in radians, sin(u) and u become increasingly close. Therefore, the ratio sin(u)/u approaches 1 even though direct substitution gives 0/0.',
              emphasis: 'lim u→0 sin(u)/u = 1 only in the compatible form and with u measured in radians.',
            ),
            ConceptBlockData(
              visual: LessonVisual.graph,
              title: 'Why does the result make sense?',
              content: 'Near zero, the graph of y=sin(x) nearly coincides with the line y=x. This geometric approximation explains why the ratio of the two expressions approaches 1.',
              tone: LearningCardTone.information,
            ),
          ],
        ),
        LessonSectionData(
          number: '2',
          title: 'Build the fundamental form',
          blocks: [
            WorkedExampleBlockData(
              title: 'Adjusting the argument',
              problem: 'lim x→0 sin(3x)/x',
              steps: [
                'The sine argument is 3x, but the denominator is x.',
                'Multiply and divide by 3: sin(3x)/x = 3·sin(3x)/(3x).',
                'Let u=3x. As x→0, u→0 as well.',
                'Use lim u→0 sin(u)/u = 1.',
              ],
              result: 'Result: 3·1 = 3.',
              interpretation: 'The coefficient used to match the denominator remains outside the limit.',
            ),
            WorkedExampleBlockData(
              title: 'Cosine and conjugate',
              problem: 'lim x→0 (1−cos x)/x',
              steps: [
                'Substitution gives 0/0. Multiply by the conjugate 1+cos x.',
                'Use (1−cos x)(1+cos x)=1−cos²x=sin²x.',
                'Rewrite as [sin(x)/x]·[sin(x)/(1+cos x)].',
                'The first factor approaches 1 and the second approaches 0/2=0.',
              ],
              result: 'Result: 0.',
              interpretation: 'Trigonometric identities can reveal the hidden fundamental limit.',
            ),
          ],
        ),
      ],
      check: LessonCheckData(
        question: 'What is lim x→0 sin(5x)/x?',
        choices: ['1', '5', '0'],
        correctIndex: 1,
        explanation: 'Write sin(5x)/x = 5·sin(5x)/(5x). The fundamental ratio approaches 1.',
      ),
      takeaways: [
        'The fundamental limit uses angles in radians.',
        'Try to build a ratio of the form sin(u)/u.',
        'Any denominator adjustment must be compensated outside the ratio.',
        'Identities and conjugates help with cosine expressions.',
      ],
      closing: 'The final lesson combines algebraic techniques, one-sided limits, infinity, and trigonometry.',
    ),
    CourseLessonData(
      id: 'limites-08-sintese',
      topicId: 'limites',
      trailTitle: 'Limits • Unit 3',
      eyebrow: 'Lesson 8 of 8 • Synthesis',
      title: 'How to choose the right technique',
      description: 'Organize the module ideas into a reliable analysis method.',
      duration: '≈ 5 min',
      objective: 'diagnose a limit and justify the chosen technique',
      symbol: '?',
      sections: [
        LessonSectionData(
          number: '1',
          title: 'Follow a diagnostic sequence',
          blocks: [
            ConceptBlockData(
              visual: LessonVisual.checklist,
              title: 'A five-question roadmap',
              content: '1) Is it one-sided or two-sided? 2) Does direct substitution work? 3) Did 0/0 appear? 4) Are there polynomials to factor, radicals to rationalize, or a fundamental trigonometric form? 5) Does x approach infinity, requiring degree comparison?',
              emphasis: 'Choose the technique from the structure you find, not by random trial.',
            ),
            ConceptBlockData(
              visual: LessonVisual.warning,
              title: 'Review the meaning of the result',
              content: 'After calculating, ask whether the value agrees with the table, graph, or expected growth. An algebraic result without interpretation is harder to verify.',
              tone: LearningCardTone.warning,
            ),
          ],
        ),
        LessonSectionData(
          number: '2',
          title: 'Combine techniques when necessary',
          blocks: [
            WorkedExampleBlockData(
              title: 'Complete diagnosis',
              problem: 'lim x→1 (x²−1)/(√(x+3)−2)',
              steps: [
                'Substitution gives 0/0; the numerator can be factored and the denominator contains a radical.',
                'Factor x²−1=(x−1)(x+1).',
                'Rationalize the denominator using √(x+3)+2.',
                'The difference of squares turns the denominator into x−1.',
                'Simplify x−1 and substitute x=1 into the remaining expression.',
              ],
              result: 'Result: (1+1)(√4+2)=2·4=8.',
              interpretation: 'The problem requires recognizing two structures and combining them in the correct order.',
            ),
            ConceptBlockData(
              visual: LessonVisual.engineering,
              title: 'Limits as a modeling tool',
              content: 'In Engineering, limits evaluate stability, tolerances, numerical approximations, and model behavior near critical points. Algebra is the method; predicting the phenomenon is the goal.',
              tone: LearningCardTone.success,
            ),
          ],
        ),
      ],
      check: LessonCheckData(
        question: 'A substitution gives 0/0 and the numerator is x²−a². Which first transformation is most promising?',
        choices: [
          'Factor as (x−a)(x+a).',
          'Declare that the limit is zero.',
          'Compare only the degrees.',
        ],
        correctIndex: 0,
        explanation: 'The difference of squares may reveal the factor responsible for the indeterminate form.',
      ),
      takeaways: [
        'Always begin by identifying the type of approach and trying direct substitution.',
        'Use factoring for polynomial structures and conjugates for radicals.',
        'At infinity, compare dominant terms.',
        'Interpret the result algebraically, graphically, or physically.',
      ],
      closing: 'You completed the essential theory of Limits. Practice will now consolidate the decision process.',
    ),
  ];
}
