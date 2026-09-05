import 'package:flutter/widgets.dart';

import 'mock_exercise_data.dart';

class _ExerciseTranslation {
  final String title;
  final String statement;
  final String explanation;
  final String? skill;

  const _ExerciseTranslation({
    required this.title,
    required this.statement,
    required this.explanation,
    this.skill,
  });
}

ExerciseData localizeAlgebraExerciseContent(
  ExerciseData exercise,
  Locale locale,
) {
  if (locale.languageCode != 'en') {
    final normalizedStatement = exercise.statement.replaceAll(r'\n', '\n');
    if (normalizedStatement == exercise.statement) {
      return exercise;
    }

    return ExerciseData(
      id: exercise.id,
      title: exercise.title,
      statement: normalizedStatement,
      options: exercise.options,
      correctOptionId: exercise.correctOptionId,
      explanation: exercise.explanation,
      contentLessonId: exercise.contentLessonId,
      skill: exercise.skill,
      difficulty: exercise.difficulty,
    );
  }

  final translation = _englishAlgebraExercises[exercise.id];
  if (translation == null) {
    return exercise;
  }

  return ExerciseData(
    id: exercise.id,
    title: translation.title,
    statement: translation.statement,
    options: exercise.options,
    correctOptionId: exercise.correctOptionId,
    explanation: translation.explanation,
    contentLessonId: exercise.contentLessonId,
    skill: translation.skill ?? exercise.skill,
    difficulty: exercise.difficulty,
  );
}

