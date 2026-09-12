import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/precalculus_foundations_course_data.dart';

void main() {
  group('Integridade dos fundamentos de Pré-Cálculo', () {
    test('possui cinco aulas preparatórias em ordem canônica', () {
      expect(precalculusFoundationsCourseLessons, hasLength(5));

      final ids = precalculusFoundationsCourseLessons
          .map((lesson) => lesson.id)
          .toList();

      expect(ids.toSet(), hasLength(ids.length));
      expect(
        ids,
        equals([
          'precalculo-00-01-reais',
          'precalculo-00-02-operacoes',
          'precalculo-00-03-linguagem',
          'precalculo-00-04-potencias-raizes',
          'precalculo-00-05-modulo',
        ]),
      );
    });

    test('preserva o módulo seguro de Álgebra Fundamental', () {
      for (final lesson in precalculusFoundationsCourseLessons) {
        expect(lesson.topicId, 'algebra-fundamental');
      }
    });

    test('todas as aulas possuem estrutura pedagógica completa', () {
      for (final lesson in precalculusFoundationsCourseLessons) {
        expect(lesson.title.trim(), isNotEmpty);
        expect(lesson.description.trim(), isNotEmpty);
        expect(lesson.duration.trim(), isNotEmpty);
        expect(lesson.objective.trim(), isNotEmpty);
        expect(lesson.sections.length, greaterThanOrEqualTo(3));
        expect(lesson.takeaways.length, greaterThanOrEqualTo(4));
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

    test('IDs em português e inglês permanecem alinhados', () {
      final portugueseIds = precalculusFoundationsCourseLessons
          .map((lesson) => lesson.id)
          .toList();
      final englishIds = localizedPrecalculusFoundationsCourseLessons(
        const Locale('en'),
      ).map((lesson) => lesson.id).toList();

      expect(englishIds, equals(portugueseIds));
    });
  });
}
