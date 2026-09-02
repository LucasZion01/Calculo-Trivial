import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/derivatives_course_data.dart';
import 'package:calcquest/shared/data/mock_derivatives_exercise_data.dart';

void main() {
  group('Integridade do curso de Derivadas', () {
    test('possui oito aulas autorais e progressivas', () {
      expect(derivativesCourseLessons, hasLength(8));

      final ids = derivativesCourseLessons.map((lesson) => lesson.id).toList();

      expect(ids.toSet(), hasLength(ids.length));
      expect(
        ids,
        equals([
          'derivadas-01-significado',
          'derivadas-02-regras-basicas',
          'derivadas-03-produto-quociente',
          'derivadas-04-cadeia',
          'derivadas-05-elementares',
          'derivadas-06-tangente',
          'derivadas-07-derivabilidade',
          'derivadas-08-aplicacoes',
        ]),
      );
    });

    test('todas as aulas possuem estrutura pedagógica completa', () {
      for (final lesson in derivativesCourseLessons) {
        expect(lesson.topicId, 'derivadas');
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
      final lessonIds = derivativesCourseLessons
          .map((lesson) => lesson.id)
          .toSet();
      final coveredLessonIds = <String>{};

      expect(mockDerivativesExercises, hasLength(20));

      for (final exercise in mockDerivativesExercises) {
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
