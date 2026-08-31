import 'package:flutter/widgets.dart';

import 'mock_exercise_data.dart';

class _ExerciseTranslation {
  final String title;
  final String statement;
  final String explanation;
  final String? skill;
  final Map<String, String> options;

  const _ExerciseTranslation({
    required this.title,
    required this.statement,
    required this.explanation,
    this.skill,
    this.options = const <String, String>{},
  });
}

ExerciseData localizeLimitsExerciseContent(
  ExerciseData exercise,
  Locale locale,
) {
  if (locale.languageCode != 'en') {
    return exercise;
  }

  final translation = _englishLimitsExercises[exercise.id];
  if (translation == null) {
    return exercise;
  }

  return ExerciseData(
    id: exercise.id,
    title: translation.title,
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

const Map<String, _ExerciseTranslation> _englishLimitsExercises = {
  'limite-substituicao-direta': _ExerciseTranslation(
    title: 'Question 1 of 10',
    statement: 'Evaluate the limit:\n\nlim x → 3  (2x² - x + 1)',
    explanation:
        'Because the polynomial is continuous, substitute x = 3 directly: 2(3²) - 3 + 1 = 18 - 3 + 1 = 16.',
    skill: 'Direct substitution in polynomials',
  ),
  'limite-fatoracao': _ExerciseTranslation(
    title: 'Question 2 of 10',
    statement: 'Evaluate the limit:\n\nlim x → 2  (x² - 4) / (x - 2)',
    explanation:
        'Direct substitution gives 0/0. Factor x² - 4 = (x - 2)(x + 2). Cancel x - 2, leaving x + 2. Therefore, the limit is 2 + 2 = 4.',
    skill: 'Difference of squares',
    options: {'d': 'Does not exist'},
  ),
  'limite-racionalizacao': _ExerciseTranslation(
    title: 'Question 3 of 10',
    statement: 'Evaluate the limit:\n\nlim x → 0  (√(x + 9) - 3) / x',
    explanation:
        'Direct substitution gives 0/0. Multiply by the conjugate √(x + 9) + 3. The numerator becomes x and cancels with the denominator, leaving 1/(√(x + 9) + 3). At x = 0, this is 1/6.',
    skill: 'Rationalize using a conjugate',
  ),
  'limite-trigonometrico-fundamental': _ExerciseTranslation(
    title: 'Question 4 of 10',
    statement: 'Evaluate the limit:\n\nlim x → 0  sin(x) / x',
    explanation:
        'Substitution gives 0/0, which is an indeterminate form, not the answer. In radians, sin(x) and x are equivalent near zero, so sin(x)/x tends to 1.',
    skill: 'Fundamental trigonometric limit',
    options: {'d': 'Does not exist'},
  ),
  'limite-no-infinito': _ExerciseTranslation(
    title: 'Question 5 of 10',
    statement: 'Evaluate the limit:\n\nlim x → ∞  (3x² - 2x + 1) / (x² + 5)',
    explanation:
        'Divide numerator and denominator by x². The terms containing 1/x and 1/x² tend to zero, leaving the ratio of leading coefficients, 3/1. Therefore, the limit is 3.',
    skill: 'Dominant terms with equal degrees',
  ),
  'limite-racional-direto': _ExerciseTranslation(
    title: 'Question 6 of 10',
    statement:
        'The table shows values of f(x) near x = 2:\n\nx: 1.9 | 1.99 | 2.01 | 2.1\nf(x): 4.8 | 4.98 | 5.02 | 5.2\n\nWhat is the best prediction for lim x → 2 f(x)?',
    explanation:
        'From both sides of 2, the outputs approach 5: 4.98 from the left and 5.02 from the right. The limit describes this trend, so it is 5. The exact value of f(2) is not needed.',
    skill: 'Read trends from a table',
    options: {'c': '4.98', 'd': 'Cannot be predicted'},
  ),
  'limite-fatoracao-segundo': _ExerciseTranslation(
    title: 'Question 7 of 10',
    statement: 'Evaluate the limit:\n\nlim x → 1  (x² - 1) / (x - 1)',
    explanation:
        'Factor x² - 1 = (x - 1)(x + 1). Cancel x - 1, leaving x + 1. As x approaches 1, the limit is 2.',
    skill: 'Cancel the factor causing 0/0',
    options: {'d': 'Does not exist'},
  ),
  'limite-infinito-grau-menor': _ExerciseTranslation(
    title: 'Question 8 of 10',
    statement: 'Evaluate the limit:\n\nlim x → ∞  (2x + 1) / (x² + 3)',
    explanation:
        'Divide everything by x². All terms with x in the denominator tend to zero while the denominator tends to 1. Therefore, the quotient tends to 0.',
    skill: 'Compare polynomial degrees',
  ),
  'limite-lateral-modulo': _ExerciseTranslation(
    title: 'Question 9 of 10',
    statement: 'Evaluate the one-sided limit:\n\nlim x → 0⁺  |x| / x',
    explanation:
        'As x approaches zero from the right, x is positive and |x| = x. Therefore, |x|/x = 1.',
    skill: 'Right-hand limit',
    options: {'c': 'Does not exist'},
  ),
  'limite-bilateral-modulo': _ExerciseTranslation(
    title: 'Question 10 of 10',
    statement: 'Evaluate the limit:\n\nlim x → 0  |x| / x',
    explanation:
        'From the right, |x|/x tends to 1; from the left, it tends to -1. Because the one-sided limits are different, the two-sided limit does not exist.',
    skill: 'Compare one-sided limits',
    options: {'c': 'Does not exist'},
  ),
  'limite-polinomial-negativo': _ExerciseTranslation(
    title: 'Question 11 of 20',
    statement: 'Evaluate the limit:\n\nlim x → -1  (x³ + 2x)',
    explanation:
        'The polynomial is continuous. Substituting x = -1 gives (-1)³ + 2(-1) = -1 - 2 = -3.',
    skill: 'Substitution with a negative number',
  ),
  'limite-fatoracao-terceiro': _ExerciseTranslation(
    title: 'Question 12 of 20',
    statement: 'Evaluate the limit:\n\nlim x → 3  (x² - 9) / (x - 3)',
    explanation:
        'Direct substitution gives 0/0. Factor x² - 9 as (x - 3)(x + 3). For x near 3, cancel x - 3. The remaining expression x + 3 tends to 6.',
    skill: 'Difference of squares',
  ),
  'limite-racionalizacao-2': _ExerciseTranslation(
    title: 'Question 13 of 20',
    statement: 'Evaluate the limit:\n\nlim x → 4  (√x - 2) / (x - 4)',
    explanation:
        'Direct substitution gives 0/0. Multiply by the conjugate √x + 2. The product in the numerator becomes x - 4, which cancels the denominator. The remaining expression 1/(√x + 2) tends to 1/4.',
    skill: 'Rationalize a difference involving a square root',
  ),
  'limite-trigonometrico-2': _ExerciseTranslation(
    title: 'Question 14 of 20',
    statement: 'Evaluate the limit:\n\nlim x → 0  sin(2x) / x',
    explanation:
        'Rewrite sin(2x)/x as 2·sin(2x)/(2x). As x approaches zero, 2x also approaches zero and the fundamental ratio tends to 1. Therefore, the result is 2.',
    skill: 'Rewrite into the form sin(u)/u',
    options: {'d': 'Does not exist'},
  ),
  'limite-cosseno': _ExerciseTranslation(
    title: 'Question 15 of 20',
    statement: 'Evaluate the limit:\n\nlim x → 0  (1 - cos x) / x',
    explanation:
        'After rationalizing, (1 - cos x)/x = sin²(x)/[x(1 + cos x)]. Rewrite it as [sin(x)/x]·[sin(x)/(1 + cos x)]. The factors tend to 1 and 0, so the limit is 0.',
    skill: 'Trigonometric identity and conjugate',
  ),
  'limite-infinito-cubico': _ExerciseTranslation(
    title: 'Question 16 of 20',
    statement: 'Evaluate the limit:\n\nlim x → ∞  (5x³ + x) / (2x³ - 1)',
    explanation:
        'Divide all terms by x³. The terms 1/x² and 1/x³ tend to zero, so the expression approaches 5/2, the ratio of the leading coefficients.',
    skill: 'Dominant cubic terms',
  ),
  'limite-infinito-grau-maior': _ExerciseTranslation(
    title: 'Question 17 of 20',
    statement: 'Evaluate the limit:\n\nlim x → ∞  x² / (x + 1)',
    explanation:
        'Divide numerator and denominator by x to obtain x/(1 + 1/x). The denominator tends to 1 while the numerator grows without bound, so the ratio tends to +∞.',
    skill: 'Unbounded growth',
  ),
  'limite-lateral-reciproco-direita': _ExerciseTranslation(
    title: 'Question 18 of 20',
    statement: 'Evaluate the one-sided limit:\n\nlim x → 0⁺  1/x',
    explanation:
        'From the right, x takes positive values that get closer to zero. Therefore, 1/x grows without bound and tends to +∞.',
    skill: 'Infinite behavior from the right',
  ),
  'limite-lateral-reciproco-esquerda': _ExerciseTranslation(
    title: 'Question 19 of 20',
    statement: 'Evaluate the one-sided limit:\n\nlim x → 0⁻  1/x',
    explanation:
        'From the left, x takes negative values increasingly close to zero. Therefore, 1/x tends to -∞.',
    skill: 'Infinite behavior from the left',
  ),
  'limite-bilateral-reciproco': _ExerciseTranslation(
    title: 'Question 20 of 20',
    statement: 'Evaluate the limit:\n\nlim x → 0  1/x',
    explanation:
        'Compare both sides first. As x approaches zero from the right, 1/x tends to +∞. From the left, it tends to -∞. Because the one-sided behaviors do not match, the two-sided limit does not exist.',
    skill: 'Determine whether a two-sided limit exists',
    options: {'c': 'Does not exist'},
  ),
};
