import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/mock_continuity_exercise_data.dart';
import 'package:calcquest/shared/data/mock_derivatives_exercise_data.dart';
import 'package:calcquest/shared/data/mock_equations_exercise_data.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/data/mock_functions_exercise_data.dart';
import 'package:calcquest/shared/data/mock_limits_exercise_data.dart';

void main() {
  final exerciseBanks = <String, List<ExerciseData>>{
    'Álgebra Fundamental': mockExercises,
    'Equações e Inequações': mockEquationsExercises,
    'Funções': mockFunctionsExercises,
    'Limites': mockLimitsExercises,
    'Continuidade': mockContinuityExercises,
    'Derivadas': mockDerivativesExercises,
  };

  for (final bankEntry in exerciseBanks.entries) {
    group(bankEntry.key, () {
      final questions = bankEntry.value;

      test('possui exatamente 20 questões', () {
        expect(questions, hasLength(20));
      });

      test('possui questões e alternativas estruturalmente válidas', () {
        final questionIds = questions.map((question) => question.id).toSet();

        expect(
          questionIds,
          hasLength(questions.length),
          reason: '${bankEntry.key}: existem IDs de questões repetidos.',
        );

        for (final question in questions) {
          expect(
            question.id.trim(),
            isNotEmpty,
            reason: '${bankEntry.key}: questão sem ID.',
          );

          expect(
            question.statement.trim(),
            isNotEmpty,
            reason: '${question.id}: enunciado vazio.',
          );

          expect(
            question.explanation.trim(),
            isNotEmpty,
            reason: '${question.id}: explicação vazia.',
          );

          expect(
            question.options,
            hasLength(4),
            reason: '${question.id}: deve possuir quatro alternativas.',
          );

          final optionIds = question.options
              .map((option) => option.id)
              .toList();

          final optionTexts = question.options
              .map((option) => option.text.trim().toLowerCase())
              .toList();

          expect(
            optionIds.toSet(),
            hasLength(optionIds.length),
            reason: '${question.id}: IDs de alternativas repetidos.',
          );

          expect(
            optionTexts.toSet(),
            hasLength(optionTexts.length),
            reason: '${question.id}: textos de alternativas repetidos.',
          );

          expect(
            optionTexts.every((text) => text.isNotEmpty),
            isTrue,
            reason: '${question.id}: alternativa vazia.',
          );

          expect(
            optionIds,
            contains(question.correctOptionId),
            reason:
                '${question.id}: resposta correta não existe nas alternativas.',
          );
        }
      });
    });
  }

  test('não existem IDs repetidos entre assuntos diferentes', () {
    final allQuestionIds = exerciseBanks.values
        .expand((questions) => questions)
        .map((question) => question.id)
        .toList();

    expect(allQuestionIds.toSet(), hasLength(allQuestionIds.length));
  });

  test('não existem enunciados completamente duplicados', () {
    final allStatements = exerciseBanks.values
        .expand((questions) => questions)
        .map((question) => question.statement.trim().toLowerCase())
        .toList();

    expect(allStatements.toSet(), hasLength(allStatements.length));
  });
}
