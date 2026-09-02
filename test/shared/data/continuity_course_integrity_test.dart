import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/continuity_course_data.dart';
import 'package:calcquest/shared/data/mock_continuity_exercise_data.dart';

void main() {
  group('Integridade do curso de Continuidade', () {
    test('possui sete aulas autorais e progressivas', () {
      expect(continuityCourseLessons, hasLength(7));

      final ids = continuityCourseLessons.map((lesson) => lesson.id).toList();

      expect(ids.toSet(), hasLength(ids.length));
      expect(
        ids,
        equals([
          'continuidade-01-significado',
          'continuidade-02-dominio',
          'continuidade-03-descontinuidades',
          'continuidade-04-partes',
          'continuidade-05-parametros',
          'continuidade-06-valor-intermediario',
          'continuidade-07-sintese',
        ]),
      );
    });

    test('todas as aulas possuem estrutura pedagógica completa', () {
      for (final lesson in continuityCourseLessons) {
        expect(lesson.topicId, 'continuidade');
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
      final lessonIds = continuityCourseLessons
          .map((lesson) => lesson.id)
          .toSet();
      final coveredLessonIds = <String>{};

      expect(mockContinuityExercises, hasLength(20));

      for (final exercise in mockContinuityExercises) {
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
