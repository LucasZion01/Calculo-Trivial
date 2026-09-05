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

  test('limite com racionalização orienta conjugado sem revelar valor', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Racionalização com conjugado',
      isEnglish: false,
    );

    expect(guidance.isSpecific, isTrue);
    expect(guidance.firstHint, contains('conjugado'));
    expect(guidance.nextStep, contains('diferença de quadrados'));
    expect(guidance.firstHint, isNot(contains('resultado')));
  });

  test('limite lateral preserva direção da aproximação', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Limite lateral pela direita',
      isEnglish: false,
    );

    expect(guidance.isSpecific, isTrue);
    expect(guidance.firstHint, contains('lado indicado'));
    expect(guidance.nextStep, contains('limite lateral'));
  });

  test('continuidade em função racional começa pelo domínio', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Domínio de função racional',
      isEnglish: false,
    );

    expect(guidance.isSpecific, isTrue);
    expect(guidance.firstHint, contains('denominador'));
    expect(guidance.nextStep, contains('fora do domínio'));
  });

  test('continuidade em um ponto usa as três condições', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Continuidade em um ponto',
      isEnglish: false,
    );

    expect(guidance.isSpecific, isTrue);
    expect(guidance.firstHint, contains('f(a)'));
    expect(guidance.firstHint, contains('limite'));
    expect(guidance.nextStep, contains('três condições'));
  });

  test('regra da potência orienta procedimento sem resolver exercício', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Regra da potência',
      isEnglish: false,
    );

    expect(guidance.isSpecific, isTrue);
    expect(guidance.firstHint, contains('expoente'));
    expect(guidance.nextStep, contains('uma unidade'));
    expect(guidance.firstHint, isNot(contains('3x²')));
  });

  test('regra do produto lembra as duas parcelas', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Regra do produto',
      isEnglish: false,
    );

    expect(guidance.isSpecific, isTrue);
    expect(guidance.firstHint, contains('produto u·v'));
    expect(guidance.nextStep, contains('u′v + uv′'));
  });

  test('regra da cadeia identifica função externa e interna', () {
    final guidance = resolveExerciseFeedbackGuidance(
      skill: 'Regra da cadeia',
      isEnglish: false,
    );

    expect(guidance.isSpecific, isTrue);
    expect(guidance.firstHint, contains('função externa'));
    expect(guidance.nextStep, contains('função interna'));
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
