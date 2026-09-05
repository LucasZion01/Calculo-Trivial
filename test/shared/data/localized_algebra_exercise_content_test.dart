import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/localized_algebra_exercise_content.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';

void main() {
  test('normaliza quebras de linha literais em português', () {
    for (final exercise in mockExercises) {
      final localized = localizeAlgebraExerciseContent(
        exercise,
        const Locale('pt'),
      );

      expect(
        localized.statement.contains(r'\n'),
        isFalse,
        reason: 'A questão ${exercise.id} ainda contém \\n literal.',
      );
    }
  });

  test('preserva quebra de linha real no exercício de divisão de monômios', () {
    final exercise = mockExercises.firstWhere(
      (item) => item.id == 'divisao-monomios-1',
    );

    final localized = localizeAlgebraExerciseContent(
      exercise,
      const Locale('pt'),
    );

    expect(
      localized.statement,
      'Simplifique a expressão:\n(12x³y²) / (3xy)',
    );
  });

  test('mantém a tradução em inglês com quebra de linha real', () {
    final exercise = mockExercises.firstWhere(
      (item) => item.id == 'divisao-monomios-1',
    );

    final localized = localizeAlgebraExerciseContent(
      exercise,
      const Locale('en'),
    );

    expect(
      localized.statement,
      'Simplify the expression:\n(12x³y²) / (3xy)',
    );
  });
}
