import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/limits_course_data.dart';

void main() {
  group('Integridade do curso de Limites', () {
    test('possui sete aulas autorais e progressivas', () {
      expect(limitsCourseLessons, hasLength(7));

      final ids = limitsCourseLessons.map((lesson) => lesson.id).toList();

      expect(ids.toSet(), hasLength(ids.length));
      expect(
        ids,
        equals([
          'limites-01-intuicao',
          'limites-02-laterais',
          'limites-03-propriedades',
          'limites-04-fatoracao',
          'limites-05-racionalizacao',
          'limites-06-infinito',
          'limites-07-sintese',
        ]),
      );
    });

    test('todas as aulas possuem conteúdo pedagógico completo', () {
      for (final lesson in limitsCourseLessons) {
        expect(lesson.topicId, 'limites');
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
  });
}
