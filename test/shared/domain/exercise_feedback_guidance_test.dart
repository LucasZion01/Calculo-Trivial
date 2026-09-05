import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/exercise_feedback_guidance.dart';

void main() {
  test('divisão de monômios recebe orientação específica sem resposta', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Dividir monômios',
      isEnglish: false,
    );

    expect(guidance.isSpecific, isTrue);
    expect(guidance.firstHint, contains('coeficientes numéricos'));
    expect(guidance.nextStep, contains('subtraia o expoente'));
    expect(guidance.firstHint, isNot(contains('4x²y')));
    expect(guidance.nextStep, isNot(contains('4x²y')));
  });

  test('habilidade em inglês recebe orientação específica em inglês', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Divide monomials',
      isEnglish: true,
    );

    expect(guidance.isSpecific, isTrue);
    expect(guidance.firstHint, contains('divide the numerical coefficients'));
    expect(guidance.nextStep, contains('subtract the exponent'));
  });

  test('habilidade desconhecida mantém fallback seguro', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Habilidade futura',
      isEnglish: false,
    );

    expect(guidance.isSpecific, isFalse);
    expect(guidance.firstHint, contains('regra matemática principal'));
    expect(guidance.nextStep, contains('Refaça apenas o primeiro passo'));
  });
}
