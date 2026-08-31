import 'package:flutter/widgets.dart';

import 'mock_exercise_data.dart';

class _EquationExerciseTranslation {
  final String title;
  final String statement;
  final String explanation;
  final Map<String, String> options;

  const _EquationExerciseTranslation({
    required this.title,
    required this.statement,
    required this.explanation,
    this.options = const <String, String>{},
  });
}

ExerciseData localizeEquationsExerciseContent(
  ExerciseData exercise,
  Locale locale,
) {
  if (locale.languageCode != 'en') {
    return exercise;
  }

  final translation = _englishEquationExercises[exercise.id];
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
    skill: exercise.skill,
    difficulty: exercise.difficulty,
  );
}

const Map<String, _EquationExerciseTranslation> _englishEquationExercises = {
  'equacao-1': _EquationExerciseTranslation(
    title: 'Question 1 of 10',
    statement: 'Solve the equation:\nx + 3 = 8',
    explanation:
        'To isolate x, subtract 3 from both sides: x = 8 - 3. Therefore, x = 5.',
  ),
  'equacao-2': _EquationExerciseTranslation(
    title: 'Question 2 of 10',
    statement: 'Solve the equation:\n2x = 10',
    explanation:
        'To isolate x, divide both sides by 2: x = 10 ÷ 2. Therefore, x = 5.',
  ),
  'equacao-3': _EquationExerciseTranslation(
    title: 'Question 3 of 10',
    statement: 'Solve the equation:\nx - 4 = 9',
    explanation:
        'To isolate x, add 4 to both sides: x = 9 + 4. Therefore, x = 13.',
  ),
  'equacao-4': _EquationExerciseTranslation(
    title: 'Question 4 of 10',
    statement: 'Solve the equation:\n3x + 2 = 11',
    explanation:
        'First subtract 2 from both sides: 3x = 9. Then divide by 3: x = 3.',
  ),
  'inequacao-1': _EquationExerciseTranslation(
    title: 'Question 5 of 10',
    statement: 'Solve the inequality:\nx + 2 > 7',
    explanation:
        'To isolate x, subtract 2 from both sides: x > 7 - 2. Therefore, x > 5.',
  ),
  'equacao-5': _EquationExerciseTranslation(
    title: 'Question 6 of 10',
    statement: 'Solve the equation:\n5x - 7 = 18',
    explanation:
        'Add 7 to both sides: 5x = 25. Then divide by 5 to obtain x = 5.',
  ),
  'equacao-distributiva': _EquationExerciseTranslation(
    title: 'Question 7 of 10',
    statement: 'Solve the equation:\n4(x - 2) = 12',
    explanation:
        'Divide both sides by 4: x - 2 = 3. Adding 2 to both sides gives x = 5.',
  ),
  'equacao-fracao': _EquationExerciseTranslation(
    title: 'Question 8 of 10',
    statement: 'Solve the equation:\nx/3 + 2 = 6',
    explanation:
        'Subtract 2 from both sides: x/3 = 4. Multiplying both sides by 3 gives x = 12.',
  ),
  'inequacao-2': _EquationExerciseTranslation(
    title: 'Question 9 of 10',
    statement: 'Solve the inequality:\n2x - 3 ≤ 7',
    explanation:
        'Add 3 to both sides: 2x ≤ 10. Dividing by 2, which is positive, keeps the inequality sign unchanged: x ≤ 5.',
  ),
  'inequacao-negativa': _EquationExerciseTranslation(
    title: 'Question 10 of 10',
    statement: 'Solve the inequality:\n-3x > 12',
    explanation:
        'When dividing an inequality by a negative number, reverse the inequality sign. Dividing by -3 gives x < -4.',
  ),
  'equacao-termos-dois-lados': _EquationExerciseTranslation(
    title: 'Question 11 of 20',
    statement: 'Solve the equation:\n2x + 5 = x - 3',
    explanation:
        'Subtract x from both sides and then subtract 5: x = -3 - 5. Therefore, x = -8.',
  ),
  'equacao-distributiva-dois-lados': _EquationExerciseTranslation(
    title: 'Question 12 of 20',
    statement: 'Solve the equation:\n3(x + 1) = 2x + 7',
    explanation:
        'Distribute first: 3x + 3 = 2x + 7. Subtracting 2x and 3 from both sides gives x = 4.',
  ),
  'equacao-fracionaria-2': _EquationExerciseTranslation(
    title: 'Question 13 of 20',
    statement: 'Solve the equation:\n(x - 2) / 4 = 3',
    explanation:
        'Multiply both sides by 4: x - 2 = 12. Adding 2 gives x = 14.',
  ),
  'sistema-linear-1': _EquationExerciseTranslation(
    title: 'Question 14 of 20',
    statement: 'Solve the system:\nx + y = 7\nx - y = 1',
    explanation:
        'Add the equations to get 2x = 8, so x = 4. Substitute into x + y = 7 to obtain y = 3.',
    options: {
      'a': 'x = 4 and y = 3',
      'b': 'x = 3 and y = 4',
      'c': 'x = 7 and y = 1',
      'd': 'x = 2 and y = 5',
    },
  ),
  'equacao-quadratica-1': _EquationExerciseTranslation(
    title: 'Question 15 of 20',
    statement: 'Solve the equation:\nx² - 9 = 0',
    explanation: 'We have x² = 9. Therefore, x can be 3 or -3.',
    options: {
      'c': 'x = -3 or x = 3',
    },
  ),
  'equacao-quadratica-2': _EquationExerciseTranslation(
    title: 'Question 16 of 20',
    statement: 'Solve the equation:\nx² - 5x + 6 = 0',
    explanation:
        'Factor the expression: (x - 2)(x - 3) = 0. Therefore, x = 2 or x = 3.',
    options: {
      'a': 'x = -2 or x = -3',
      'b': 'x = 2 or x = 3',
      'c': 'x = 1 or x = 6',
      'd': 'x = -1 or x = -6',
    },
  ),
  'inequacao-3': _EquationExerciseTranslation(
    title: 'Question 17 of 20',
    statement: 'Solve the inequality:\n5 - 2x < 9',
    explanation:
        'Subtract 5: -2x < 4. When dividing by -2, reverse the inequality sign to obtain x > -2.',
  ),
  'inequacao-distributiva': _EquationExerciseTranslation(
    title: 'Question 18 of 20',
    statement: 'Solve the inequality:\n3(x - 1) ≥ 2x + 4',
    explanation:
        'Distribute first: 3x - 3 ≥ 2x + 4. Subtract 2x and add 3 to obtain x ≥ 7.',
  ),
  'equacao-modular-1': _EquationExerciseTranslation(
    title: 'Question 19 of 20',
    statement: 'Solve the equation:\n|x| = 5',
    explanation:
        'The distance from x to zero is 5. Therefore, x can be 5 or -5.',
    options: {
      'c': 'x = -5 or x = 5',
    },
  ),
  'equacao-sem-solucao': _EquationExerciseTranslation(
    title: 'Question 20 of 20',
    statement: 'Solve the equation:\n2(x + 1) = 2x + 5',
    explanation:
        'Distributing gives 2x + 2 = 2x + 5. Subtracting 2x leaves 2 = 5, which is a contradiction. There is no solution.',
    options: {
      'b': 'No solution',
      'c': 'All real numbers',
    },
  ),
};
