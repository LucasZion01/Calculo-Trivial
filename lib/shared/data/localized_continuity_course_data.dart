import 'package:calcquest/shared/domain/course_lesson_data.dart';

const List<CourseLessonData> englishContinuityCourseLessons = [
  CourseLessonData(
    id: 'continuidade-01-significado',
    topicId: 'continuidade',
    trailTitle: 'Continuity • Unit 1',
    eyebrow: 'Lesson 1 of 7 • Core idea',
    title: 'When is a function continuous?',
    description:
        'Connect the function value, the limit, and the graph behavior at a point.',
    duration: '≈ 5 min',
    objective: 'check the three conditions for continuity at a point',
    symbol: 'C',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Think of no break in the graph',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'A path without interruption',
            content:
                'A function is continuous at x=a when the value predicted by approaching a matches the value actually assigned to the function at that point. On the graph, there is no hole, jump, or blow-up to infinity at a.',
            emphasis:
                'The idea of “drawing without lifting the pencil” helps, but the mathematical definition is more precise.',
          ),
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'The three conditions',
            content:
                '1) f(a) must exist. 2) lim x→a f(x) must exist. 3) The limit must equal f(a). If even one condition fails, the function is not continuous at a.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Apply the definition in the right order',
        blocks: [
          WorkedExampleBlockData(
            title: 'Complete check',
            problem: 'f(x)=x²+1. Is the function continuous at x=2?',
            steps: [
              'Calculate f(2)=2²+1=5.',
              'Because polynomials allow direct substitution, lim x→2 (x²+1)=5.',
              'Compare: the limit exists and equals f(2).',
            ],
            result: 'f is continuous at x=2.',
            interpretation:
                'The function value, left-hand tendency, and right-hand tendency all meet at 5.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'If lim x→a f(x)=4, but f(a)=7, is the function continuous at a?',
      choices: ['Yes', 'No', 'Only from the right'],
      correctIndex: 1,
      explanation:
          'The third condition fails: the limit must match the function value.',
    ),
    takeaways: [
      'Continuity is a property analyzed at a point or on an interval.',
      'The function value and the limit must both exist.',
      'The equality lim x→a f(x)=f(a) completes the check.',
    ],
    closing:
        'In the next lesson, you will recognize continuous families without repeating the full definition.',
  ),
  CourseLessonData(
    id: 'continuidade-02-dominio',
    topicId: 'continuidade',
    trailTitle: 'Continuity • Unit 1',
    eyebrow: 'Lesson 2 of 7 • Families and domain',
    title: 'Continuity on the domain',
    description:
        'Use properties of polynomials, rational functions, roots, and trigonometric functions.',
    duration: '≈ 5 min',
    objective: 'determine intervals of continuity from the domain',
    symbol: 'D',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Recognize familiar functions',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Continuous families',
            content:
                'Polynomials, sine, cosine, and exponential functions are continuous for all real numbers. Rational functions are continuous where the denominator is nonzero. Even-index roots are continuous where the radicand is nonnegative.',
            emphasis:
                'Saying “continuous on its domain” does not include points where the expression is not defined at all.',
          ),
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Operations preserve continuity',
            content:
                'Sums, products, and compositions of continuous functions remain continuous where the operations are defined. Quotients do as well, provided the denominator is nonzero.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Find the intervals',
        blocks: [
          WorkedExampleBlockData(
            title: 'A rational function',
            problem: 'f(x)=(x+1)/(x−2)',
            steps: [
              'The numerator and denominator are polynomials.',
              'Find where the denominator is zero: x−2=0, so x=2.',
              'Exclude that point and split the domain into intervals.',
            ],
            result: 'f is continuous on (−∞,2) and (2,+∞).',
            interpretation:
                'The expression has a break at x=2 because the division is undefined there.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question: 'Where is √(x−3) continuous over the real numbers?',
      choices: ['[3,+∞)', 'All ℝ', '(−∞,3]'],
      correctIndex: 0,
      explanation:
          'The square root requires x−3≥0. The function is continuous throughout the resulting domain.',
    ),
    takeaways: [
      'Start by finding the domain of the expression.',
      'Rational functions exclude zeros of the denominator.',
      'Operations and compositions preserve continuity where defined.',
    ],
    closing:
        'Now you will classify what happens at points where continuity fails.',
  ),
  CourseLessonData(
    id: 'continuidade-03-descontinuidades',
    topicId: 'continuidade',
    trailTitle: 'Continuity • Unit 2',
    eyebrow: 'Lesson 3 of 7 • Classification',
    title: 'Holes, jumps, and asymptotes',
    description:
        'Distinguish removable, jump, and infinite discontinuities.',
    duration: '≈ 5 min',
    objective: 'classify a discontinuity from the behavior of its limits',
    symbol: '!',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Observe how the approach fails',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.warning,
            title: 'Three main types',
            content:
                'Removable: the limit exists and is finite, but the value is missing or different. Jump: the one-sided limits are finite and different. Infinite: the magnitude of the function grows without bound near the point.',
            emphasis:
                'The classification depends on the limits, not only on the appearance of the graph.',
            tone: LearningCardTone.warning,
          ),
          ConceptBlockData(
            visual: LessonVisual.graph,
            title: 'The greatest-integer function',
            content:
                'At every integer, the function ⌊x⌋ changes level abruptly. The value approached from the left differs from the value approached from the right, producing jumps.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Classify with evidence',
        blocks: [
          WorkedExampleBlockData(
            title: 'Vertical asymptote',
            problem: 'f(x)=1/(x−2), near x=2',
            steps: [
              'From the right, x−2 is positive and very small: f(x)→+∞.',
              'From the left, x−2 is negative and very small: f(x)→−∞.',
              'The values grow without bound in magnitude.',
            ],
            result: 'There is an infinite discontinuity at x=2.',
            interpretation: 'The line x=2 acts as a vertical asymptote.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'The limit at a exists and equals 3, but f(a) does not exist. What type is it?',
      choices: ['Removable', 'Jump', 'Infinite'],
      correctIndex: 0,
      explanation:
          'Defining f(a)=3 is enough to restore continuity at that point.',
    ),
    takeaways: [
      'Holes correspond to removable discontinuities.',
      'Different one-sided limits characterize jumps.',
      'Unbounded growth near the point indicates an infinite discontinuity.',
    ],
    closing:
        'In the next lesson, one-sided limits will be used with piecewise-defined functions.',
  ),
  CourseLessonData(
    id: 'continuidade-04-partes',
    topicId: 'continuidade',
    trailTitle: 'Continuity • Unit 2',
    eyebrow: 'Lesson 4 of 7 • Piecewise functions',
    title: 'Where two rules meet',
    description:
        'Check continuity at switching points and at interval endpoints.',
    duration: '≈ 5 min',
    objective: 'compare one-sided limits in piecewise-defined functions',
    symbol: '{',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Each side uses its own rule',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.compare,
            title: 'The switching point',
            content:
                'For x<a, use the first expression when calculating the left-hand limit. For x>a, use the second expression for the right-hand limit. Then check which rule includes the equality sign and determines f(a).',
            emphasis:
                'All three quantities must agree: left-hand limit, right-hand limit, and the value at the point.',
          ),
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'Endpoints of an interval',
            content:
                'At the left endpoint of [a,b], it only makes sense to approach through values in the domain, that is, from the right. At the right endpoint, use the left-hand limit.',
            tone: LearningCardTone.information,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Make the rules meet',
        blocks: [
          WorkedExampleBlockData(
            title: 'Two expressions',
            problem: 'f(x)=x+1 if x<1; f(x)=2x if x≥1',
            steps: [
              'From the left, x+1 approaches 2.',
              'From the right, 2x approaches 2.',
              'Because the second rule includes x=1, f(1)=2.',
            ],
            result: 'The function is continuous at x=1.',
            interpretation:
                'The two pieces meet at the same point without creating a jump.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'On [0,4], which side is used to check continuity at the endpoint x=4?',
      choices: ['Left', 'Right', 'Both are always required'],
      correctIndex: 0,
      explanation:
          'We approach 4 using smaller values that belong to the interval.',
    ),
    takeaways: [
      'Use the rule corresponding to each side of the switching point.',
      'Check the value defined at the point separately.',
      'At domain endpoints, use one-sided continuity.',
    ],
    closing:
        'The next lesson turns continuity into an equation for finding parameters.',
  ),
  CourseLessonData(
    id: 'continuidade-05-parametros',
    topicId: 'continuidade',
    trailTitle: 'Continuity • Unit 3',
    eyebrow: 'Lesson 5 of 7 • Repair',
    title: 'Choose values that remove breaks',
    description:
        'Determine parameters and redefine points to make functions continuous.',
    duration: '≈ 5 min',
    objective: 'set up and solve continuity conditions involving parameters',
    symbol: 'k',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Turn the definition into an equation',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.transform,
            title: 'Repair a removable discontinuity',
            content:
                'If the limit at a exists and equals L, defining f(a)=L fills the hole. For piecewise functions, set the one-sided expressions equal at the switching point and solve the resulting equation for the parameter.',
            emphasis:
                'Only removable discontinuities can be repaired by changing a single function value.',
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Solve for the parameter',
        blocks: [
          WorkedExampleBlockData(
            title: 'Matching two pieces',
            problem: 'f(x)=2x+1 if x<1; f(x)=x+k if x≥1',
            steps: [
              'The left-hand limit at 1 is 2(1)+1=3.',
              'The right-hand limit and f(1) are 1+k.',
              'Impose continuity: 1+k=3.',
              'Solve the equation: k=2.',
            ],
            result: 'k=2 makes the function continuous.',
            interpretation:
                'The parameter shifts the second piece until it meets the first.',
          ),
          WorkedExampleBlockData(
            title: 'Filling a hole',
            problem: 'f(x)=(x²−1)/(x−1), x≠1. Define f(1).',
            steps: [
              'Factor x²−1=(x−1)(x+1).',
              'Near 1, simplify to x+1.',
              'Calculate the limit: 1+1=2.',
            ],
            result: 'Define f(1)=2.',
            interpretation:
                'The new definition changes only the missing point and preserves the rest of the function.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'If lim x→3 f(x)=8, what value should be assigned to f(3) to guarantee continuity?',
      choices: ['3', '8', '0'],
      correctIndex: 1,
      explanation:
          'Continuity requires the value at the point to equal the limit.',
    ),
    takeaways: [
      'First calculate the value required by the approaching behavior.',
      'Set one-sided limits equal to adjust piecewise functions.',
      'Redefining one point repairs only removable discontinuities.',
    ],
    closing:
        'In the next lesson, continuity will guarantee the existence of values between two measurements.',
  ),
  CourseLessonData(
    id: 'continuidade-06-valor-intermediario',
    topicId: 'continuidade',
    trailTitle: 'Continuity • Unit 3',
    eyebrow: 'Lesson 6 of 7 • Existence',
    title: 'Intermediate Value Theorem',
    description:
        'Use continuity to guarantee values and locate roots on intervals.',
    duration: '≈ 5 min',
    objective: 'apply the Intermediate Value Theorem correctly',
    symbol: '∃',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'A continuous function does not skip values',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.route,
            title: 'What the theorem guarantees',
            content:
                'If f is continuous on [a,b], then it takes every value N between f(a) and f(b). There is at least one c in [a,b] such that f(c)=N.',
            emphasis:
                'The theorem guarantees existence, but does not necessarily tell us where the point is or whether it is unique.',
          ),
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Detecting a sign change',
            content:
                'If a continuous system response changes from negative to positive, it crosses zero at some instant. Numerical methods use this guarantee to locate roots and equilibrium points.',
            tone: LearningCardTone.success,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Check the hypotheses',
        blocks: [
          WorkedExampleBlockData(
            title: 'Existence of a root',
            problem: 'f continuous on [1,2], f(1)=−3 and f(2)=4',
            steps: [
              'Confirm continuity on the entire closed interval.',
              'Notice that 0 lies between −3 and 4.',
              'Apply the Intermediate Value Theorem.',
            ],
            result: 'There is at least one c in (1,2) with f(c)=0.',
            interpretation:
                'We cannot claim that c=1.5 or that there is only one root.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'Does the IVT guarantee exactly one root when there is a sign change?',
      choices: ['Yes', 'No, it guarantees at least one', 'Only for polynomials'],
      correctIndex: 1,
      explanation:
          'The function may cross the axis several times; the theorem guarantees existence, not uniqueness.',
    ),
    takeaways: [
      'Continuity must hold on the whole closed interval.',
      'Every value between f(a) and f(b) is attained.',
      'A sign change guarantees at least one root.',
      'The theorem does not provide an exact location or uniqueness.',
    ],
    closing:
        'The final lesson will combine the definition, domain, classification, and applications.',
  ),
  CourseLessonData(
    id: 'continuidade-07-sintese',
    topicId: 'continuidade',
    trailTitle: 'Continuity • Unit 3',
    eyebrow: 'Lesson 7 of 7 • Synthesis',
    title: 'A roadmap for analyzing continuity',
    description:
        'Choose a reliable strategy for points, intervals, and piecewise functions.',
    duration: '≈ 5 min',
    objective: 'diagnose and justify continuity problems',
    symbol: '✓',
    sections: [
      LessonSectionData(
        number: '1',
        title: 'Start with the type of problem',
        blocks: [
          ConceptBlockData(
            visual: LessonVisual.checklist,
            title: 'Decision roadmap',
            content:
                '1) Find the domain. 2) If it is a familiar family, identify its continuous intervals. 3) At a special point, check the value and one-sided limits. 4) Classify the failure. 5) If there is a parameter, turn equality of the limits into an equation.',
            emphasis:
                'Write the justification: answering only “yes” or “no” is not enough.',
          ),
          ConceptBlockData(
            visual: LessonVisual.engineering,
            title: 'Continuity in real models',
            content:
                'Continuous models represent quantities that vary without instantaneous jumps, such as idealized position, temperature, and deformation. Jumps may represent commands, impacts, or regime changes and must be handled deliberately.',
            tone: LearningCardTone.success,
          ),
        ],
      ),
      LessonSectionData(
        number: '2',
        title: 'Run a final check',
        blocks: [
          WorkedExampleBlockData(
            title: 'Diagnosis at a point',
            problem: 'lim x→a f(x)=5 and f(a)=5',
            steps: [
              'The value f(a) exists.',
              'The two-sided limit exists and is finite.',
              'The limit matches the function value.',
            ],
            result: 'f is continuous at a.',
            interpretation:
                'The conclusion follows explicitly from the three conditions, not from a visual assumption.',
          ),
        ],
      ),
    ],
    check: LessonCheckData(
      question:
          'What is the first check when looking for intervals of continuity?',
      choices: ['The domain', 'The derivative', 'The largest coefficient'],
      correctIndex: 0,
      explanation:
          'A function can only be continuous at points where it is defined.',
    ),
    takeaways: [
      'The domain and function family guide the global analysis.',
      'At special points, apply the three conditions.',
      'One-sided limits classify jumps and infinite breaks.',
      'Continuity allows us to guarantee intermediate values.',
    ],
    closing:
        'You completed the essential theory of Continuity. Now consolidate each decision through practice.',
  ),
];
