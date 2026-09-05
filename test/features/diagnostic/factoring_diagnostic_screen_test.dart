import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/features/diagnostic/presentation/factoring_diagnostic_screen.dart';

void main() {
  const localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        supportedLocales: <Locale>[Locale('pt')],
        localizationsDelegates: localizationsDelegates,
        home: FactoringDiagnosticScreen(sourceSkill: 'Diferença de quadrados'),
      ),
    );
  }

  testWidgets('diagnóstico começa sem alterar progresso e exige três respostas', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(find.text('Diagnóstico curto: fatoração em limites'), findsOneWidget);
    expect(
      find.textContaining('Nada aqui altera sua nota ou progresso'),
      findsOneWidget,
    );
    expect(find.text('O resultado é inconclusivo'), findsNothing);
    expect(find.text('Pontos que merecem revisão'), findsNothing);
  });

  testWidgets('três respostas corretas produzem resultado inconclusivo', (
    tester,
  ) async {
    await pumpScreen(tester);

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
    expect(find.text('Pontos que merecem revisão'), findsNothing);
    expect(
      find.textContaining('não é uma nota nem um diagnóstico definitivo'),
      findsOneWidget,
    );
  });

  testWidgets('erro específico gera hipótese de revisão do pré-requisito', (
    tester,
  ) async {
    await pumpScreen(tester);

    final wrongFactoring = find.text('(x − 9)(x + 1)');
    await tester.ensureVisible(wrongFactoring);
    await tester.tap(wrongFactoring);
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

    expect(find.text('A evidência ficou mista'), findsOneWidget);
    expect(find.text('Pontos que merecem revisão'), findsOneWidget);
    expect(
      find.text('Reconhecer e fatorar uma diferença de quadrados'),
      findsOneWidget,
    );
    expect(
      find.text('Cancelar um fator comum depois de fatorar'),
      findsNothing,
    );
    expect(
      find.textContaining('hipóteses de estudo obtidas a partir de três questões'),
      findsOneWidget,
    );
  });
}
