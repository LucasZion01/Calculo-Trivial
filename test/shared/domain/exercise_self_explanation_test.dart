import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/exercise_self_explanation.dart';

void main() {
  test('gera reflexão estruturada para habilidade mapeada', () {
    final question = resolveExerciseSelfExplanationQuestion(
      skill: 'Dividir monômios',
      isEnglish: false,
    );

    expect(question, isNotNull);
    expect(question!.correctOptionId, 'skill');
    expect(question.options.first.text, 'Dividir monômios');
    expect(question.options.length, 3);
  });

  test('não gera reflexão para habilidade sem orientação específica', () {
    final question = resolveExerciseSelfExplanationQuestion(
      skill: 'Habilidade futura',
      isEnglish: false,
    );

    expect(question, isNull);
  });

  test('não gera reflexão sem skill', () {
    final question = resolveExerciseSelfExplanationQuestion(
      skill: null,
      isEnglish: false,
    );

    expect(question, isNull);
  });
}
