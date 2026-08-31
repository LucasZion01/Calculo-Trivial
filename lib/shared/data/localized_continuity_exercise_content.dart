import 'package:flutter/widgets.dart';

import 'mock_exercise_data.dart';

class _ExerciseTranslation {
  final String statement;
  final String explanation;
  final String? skill;
  final Map<String, String> options;

  const _ExerciseTranslation({
    required this.statement,
    required this.explanation,
    this.skill,
    this.options = const <String, String>{},
  });
}

ExerciseData localizeContinuityExerciseContent(
  ExerciseData exercise,
  Locale locale,
) {
  if (locale.languageCode != 'en') return exercise;

  final translation = _englishContinuityExercises[exercise.id];
  if (translation == null) return exercise;

  return ExerciseData(
    id: exercise.id,
    title: exercise.title.replaceFirst('Questão', 'Question'),
    statement: translation.statement,
    options: exercise.options
        .map(
          (option) => ExerciseOptionData(
            id: option.id,
            text: translation.options[option.id] ?? option.text,
          ),
        )
        .toList(growable: false),
    correctOptionId: exercise.correctOptionId,
    explanation: translation.explanation,
    contentLessonId: exercise.contentLessonId,
    skill: translation.skill ?? exercise.skill,
    difficulty: exercise.difficulty,
  );
}

