import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/final_test_question_selector.dart';

void main() {
  group('FinalTestQuestionSelector', () {
    final bank = List<String>.generate(20, (index) => 'q${index + 1}');

    test('keeps the final test distinct from current practice when possible', () {
      final practice = bank.take(10).toSet();

      final selected = FinalTestQuestionSelector.select(
        availableQuestionIds: bank,
        practiceQuestionIds: practice,
        questionCount: 10,
        random: Random(1),
      );

      expect(selected, hasLength(10));
      expect(selected.toSet().intersection(practice), isEmpty);
    });

    test('prioritizes questions not used in the previous final test', () {
      final practice = bank.take(5).toSet();
      final previousFinal = bank.skip(5).take(5).toSet();

      final selected = FinalTestQuestionSelector.select(
        availableQuestionIds: bank,
        practiceQuestionIds: practice,
        previousFinalTestIds: previousFinal,
        questionCount: 10,
        random: Random(2),
      );

      final freshOutsidePractice = bank
          .where(
            (id) => !practice.contains(id) && !previousFinal.contains(id),
          )
          .toSet();

      expect(selected.take(freshOutsidePractice.length).toSet(), freshOutsidePractice);
    });

    test('falls back to practice questions only when necessary', () {
      final smallBank = List<String>.generate(12, (index) => 'q${index + 1}');
      final practice = smallBank.take(6).toSet();

      final selected = FinalTestQuestionSelector.select(
        availableQuestionIds: smallBank,
        practiceQuestionIds: practice,
        questionCount: 10,
        random: Random(3),
      );

      expect(selected, hasLength(10));
      expect(
        selected.take(6).every((id) => !practice.contains(id)),
        isTrue,
      );
    });

    test('removes duplicate ids and respects the available bank size', () {
      final selected = FinalTestQuestionSelector.select(
        availableQuestionIds: const ['q1', 'q1', 'q2'],
        questionCount: 10,
        random: Random(4),
      );

      expect(selected.toSet(), {'q1', 'q2'});
      expect(selected, hasLength(2));
    });

    test('returns empty for an empty bank or invalid count', () {
      expect(
        FinalTestQuestionSelector.select(
          availableQuestionIds: const <String>[],
        ),
        isEmpty,
      );
      expect(
        FinalTestQuestionSelector.select(
          availableQuestionIds: bank,
          questionCount: 0,
        ),
        isEmpty,
      );
    });
  });
}
