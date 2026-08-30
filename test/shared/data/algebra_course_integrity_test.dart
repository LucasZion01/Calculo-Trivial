import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/algebra_course_data.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';

void main() {
  group('Integridade do curso de Álgebra Fundamental', () {
    test('possui oito aulas autorais e progressivas', () {
      expect(algebraCourseLessons, hasLength(8));

      final ids = algebraCourseLessons.map((lesson) => lesson.id).toList();

      expect(ids.toSet(), hasLength(ids.length));
      expect(
        ids,
        equals([
          'algebra-01-linguagem',
          'algebra-02-termos-semelhantes',
          'algebra-03-distributiva',
          'algebra-04-potencias',
          'algebra-05-produtos-notaveis',
          'algebra-06-fatoracao',
          'algebra-07-fracoes-algebricas',
          'algebra-08-sintese',
        ]),
      );
    });

    test('todas as aulas possuem estrutura pedagógica completa', () {
      for (final lesson in algebraCourseLessons) {
        expect(lesson.topicId, 'algebra-fundamental');
        expect(lesson.title.trim(), isNotEmpty);
        expect(lesson.description.trim(), isNotEmpty);
        expect(lesson.objective.trim(), isNotEmpty);
        expect(lesson.sections.length, greaterThanOrEqualTo(2));
        expect(lesson.takeaways.length, greaterThanOrEqualTo(3));
        expect(lesson.closing.trim(), isNotEmpty);

        for (final section in lesson.sections) {
          expect(section.title.trim(), isNotEmpty);
          expect(section.blocks, isNotEmpty);
        }

        expect(lesson.check.question.trim(), isNotEmpty);
        expect(lesson.check.choices.length, greaterThanOrEqualTo(3));
        expect(lesson.check.correctIndex, greaterThanOrEqualTo(0));
        expect(
          lesson.check.correctIndex,
          lessThan(lesson.check.choices.length),
        );
        expect(lesson.check.explanation.trim(), isNotEmpty);
      }
    });

    test('as vinte atividades cobrem todas as aulas', () {
      final lessonIds = algebraCourseLessons.map((lesson) => lesson.id).toSet();
      final coveredLessonIds = <String>{};

      expect(mockExercises, hasLength(20));

      for (final exercise in mockExercises) {
        expect(
          lessonIds,
          contains(exercise.contentLessonId),
          reason: '${exercise.id} aponta para uma aula inexistente.',
        );
        expect(
          exercise.skill?.trim(),
          isNotEmpty,
          reason: '${exercise.id} não informa a habilidade avaliada.',
        );
        expect(
          exercise.explanation.trim().length,
          greaterThanOrEqualTo(60),
          reason: '${exercise.id} precisa de uma explicação mais completa.',
        );

        coveredLessonIds.add(exercise.contentLessonId!);
      }

      expect(
        coveredLessonIds,
        equals(lessonIds),
        reason: 'Cada aula precisa ter ao menos uma atividade relacionada.',
      );
    });
  });
}
