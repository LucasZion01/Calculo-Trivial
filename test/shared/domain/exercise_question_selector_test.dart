import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/exercise_question_selector.dart';

void main() {
  group('ExerciseQuestionSelector', () {
    test('seleciona dez questões únicas', () {
      final availableIds = List<String>.generate(
        20,
        (index) => 'questao-${index + 1}',
      );

      final selectedIds = ExerciseQuestionSelector.select(
        availableQuestionIds: availableIds,
        random: Random(1),
      );

      expect(selectedIds, hasLength(10));
      expect(selectedIds.toSet(), hasLength(10));
    });

    test('não repete questões quando existem alternativas suficientes', () {
      final availableIds = List<String>.generate(
        20,
        (index) => 'questao-${index + 1}',
      );

      final previousIds = availableIds.take(10).toSet();

      final selectedIds = ExerciseQuestionSelector.select(
        availableQuestionIds: availableIds,
        previousSessionIds: previousIds,
        random: Random(2),
      );

      expect(selectedIds, hasLength(10));
      expect(selectedIds.toSet().intersection(previousIds), isEmpty);
    });

    test(
      'prioriza questões novas quando algumas repetições são necessárias',
      () {
        final availableIds = List<String>.generate(
          12,
          (index) => 'questao-${index + 1}',
        );

        final previousIds = availableIds.take(10).toSet();

        final selectedIds = ExerciseQuestionSelector.select(
          availableQuestionIds: availableIds,
          previousSessionIds: previousIds,
          random: Random(3),
        );

        expect(selectedIds, hasLength(10));
        expect(selectedIds, contains('questao-11'));
        expect(selectedIds, contains('questao-12'));
      },
    );

    test('não seleciona mais questões do que existem no banco', () {
      final selectedIds = ExerciseQuestionSelector.select(
        availableQuestionIds: const ['q1', 'q2', 'q3'],
        questionCount: 10,
        random: Random(4),
      );

      expect(selectedIds, hasLength(3));
      expect(selectedIds.toSet(), {'q1', 'q2', 'q3'});
    });

    test('remove identificadores duplicados do banco', () {
      final selectedIds = ExerciseQuestionSelector.select(
        availableQuestionIds: const ['q1', 'q1', 'q2', 'q2'],
        questionCount: 10,
        random: Random(5),
      );

      expect(selectedIds, hasLength(2));
      expect(selectedIds.toSet(), {'q1', 'q2'});
    });

    test('retorna lista vazia quando não há questões ou quantidade válida', () {
      expect(
        ExerciseQuestionSelector.select(availableQuestionIds: const <String>[]),
        isEmpty,
      );

      expect(
        ExerciseQuestionSelector.select(
          availableQuestionIds: const ['q1'],
          questionCount: 0,
        ),
        isEmpty,
      );
    });
  });
}
