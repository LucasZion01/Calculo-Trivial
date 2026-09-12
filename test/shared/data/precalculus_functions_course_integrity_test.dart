import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/precalculus_functions_course_data.dart';

void main() {
  group('Integridade da trilha de Funções de Pré-Cálculo', () {
    test('possui as quatorze aulas canônicas em ordem', () {
      final ids = precalculusFunctionsCourseLessons
          .map((lesson) => lesson.id)
          .toList();

      expect(
        ids,
        equals([
          'funcoes-01-conceito-dominio-imagem',
          'funcoes-02-composicao-inversa',
          'funcoes-03-transformacoes-graficos',
          'funcoes-04-polinomiais',
          'funcoes-05-racionais',
          'funcoes-06-exponenciais',
          'funcoes-07-logaritmos',
          'funcoes-08-radianos-circulo',
          'funcoes-09-trigonometricas-graficos',
          'funcoes-10-identidades-equacoes-trig',
          'funcoes-11-inversas-trig',
          'funcoes-12-geometria-analitica',
          'funcoes-13-conicas',
          'funcoes-14-taxa-media-sintese',
        ]),
      );
      expect(ids.toSet(), hasLength(ids.length));
    });

    test('todas as aulas permanecem no módulo seguro de Funções', () {
      for (final lesson in precalculusFunctionsCourseLessons) {
        expect(lesson.topicId, 'funcoes');
      }
    });

    test('todas as aulas possuem estrutura pedagógica completa', () {
      for (final lesson in precalculusFunctionsCourseLessons) {
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
      final portugueseIds = precalculusFunctionsCourseLessons
          .map((lesson) => lesson.id)
          .toList();
      final englishIds = localizedPrecalculusFunctionsCourseLessons(
        const Locale('en'),
      ).map((lesson) => lesson.id).toList();

      expect(englishIds, equals(portugueseIds));
    });
  });
}
