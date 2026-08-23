import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/exercise_session_result.dart';

void main() {
  group('ExerciseSessionResult', () {
    test('aprova com exatamente 80 por cento', () {
      const result = ExerciseSessionResult(
        totalQuestions: 10,
        correctAnswers: 8,
        configuredXp: 60,
        configuredGold: 25,
      );

      expect(result.isApproved, isTrue);
      expect(result.accuracyPercentage, 80);
    });

    test('reprova abaixo de 80 por cento', () {
      const result = ExerciseSessionResult(
        totalQuestions: 10,
        correctAnswers: 7,
        configuredXp: 60,
        configuredGold: 25,
      );

      expect(result.isApproved, isFalse);
      expect(result.accuracyPercentage, 70);
    });

    test('calcula acertos e erros corretamente', () {
      const result = ExerciseSessionResult(
        totalQuestions: 10,
        correctAnswers: 6,
        configuredXp: 60,
        configuredGold: 25,
      );

      expect(result.correctAnswers, 6);
      expect(result.incorrectAnswers, 4);
      expect(result.accuracyPercentage, 60);
    });

    test('não concede recompensa após reprovação', () {
      const result = ExerciseSessionResult(
        totalQuestions: 10,
        correctAnswers: 7,
        configuredXp: 60,
        configuredGold: 25,
      );

      expect(result.earnedXp, 0);
      expect(result.earnedGold, 0);
    });

    test('concede recompensa após aprovação', () {
      const result = ExerciseSessionResult(
        totalQuestions: 10,
        correctAnswers: 9,
        configuredXp: 80,
        configuredGold: 35,
      );

      expect(result.earnedXp, 80);
      expect(result.earnedGold, 35);
    });

    test('não aprova sessão sem questões', () {
      const result = ExerciseSessionResult(
        totalQuestions: 0,
        correctAnswers: 0,
        configuredXp: 60,
        configuredGold: 25,
      );

      expect(result.isApproved, isFalse);
      expect(result.accuracyPercentage, 0);
      expect(result.earnedXp, 0);
      expect(result.earnedGold, 0);
    });
  });
}
