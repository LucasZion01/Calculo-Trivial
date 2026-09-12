import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/precalculus_equations_supplement_data.dart';

void main() {
  group('Integridade do suplemento de Equações de Pré-Cálculo', () {
    test('possui as três lacunas canônicas adicionadas', () {
      final ids = precalculusEquationsSupplementLessons
          .map((lesson) => lesson.id)
          .toList();

      expect(
        ids,
        equals([
          'equations-09-radicais',
          'equations-10-inequacoes-quadraticas',
          'equations-11-inequacoes-racionais',
        ]),
      );
    });

    test('todas as aulas permanecem no módulo seguro de Equações', () {
      for (final lesson in precalculusEquationsSupplementLessons) {
        expect(lesson.topicId, 'equacoes-inequacoes');
        expect(lesson.objective.trim(), isNotEmpty);
        expect(lesson.sections.length, greaterThanOrEqualTo(3));
        expect(lesson.takeaways.length, greaterThanOrEqualTo(4));
        expect(lesson.check.question.trim(), isNotEmpty);
        expect(lesson.check.choices.length, greaterThanOrEqualTo(3));
        expect(lesson.check.correctIndex, inInclusiveRange(0, lesson.check.choices.length - 1));
      }
    });

    test('IDs permanecem iguais em português e inglês', () {
      final portugueseIds = precalculusEquationsSupplementLessons
          .map((lesson) => lesson.id)
          .toList();
      final englishIds = localizedPrecalculusEquationsSupplementLessons(
        const Locale('en'),
      ).map((lesson) => lesson.id).toList();

      expect(englishIds, equals(portugueseIds));
    });
  });
}
