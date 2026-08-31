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

ExerciseData localizeDerivativesExerciseContent(
  ExerciseData exercise,
  Locale locale,
) {
  if (locale.languageCode != 'en') return exercise;

  final translation = _englishDerivativesExercises[exercise.id];
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

const Map<String, _ExerciseTranslation> _englishDerivativesExercises = {
  'derivada-significado': _ExerciseTranslation(
    statement: "What is the main geometric interpretation of the derivative f'(a)?",
    explanation: "The derivative f′(a) is the limit of the slopes of secant lines as the second point approaches a. Geometrically, this limit gives the slope of the tangent line to the graph at (a,f(a)); in applications, it represents an instantaneous rate of change.",
    skill: 'Geometric interpretation of the derivative',
    options: {
      'a': 'The area under the graph',
      'b': 'The slope of the tangent line',
      'c': 'The maximum value of the function',
      'd': 'The distance from the origin',
    },
  ),
  'derivada-potencia-cubica': _ExerciseTranslation(
    statement: "If f(x) = x³, what is f'(x)?",
    explanation: "By the power rule, the derivative of xⁿ is n·xⁿ⁻¹. Therefore, (x³)' = 3x².",
    skill: 'Power rule',
  ),
  'derivada-polinomio': _ExerciseTranslation(
    statement: 'Find the derivative of f(x) = 5x² - 3x + 4.',
    explanation: 'Use linearity and differentiate term by term: (5x²)′=10x, (−3x)′=−3, and the constant 4 has derivative zero. Therefore, f′(x)=10x−3.',
    skill: 'Term-by-term differentiation',
  ),
  'derivada-constante': _ExerciseTranslation(
    statement: 'What is the derivative of the constant function f(x) = 12?',
    explanation: 'A constant function does not change. Its rate of change, and therefore its derivative, is zero.',
    skill: 'Derivative of a constant',
  ),
  'derivada-identidade': _ExerciseTranslation(
    statement: "If f(x) = x, what is f'(x)?",
    explanation: 'For f(x)=x, every increase Δx in the input produces the same increase Δx in the output. Thus Δf/Δx is always 1, so f′(x)=1 at every point.',
    skill: 'Derivative of the identity function',
  ),
  'derivada-raiz': _ExerciseTranslation(
    statement: 'For x > 0, what is the derivative of f(x) = √x?',
    explanation: 'Rewrite √x as x¹ᐟ². By the power rule, (x¹ᐟ²)′=(1/2)x⁻¹ᐟ²=1/(2√x), valid for x>0.',
    skill: 'Fractional exponents',
  ),
  'derivada-inversa': _ExerciseTranslation(
    statement: 'For x ≠ 0, what is the derivative of f(x) = 1/x?',
    explanation: "Since 1/x=x⁻¹, use the power rule: (x⁻¹)'=−x⁻²=−1/x². The negative sign reflects that 1/x decreases on each interval of its domain.",
    skill: 'Negative exponents',
  ),
  'derivada-produto': _ExerciseTranslation(
    statement: 'Find the derivative of f(x) = x²(x + 1).',
    explanation: 'You may expand first: x²(x+1)=x³+x², so f′(x)=3x²+2x. The product rule gives the same result: 2x(x+1)+x².',
    skill: 'Product rule or algebraic expansion',
  ),
  'derivada-quociente-simplificado': _ExerciseTranslation(
    statement: 'For x ≠ 0, differentiate f(x) = (x² + 1)/x.',
    explanation: 'Simplify first: (x²+1)/x=x+1/x=x+x⁻¹. Differentiate term by term to get 1−x⁻², so f′(x)=1−1/x².',
    skill: 'Simplifying before differentiating',
  ),
  'derivada-regra-cadeia': _ExerciseTranslation(
    statement: 'Find the derivative of f(x) = (2x + 1)³.',
    explanation: 'Separate the layers: the outer function is u³ and the inner function is u=2x+1. Differentiate the outer function and multiply by the inner derivative 2. Thus f′(x)=6(2x+1)².',
    skill: 'Chain rule',
  ),
  'derivada-seno': _ExerciseTranslation(
    statement: 'What is the derivative of f(x) = sin(x)?',
    explanation: 'The derivative of sin(x) is cos(x). Thus d/dx[sin(x)]=cos(x).',
    skill: 'Derivative of sine',
    options: {
      'c': 'sin(x)',
      'd': '-sin(x)',
    },
  ),
  'derivada-cosseno': _ExerciseTranslation(
    statement: 'What is the derivative of f(x) = cos(x)?',
    explanation: 'The derivative of cosine is −sin(x). Therefore, d/dx[cos(x)]=−sin(x).',
    skill: 'Derivative of cosine',
    options: {
      'a': 'sin(x)',
      'd': '-sin(x)',
    },
  ),
  'derivada-exponencial': _ExerciseTranslation(
    statement: 'What is the derivative of f(x) = eˣ?',
    explanation: 'The base e is defined so that the instantaneous growth rate of eˣ equals the function value itself. Therefore, d/dx[eˣ]=eˣ.',
    skill: 'Derivative of the natural exponential',
  ),
  'derivada-logaritmo': _ExerciseTranslation(
    statement: 'For x > 0, what is the derivative of f(x) = ln(x)?',
    explanation: 'For x>0, the natural logarithm has derivative 1/x. The rate remains positive but decreases as x grows.',
    skill: 'Derivative of the natural logarithm',
  ),
  'derivada-inclinacao-ponto': _ExerciseTranslation(
    statement: 'What is the slope of the tangent line to f(x) = x² at x = 2?',
    explanation: "First differentiate: f'(x)=2x. Evaluate at x=2: f'(2)=4. Therefore, the tangent slope is 4.",
    skill: 'Tangent slope at a point',
  ),
  'derivada-equacao-tangente': _ExerciseTranslation(
    statement: 'What is the tangent line to f(x) = x² at the point (1, 1)?',
    explanation: 'Differentiate to get f′(x)=2x. At x=1, the slope is 2. Using point-slope form, y−1=2(x−1), so y=2x−1.',
    skill: 'Equation of the tangent line',
  ),
  'derivada-ponto-critico': _ExerciseTranslation(
    statement: 'At what x-value does f(x) = x² - 4x have derivative equal to zero?',
    explanation: "Differentiate: f'(x)=2x−4. Set the derivative equal to zero: 2x−4=0, so x=2.",
    skill: 'Locating a critical point',
  ),
  'derivabilidade-continuidade': _ExerciseTranslation(
    statement: 'If a function is differentiable at x = a, what must be true?',
    explanation: 'If the derivative exists at a, the function must be continuous there. The converse is false: continuity does not guarantee differentiability, as |x| at zero shows.',
    skill: 'Differentiability and continuity',
    options: {
      'a': 'It has a maximum at a',
      'b': 'It is continuous at a',
      'c': 'Its derivative is zero at a',
      'd': 'It is a polynomial function',
    },
  ),
  'derivada-modulo-zero': _ExerciseTranslation(
    statement: 'Why is f(x) = |x| not differentiable at x = 0?',
    explanation: 'For x<0, |x|=−x and the slope is −1. For x>0, |x|=x and the slope is 1. Since the one-sided derivatives at zero are different, there is no unique tangent line.',
    skill: 'One-sided derivatives at a corner',
    options: {
      'a': 'The one-sided derivatives are different',
      'b': 'The function is not defined at zero',
      'c': 'The function limit is infinite',
      'd': 'The function is not continuous at zero',
    },
  ),
  'derivada-velocidade': _ExerciseTranslation(
    statement: 'The position of an object is s(t) = t² + 3t meters. What is its instantaneous velocity at t = 2 s?',
    explanation: 'Instantaneous velocity is the derivative of position. Differentiate s(t)=t²+3t to get v(t)=2t+3. Then v(2)=7 m/s.',
    skill: 'Instantaneous velocity',
  ),
};
