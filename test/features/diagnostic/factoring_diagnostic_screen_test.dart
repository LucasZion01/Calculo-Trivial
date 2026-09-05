import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/features/diagnostic/presentation/factoring_diagnostic_screen.dart';

void main() {
  testWidgets('diagnóstico começa sem alterar progresso e exige três respostas', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: FactoringDiagnosticScreen(sourceSkill: 'Diferença de quadrados'),
      ),
    );

    expect(find.text('Diagnóstico curto: fatoração em limites'), findsOneWidget);
    expect(
      find.textContaining('Nada aqui altera sua nota ou progresso'),
      findsOneWidget,
    );

    await tester.ensureVisible(find.text('Ver resultado'));
    final submitButton = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton).last,
    );
    expect(submitButton.onPressed, isNull);
  });

  testWidgets('três respostas corretas produzem resultado inconclusivo', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: FactoringDiagnosticScreen(sourceSkill: 'Diferença de quadrados'),
      ),
    );

    final firstAnswer = find.text('(x − 3)(x + 3)');
    await tester.ensureVisible(firstAnswer);
    await tester.tap(firstAnswer);
    await tester.pump();

    final secondAnswer = find.text('x + 3');
    await tester.ensureVisible(secondAnswer);
    await tester.tap(secondAnswer);
    await tester.pump();

    final thirdAnswer =
        find.text('A forma atual é indeterminada e precisa ser transformada');
    await tester.ensureVisible(thirdAnswer);
    await tester.tap(thirdAnswer);
    await tester.pump();

    final submit = find.text('Ver resultado');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('O resultado é inconclusivo'), findsOneWidget);
    expect(find.textContaining('3/3 questões de pré-requisito'), findsOneWidget);
    expect(
      find.textContaining('não uma nota nem um diagnóstico definitivo'),
      findsOneWidget,
    );
  });
}