const Map<String, _ExerciseTranslation> _englishContinuityExercises = {
  'continuidade-tres-condicoes': _ExerciseTranslation(
    statement: 'For a function f to be continuous at x = a, which conditions must be satisfied?',
    explanation: 'Check in order: f(a) must be defined; the two-sided limit lim x→a f(x) must exist; finally, the limit must equal the actual function value, lim x→a f(x)=f(a). If any condition fails, f is discontinuous at a.',
    skill: 'Three conditions for continuity',
    options: {
      'a': 'Only f(a) must exist',
      'b': 'Only the limit must exist',
      'c': 'f(a) exists, the limit exists, and lim x → a f(x) = f(a)',
      'd': 'The derivative of f must be zero',
    },
  ),
  'continuidade-polinomial': _ExerciseTranslation(
    statement: 'For which real numbers is f(x) = 3x² - 2x + 5 continuous?',
    explanation: 'Polynomials are built from sums and products of nonnegative integer powers of x, operations that preserve continuity. There are no denominators or roots restricting the domain, so f is continuous for every real number.',
    skill: 'Families of continuous functions',
    options: {
      'a': 'For all real numbers',
      'b': 'Only for x > 0',
      'c': 'Only for x ≠ 0',
      'd': 'Only for integers',
    },
  ),
  'continuidade-racional-dominio': _ExerciseTranslation(
    statement: 'Where is f(x) = (x + 1) / (x - 2) not continuous?',
    explanation: 'A rational function is continuous at every point in its domain. Solving x−2=0 gives x=2; division is undefined there. Therefore, the intervals of continuity are (−∞,2) and (2,+∞).',
    skill: 'Domain of a rational function',
    options: {
      'd': 'It is continuous on all ℝ',
    },
  ),
  'continuidade-furo-corrigido': _ExerciseTranslation(
    statement: 'Let f(x) = (x² - 1)/(x - 1) for x ≠ 1, and f(1) = 2. Is f continuous at x = 1?',
    explanation: 'Factor x²−1=(x−1)(x+1). For x near 1 and different from 1, the expression equals x+1, whose limit is 2. Since f(1) is defined as 2, the value and the limit agree, so all three conditions are satisfied.',
    skill: 'Repairing a removable discontinuity',
    options: {
      'a': 'Yes, because the limit and f(1) are both 2',
      'b': 'No, because the limit is 0',
      'c': 'No, because f(1) does not exist',
      'd': 'Yes, because every rational function is continuous',
    },
  ),
  'continuidade-furo-nao-corrigido': _ExerciseTranslation(
    statement: 'Let f(x) = (x² - 1)/(x - 1) for x ≠ 1, and f(1) = 3. What type of discontinuity occurs at x = 1?',
    explanation: 'The simplified expression x+1 shows that the limit at 1 exists and equals 2. However, f(1)=3. Since only the value at the point prevents equality, the discontinuity is removable: redefining f(1)=2 would fix it.',
    skill: 'Classifying a removable hole',
    options: {
      'a': 'None; the function is continuous',
      'b': 'Infinite discontinuity',
      'c': 'Jump discontinuity',
      'd': 'Removable discontinuity',
    },
  ),
  'continuidade-partes-simples': _ExerciseTranslation(
    statement: 'If f(x) = x + 1 for x < 1 and f(x) = 2x for x ≥ 1, is f continuous at x = 1?',
    explanation: 'Use x+1 from the left: the limit is 2. Use 2x from the right: the limit is also 2. The second rule includes x=1, so f(1)=2. Since the left limit, right limit, and function value agree, f is continuous.',
    skill: 'Matching pieces of a piecewise function',
    options: {
      'a': 'No, because the one-sided limits do not exist',
      'b': 'Yes, because both one-sided limits and f(1) equal 2',
      'c': 'No, because f(1) = 1',
      'd': 'Yes, because f(1) = 0',
    },
  ),
  'continuidade-salto': _ExerciseTranslation(
    statement: 'If f(x) = -1 for x < 0 and f(x) = 1 for x ≥ 0, what happens at x = 0?',
    explanation: 'Approaching zero from the left, the function stays at −1. From the right, it stays at 1. Since the one-sided limits are finite but different, the two-sided limit does not exist and the discontinuity is a jump.',
    skill: 'Jump discontinuity',
    options: {
      'a': 'The function is continuous',
      'b': 'There is a removable discontinuity',
      'c': 'There is a jump discontinuity',
      'd': 'There is an infinite discontinuity',
    },
  ),
  'continuidade-infinita': _ExerciseTranslation(
    statement: 'What type of discontinuity does f(x) = 1/(x - 2) have at x = 2?',
    explanation: 'Near x = 2, the magnitude of the function values grows without bound. There is a vertical asymptote, so the discontinuity is infinite.',
    skill: 'Infinite discontinuity',
    options: {'a': 'Infinite', 'b': 'Removable', 'c': 'Finite jump', 'd': 'None'},
  ),
  'continuidade-modulo': _ExerciseTranslation(
    statement: 'Is f(x) = |x| continuous at x = 0?',
    explanation: 'A corner in the graph does not imply discontinuity. From the left, |x|=−x and the limit is 0; from the right, |x|=x and the limit is also 0. Since f(0)=0, all three conditions are satisfied.',
    skill: 'Continuity at a corner point',
    options: {
      'a': 'No, because there is a corner in the graph',
      'b': 'No, because the limit equals 1',
      'c': 'Only from the right',
      'd': 'Yes',
    },
  ),
  'continuidade-parte-inteira': _ExerciseTranslation(
    statement: 'What behavior does the floor function f(x) = ⌊x⌋ have at integer values?',
    explanation: 'When crossing an integer n, values from the left remain at n−1, while values from the right and at the point equal n. The one-sided limits are finite but different, which gives a jump discontinuity.',
    skill: 'Jumps of the floor function',
    options: {
      'a': 'It is continuous at all integers',
      'b': 'It has jump discontinuities',
      'c': 'It has only removable holes',
      'd': 'It always tends to infinity',
    },
  ),
  'continuidade-seno': _ExerciseTranslation(
    statement: 'On which set is f(x) = sin(x) continuous?',
    explanation: 'The sine function is defined and continuous for every real number. Restricting it to [0,2π] would confuse one period with its domain, which is ℝ.',
    skill: 'Continuity of a trigonometric function',
    options: {
      'a': 'Only on [0, 2π]',
      'b': 'Only for x ≠ 0',
      'c': 'On all ℝ',
      'd': 'Only at multiples of π',
    },
  ),
  'continuidade-raiz': _ExerciseTranslation(
    statement: 'On its real domain, where is f(x) = √x continuous?',
    explanation: 'Over the real numbers, √x requires x≥0. The function is continuous on its entire domain; at x=0, continuity is checked from the right because negative values are outside the domain.',
    skill: 'Continuity on the square-root domain',
    options: {
      'c': 'ℝ except 0',
      'd': 'Only at x = 0',
    },
  ),
  'continuidade-composicao': _ExerciseTranslation(
    statement: 'If g is continuous at a and f is continuous at g(a), what can we say about f(g(x)) at a?',
    explanation: 'Because g(x) approaches g(a) as x→a and f is continuous at g(a), the limit passes through the outer function. Thus lim x→a f(g(x))=f(g(a)), exactly the continuity condition for the composition.',
    skill: 'Composition of continuous functions',
    options: {
      'a': 'It is always discontinuous',
      'b': 'Its limit is necessarily zero',
      'c': 'Nothing can be concluded',
      'd': 'It is continuous at a',
    },
  ),
  'continuidade-valor-intermediario': _ExerciseTranslation(
    statement: 'A function f is continuous on [1, 2], with f(1) = -3 and f(2) = 4. What does the Intermediate Value Theorem guarantee?',
    explanation: 'The function is continuous on [1,2], and zero lies between f(1)=−3 and f(2)=4. By the Intermediate Value Theorem, there is at least one c in (1,2) such that f(c)=0. The theorem does not guarantee uniqueness or that c=1.5.',
    skill: 'Intermediate Value Theorem',
    options: {
      'a': 'f is a linear function',
      'b': 'There exists c in (1, 2) with f(c) = 0',
      'c': 'f has exactly one root',
      'd': 'f(1.5) = 0 necessarily',
    },
  ),
  'continuidade-parametro-ponto': _ExerciseTranslation(
    statement: 'If f(x) = x² for x ≠ 2 and f(2) = k, what value of k makes f continuous at x = 2?',
    explanation: 'The limit of x² as x approaches 2 is 4. For continuity, f(2) must also equal 4.',
    skill: 'Defining a value to remove a hole',
  ),
  'continuidade-parametro-partes': _ExerciseTranslation(
    statement: 'If f(x) = 2x + 1 for x < 1 and f(x) = x + k for x ≥ 1, what value of k makes f continuous at x = 1?',
    explanation: 'Evaluate each piece at the switching point. From the left, 2(1)+1=3. From the right and at the point, the second rule gives 1+k. Set 1+k=3 and solve: k=2.',
    skill: 'Parameter in a piecewise function',
  ),
  'continuidade-valor-indefinido': _ExerciseTranslation(
    statement: 'The limit lim x → a f(x) exists and is finite, but f(a) is not defined. Is f continuous at a?',
    explanation: 'No. The first continuity condition requires f(a) to be defined. This situation usually represents a removable discontinuity.',
    skill: 'Identifying a missing function value',
    options: {
      'a': 'Yes, because it is enough for the limit to exist',
      'b': 'Yes, if a is positive',
      'c': 'No, because f(a) must exist',
      'd': 'No, because the limit should be infinite',
    },
  ),
  'continuidade-extremo-intervalo': _ExerciseTranslation(
    statement: 'To check continuity at the left endpoint a of a closed interval [a, b], which limit is used?',
    explanation: 'At the left endpoint a, there are no domain points in [a,b] smaller than a. Therefore, the relevant approach uses values greater than a: the right-hand limit, which must equal f(a).',
    skill: 'One-sided continuity at an endpoint',
    options: {
      'a': 'Only the left-hand limit',
      'b': 'No limit',
      'c': 'Always a limit at infinity',
      'd': 'The right-hand limit',
    },
  ),
  'continuidade-removivel-conceito': _ExerciseTranslation(
    statement: 'When is a discontinuity called removable?',
    explanation: 'It is removable when the limit at the point exists and is finite, allowing the function to be made continuous simply by redefining its value at that point.',
    skill: 'Repairing a removable discontinuity',
    options: {
      'a': 'When redefining the value at the point can make the function continuous',
      'b': 'When the one-sided limits are different',
      'c': 'When there is a vertical asymptote',
      'd': 'When the function has no domain',
    },
  ),
  'continuidade-inversa-dominio': _ExerciseTranslation(
    statement: 'On which intervals is f(x) = 1/x continuous?',
    explanation: 'Start with the domain: 1/x is undefined at x=0. Rational functions are continuous wherever the denominator is nonzero, so split the domain at that point. The maximal intervals of continuity are (−∞,0) and (0,+∞).',
    skill: 'Complete domain-and-continuity analysis',
    options: {
      'a': 'Only on (0, +∞)',
      'b': 'On (-∞, 0) and (0, +∞)',
      'c': 'On all ℝ',
      'd': 'Only at x = 1',
    },
  ),
};
