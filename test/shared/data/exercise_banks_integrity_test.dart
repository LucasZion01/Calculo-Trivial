import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/mock_continuity_exercise_data.dart';
import 'package:calcquest/shared/data/mock_derivatives_exercise_data.dart';
import 'package:calcquest/shared/data/mock_equations_exercise_data.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/data/mock_functions_exercise_data.dart';
import 'package:calcquest/shared/data/mock_limits_exercise_data.dart';

const exerciseBanks = [
  (name: 'Álgebra Fundamental', questions: mockExercises),
  (name: 'Equações e Inequações', questions: mockEquationsExercises),
  (name: 'Funções', questions: mockFunctionsExercises),
  (name: 'Limites', questions: mockLimitsExercises),
  (name: 'Continuidade', questions: mockContinuityExercises),
  (name: 'Derivadas', questions: mockDerivativesExercises),
];

void main() {
  group('Integridade dos bancos de exercícios', () {
    for (final bank in exerciseBanks) {
      test('${bank.name} contém exatamente 20 questões', () {
        expect(
          bank.questions,
          hasLength(20),
          reason: '${bank.name} deve possuir exatamente 20 questões.',
        );
      });

      test('${bank.name} possui questões válidas', () {
        final questionIds = bank.questions
            .map((question) => question.id.trim())
            .toList();

        expect(
          questionIds.toSet(),
          hasLength(questionIds.length),
          reason: '${bank.name} possui IDs de questões duplicados.',
        );

        for (final question in bank.questions) {
          expect(
            question.id.trim(),
            isNotEmpty,
            reason: '${bank.name} possui uma questão sem ID.',
          );

          expect(
            question.statement.trim(),
            isNotEmpty,
            reason: 'A questão ${question.id} não possui enunciado.',
          );

          expect(
            question.explanation.trim(),
            isNotEmpty,
            reason: 'A questão ${question.id} não possui explicação.',
          );

          expect(
            question.options,
            hasLength(4),
            reason: 'A questão ${question.id} deve possuir 4 alternativas.',
          );

          final optionIds = question.options
              .map((option) => option.id.trim())
              .toList();

          final optionTexts = question.options
              .map((option) => option.text.trim())
              .toList();

          expect(
            optionIds.every((id) => id.isNotEmpty),
            isTrue,
            reason: 'A questão ${question.id} possui alternativa sem ID.',
          );

          expect(
            optionTexts.every((text) => text.isNotEmpty),
            isTrue,
            reason: 'A questão ${question.id} possui alternativa sem texto.',
          );

          expect(
            optionIds.toSet(),
            hasLength(optionIds.length),
            reason:
                'A questão ${question.id} possui IDs de alternativas duplicados.',
          );

          expect(
            optionTexts.toSet(),
            hasLength(optionTexts.length),
            reason: 'A questão ${question.id} possui alternativas repetidas.',
          );

          expect(
            optionIds.where((id) => id == question.correctOptionId),
            hasLength(1),
            reason:
                'A resposta correta da questão ${question.id} não corresponde '
                'a uma única alternativa.',
          );
        }
      });
    }

    test('todos os IDs de questões são globalmente únicos', () {
      final allQuestionIds = exerciseBanks
          .expand((bank) => bank.questions)
          .map((question) => question.id.trim())
          .toList();

      expect(
        allQuestionIds.toSet(),
        hasLength(allQuestionIds.length),
        reason: 'Existem IDs repetidos entre bancos de assuntos diferentes.',
      );
    });
  });
}