const Map<String, _ExerciseTranslation> _englishAlgebraExercises = {
  'simplificacao-1': _ExerciseTranslation(
    title: 'Question 1 of 20',
    statement: 'Simplify the expression:\n3x + 5x − 2x',
    explanation:
        'Add only the coefficients of like terms: 3 + 5 − 2 = 6. The literal part x remains unchanged, so the simplified expression is 6x.',
    skill: 'Combine like terms',
  ),
  'simplificacao-2': _ExerciseTranslation(
    title: 'Question 2 of 20',
    statement: 'Simplify the expression:\n7a − 2a + 4a',
    explanation:
        'All terms have the same literal part a. Add the coefficients 7 − 2 + 4 = 9 and keep the variable, giving 9a.',
    skill: 'Combine like terms',
  ),
  'simplificacao-3': _ExerciseTranslation(
    title: 'Question 3 of 20',
    statement: 'Evaluate 2x² − 3x for x = −2.',
    explanation:
        'Substitute x = −2: 2(−2)² − 3(−2). Evaluate the power first: 2·4 + 6 = 14, so the numerical value is 14.',
    skill: 'Evaluate an algebraic expression',
  ),
  'simplificacao-4': _ExerciseTranslation(
    title: 'Question 4 of 20',
    statement: 'What is the coefficient of −8x³?',
    explanation:
        'The coefficient is the number multiplying the literal part. In −8x³, the literal part is x³ and the number multiplying it is −8.',
    skill: 'Identify coefficients',
  ),
  'simplificacao-5': _ExerciseTranslation(
    title: 'Question 5 of 20',
    statement: 'Simplify the expression:\n12x − 5x + 2x',
    explanation:
        'Because all three terms contain x, add the coefficients: 12 − 5 + 2 = 9. Therefore, the equivalent expression is 9x.',
    skill: 'Combine like terms',
  ),
  'distributiva-1': _ExerciseTranslation(
    title: 'Question 6 of 20',
    statement: 'Simplify the expression:\n2(3x − 4) + x',
    explanation:
        'Apply the distributive property to every term inside the parentheses: 2(3x − 4) = 6x − 8. Then add x to obtain 7x − 8.',
    skill: 'Apply the distributive property',
  ),
  'distributiva-2': _ExerciseTranslation(
    title: 'Question 7 of 20',
    statement: 'Simplify the expression:\n5a − 2(a + 3)',
    explanation:
        'The factor −2 multiplies both a and 3, producing −2a − 6. Therefore, 5a − 2a − 6 = 3a − 6.',
    skill: 'Distribute negative signs',
  ),
  'potencias-1': _ExerciseTranslation(
    title: 'Question 8 of 20',
    statement: 'Multiply:\n(−3x²)(2x)',
    explanation:
        'Multiply the coefficients: −3·2 = −6. For the same base x, add the exponents: x²·x = x³. The product is −6x³.',
    skill: 'Multiply monomials',
  ),
  'produto-notavel-1': _ExerciseTranslation(
    title: 'Question 9 of 20',
    statement: 'Expand the product:\n(x + 3)(x − 2)',
    explanation:
        'Distribute each term: x² − 2x + 3x − 6. Combining −2x + 3x gives x² + x − 6.',
    skill: 'Expand binomials',
  ),
  'divisao-monomios-1': _ExerciseTranslation(
    title: 'Question 10 of 20',
    statement: 'Simplify the expression:\n(12x³y²) / (3xy)',
    explanation:
        'Divide the coefficients and subtract exponents of equal bases: 12/3 = 4, x³/x = x², and y²/y = y. The result is 4x²y.',
    skill: 'Divide monomials',
  ),
  'fator-comum-1': _ExerciseTranslation(
    title: 'Question 11 of 20',
    statement: 'Factor the expression:\n6x + 9',
    explanation:
        'The greatest common factor of 6x and 9 is 3. Factoring out 3 gives 6x = 3·2x and 9 = 3·3, so the result is 3(2x + 3).',
    skill: 'Factor out the greatest common factor',
  ),
  'quociente-potencias-1': _ExerciseTranslation(
    title: 'Question 12 of 20',
    statement: 'Simplify, assuming x ≠ 0:\nx⁵ / x²',
    explanation:
        'When dividing powers with the same base, subtract the exponents: x⁵/x² = x⁵⁻² = x³. The restriction x ≠ 0 prevents division by zero.',
    skill: 'Use the quotient rule for powers',
  ),
  'potencia-potencia-1': _ExerciseTranslation(
    title: 'Question 13 of 20',
    statement: 'Simplify the expression:\n(2x²)³',
    explanation:
        'Raise each factor to the third power: 2³ = 8 and (x²)³ = x⁶ because the exponents are multiplied. Therefore, the expression becomes 8x⁶.',
    skill: 'Evaluate a power of a power',
  ),
  'distributiva-3': _ExerciseTranslation(
    title: 'Question 14 of 20',
    statement: 'Simplify the expression:\n3(x + 2) − 2(x − 1)',
    explanation:
        'Distributing gives 3x + 6 − 2x + 2. Notice that −2 times −1 gives +2. Combining like terms gives x + 8.',
    skill: 'Combine distribution and sign rules',
  ),
  'valor-numerico-1': _ExerciseTranslation(
    title: 'Question 15 of 20',
    statement: 'Evaluate 2a² − 3a for a = −2.',
    explanation:
        'Substitute a = −2: 2(−2)² − 3(−2). Evaluate the power first: 2·4 + 6. Therefore, the value is 14.',
    skill: 'Evaluate an algebraic expression',
  ),
  'quadrado-soma-1': _ExerciseTranslation(
    title: 'Question 16 of 20',
    statement: 'Expand the special product:\n(x + 4)²',
    explanation:
        'Use (a + b)² = a² + 2ab + b². Here, a = x and b = 4, so the result is x² + 8x + 16.',
    skill: 'Use the square of a sum',
  ),
  'diferenca-quadrados-1': _ExerciseTranslation(
    title: 'Question 17 of 20',
    statement: 'Factor the expression:\nx² − 9',
    explanation:
        'This is a difference of squares: x² − 3². The identity a² − b² = (a − b)(a + b) gives (x − 3)(x + 3).',
    skill: 'Factor a difference of squares',
  ),
  'soma-fracoes-algebricas-1': _ExerciseTranslation(
    title: 'Question 18 of 20',
    statement: 'Simplify the expression:\nx/2 + x/3',
    explanation:
        'The least common multiple of 2 and 3 is 6. Rewrite x/2 as 3x/6 and x/3 as 2x/6, then add to obtain 5x/6.',
    skill: 'Add algebraic fractions',
  ),
  'termos-semelhantes-1': _ExerciseTranslation(
    title: 'Question 19 of 20',
    statement: 'Simplify:\n4x²y − 7x²y + 2x²y',
    explanation:
        'All terms have the same literal part x²y. Add the coefficients 4 − 7 + 2 = −1, so the result is −x²y.',
    skill: 'Combine terms with two variables',
  ),
  'sintese-algebrica-1': _ExerciseTranslation(
    title: 'Question 20 of 20',
    statement: 'Simplify:\n2(x + 1) + (x − 3)(x + 3)',
    explanation:
        'Use two tools: 2(x + 1) = 2x + 2 and (x − 3)(x + 3) = x² − 9. Adding the results gives x² + 2x − 7.',
    skill: 'Choose algebraic strategies',
  ),
};
