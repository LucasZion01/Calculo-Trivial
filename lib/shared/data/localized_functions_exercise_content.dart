import 'package:flutter/widgets.dart';

import 'mock_exercise_data.dart';

class _ExerciseTranslation {
  final String title;
  final String statement;
  final String explanation;
  final Map<String, String> options;

  const _ExerciseTranslation({
    required this.title,
    required this.statement,
    required this.explanation,
    this.options = const <String, String>{},
  });
}

ExerciseData localizeFunctionsExerciseContent(
  ExerciseData exercise,
  Locale locale,
) {
  if (locale.languageCode != 'en') {
    return exercise;
  }

  final translation = _englishFunctionsExercises[exercise.id];
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

const Map<String, _ExerciseTranslation> _englishFunctionsExercises = {
  'funcoes-dominio': _ExerciseTranslation(
    title: 'Question 1 of 10',
    statement:
        'Consider the function:\n\nf(x) = √(x - 2)\n\nWhat is the domain of f?',
    explanation:
        'For the square root to be real, the radicand must be greater than or equal to zero. Thus, x - 2 ≥ 0, so x ≥ 2. Therefore, the domain is [2, ∞).',
  ),
  'funcoes-composicao': _ExerciseTranslation(
    title: 'Question 2 of 10',
    statement:
        'Let:\n\nf(x) = 2x + 1\ng(x) = x²\n\nDetermine (f ∘ g)(x).',
    explanation:
        'For the composition (f ∘ g)(x), compute f(g(x)). Since g(x) = x², substitute x² into f: f(x²) = 2x² + 1.',
  ),
  'funcoes-inversa': _ExerciseTranslation(
    title: 'Question 3 of 10',
    statement:
        'Consider the function:\n\nf(x) = 3x - 6\n\nWhat is the inverse function f⁻¹(x)?',
    explanation:
        'Write y = 3x - 6 and solve for x: y + 6 = 3x, so x = (y + 6)/3. Replacing y with x gives f⁻¹(x) = (x + 6)/3.',
  ),
  'funcoes-paridade': _ExerciseTranslation(
    title: 'Question 4 of 10',
    statement:
        'Consider the function:\n\nf(x) = x² + 4\n\nHow is this function classified by parity?',
    explanation:
        'Computing f(-x) gives (-x)² + 4 = x² + 4 = f(x). Therefore, f(-x) = f(x), which characterizes an even function.',
    options: {
      'a': 'Even function',
      'b': 'Odd function',
      'c': 'Neither even nor odd',
      'd': 'Constant function',
    },
  ),
  'funcoes-imagem-quadratica': _ExerciseTranslation(
    title: 'Question 5 of 10',
    statement:
        'Consider the function:\n\nf(x) = x² - 4x + 3\n\nWhat is the minimum value of f(x)?',
    explanation:
        'Complete the square: f(x) = (x - 2)² - 1. Since (x - 2)² ≥ 0, the minimum occurs at x = 2. Therefore, the minimum value is -1.',
  ),
  'funcoes-valor-numerico': _ExerciseTranslation(
    title: 'Question 6 of 10',
    statement:
        'Consider the function:\n\nf(x) = 2x² - x + 1\n\nWhat is the value of f(3)?',
    explanation:
        'Substitute x = 3: f(3) = 2(3²) - 3 + 1 = 18 - 3 + 1 = 16.',
  ),
  'funcoes-raizes': _ExerciseTranslation(
    title: 'Question 7 of 10',
    statement:
        'Consider the function:\n\nf(x) = x² - 5x + 6\n\nWhat are the zeros of f?',
    explanation:
        'Factor the polynomial: x² - 5x + 6 = (x - 2)(x - 3). Therefore, the zeros are x = 2 and x = 3.',
    options: {
      'a': 'x = -2 and x = -3',
      'b': 'x = 1 and x = 6',
      'c': 'x = -1 and x = -6',
      'd': 'x = 2 and x = 3',
    },
  ),
  'funcoes-coeficiente-angular': _ExerciseTranslation(
    title: 'Question 8 of 10',
    statement:
        'Consider the linear function:\n\nf(x) = -3x + 4\n\nWhat is the slope?',
    explanation:
        'In the form f(x) = ax + b, the slope is a. In this case, a = -3.',
  ),
  'funcoes-composicao-inversa': _ExerciseTranslation(
    title: 'Question 9 of 10',
    statement:
        'Let:\n\nf(x) = x + 2\ng(x) = 3x\n\nDetermine (g ∘ f)(x).',
    explanation:
        'Compute g(f(x)). Since f(x) = x + 2, substitute it into g: g(x + 2) = 3(x + 2) = 3x + 6.',
  ),
  'funcoes-imagem-modulo': _ExerciseTranslation(
    title: 'Question 10 of 10',
    statement:
        'Consider the function:\n\nf(x) = |x|\n\nWhat is the range of f?',
    explanation:
        'Absolute value is never negative. The function can take the value zero and any positive value, so its range is [0, ∞).',
  ),
  'funcoes-dominio-racional': _ExerciseTranslation(
    title: 'Question 11 of 20',
    statement:
        'Consider the function:\n\nf(x) = 1 / (x - 4)\n\nWhat is the domain of f?',
    explanation:
        'The denominator cannot be zero. Since x - 4 = 0 when x = 4, the domain contains all real numbers except 4.',
  ),
  'funcoes-valor-numerico-2': _ExerciseTranslation(
    title: 'Question 12 of 20',
    statement:
        'Consider the function:\n\nf(x) = -x² + 4x\n\nWhat is the value of f(2)?',
    explanation:
        'Substitute x = 2: f(2) = -(2²) + 4 · 2 = -4 + 8 = 4.',
  ),
  'funcoes-vertice': _ExerciseTranslation(
    title: 'Question 13 of 20',
    statement:
        'Consider the function:\n\nf(x) = x² - 6x + 5\n\nWhat is the minimum value of f?',
    explanation:
        'Complete the square: f(x) = (x - 3)² - 4. The minimum occurs at x = 3 and equals -4.',
  ),
  'funcoes-crescimento-afim': _ExerciseTranslation(
    title: 'Question 14 of 20',
    statement:
        'Consider the function:\n\nf(x) = 2x + 1\n\nHow is it classified by monotonicity?',
    explanation:
        'The slope is 2, which is positive. Therefore, the function is increasing.',
    options: {
      'a': 'Decreasing',
      'b': 'Increasing',
      'c': 'Constant',
      'd': 'Periodic',
    },
  ),
  'funcoes-intersecao-eixo-y': _ExerciseTranslation(
    title: 'Question 15 of 20',
    statement:
        'Consider the function:\n\nf(x) = -3x + 6\n\nAt what value does the graph intersect the y-axis?',
    explanation:
        'The y-intercept occurs when x = 0. Thus, f(0) = 6.',
  ),
  'funcoes-inversa-2': _ExerciseTranslation(
    title: 'Question 16 of 20',
    statement:
        'Consider the function:\n\nf(x) = 2x + 4\n\nWhat is the inverse function?',
    explanation:
        'Write y = 2x + 4 and solve for x: x = (y - 4)/2. Therefore, f⁻¹(x) = (x - 4)/2.',
  ),
  'funcoes-composicao-3': _ExerciseTranslation(
    title: 'Question 17 of 20',
    statement:
        'Let:\n\nf(x) = x²\ng(x) = x + 1\n\nDetermine (f ∘ g)(x).',
    explanation:
        'Compute f(g(x)). Substituting g(x) = x + 1 into f gives (x + 1)².',
  ),
  'funcoes-impar': _ExerciseTranslation(
    title: 'Question 18 of 20',
    statement:
        'Consider the function:\n\nf(x) = x³ - x\n\nHow is it classified by parity?',
    explanation:
        'Computing f(-x) gives -x³ + x = -(x³ - x) = -f(x). Therefore, the function is odd.',
    options: {
      'a': 'Even function',
      'b': 'Odd function',
      'c': 'Neither even nor odd',
      'd': 'Constant function',
    },
  ),
  'funcoes-exponencial': _ExerciseTranslation(
    title: 'Question 19 of 20',
    statement:
        'Consider the function:\n\nf(x) = 2ˣ\n\nWhat is the value of f(3)?',
    explanation: 'Substitute x = 3: f(3) = 2³ = 8.',
  ),
  'funcoes-imagem-quadratica-2': _ExerciseTranslation(
    title: 'Question 20 of 20',
    statement:
        'Consider the function:\n\nf(x) = -(x - 1)² + 4\n\nWhat is the range of f?',
    explanation:
        'The parabola opens downward and has maximum value 4. Therefore, it takes every value less than or equal to 4.',
  ),
};
