import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/features/diagnostic/presentation/factoring_prerequisite_microlesson_screen.dart';
import 'package:calcquest/shared/domain/factoring_diagnostic.dart';

void main() {
  const localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  testWidgets('microlição mostra somente o pré-requisito solicitado', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        supportedLocales: <Locale>[Locale('pt')],
        localizationsDelegates: localizationsDelegates,
        home: FactoringPrerequisiteMicrolessonScreen(
          prerequisites: <FactoringPrerequisite>[
            FactoringPrerequisite.commonFactorCancellation,
          ],
        ),
      ),
    );

    expect(find.text('Microlição de pré-requisito'), findsOneWidget);
    expect(find.text('Cancele fatores comuns, não termos'), findsOneWidget);
    expect(find.text('Diferença de quadrados'), findsNothing);
    expect(
      find.textContaining('não altera sua nota nem seu progresso'),
      findsOneWidget,
    );
  });

  testWidgets('questão equivalente permite aplicar a revisão em novo limite', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        supportedLocales: <Locale>[Locale('pt')],
        localizationsDelegates: localizationsDelegates,
        home: FactoringPrerequisiteMicrolessonScreen(
          prerequisites: <FactoringPrerequisite>[
            FactoringPrerequisite.differenceOfSquares,
          ],
        ),
      ),
    );

    final title = find.text('Questão equivalente');
    await tester.ensureVisible(title);
    await tester.pumpAndSettle();
    expect(title, findsOneWidget);
    expect(
      find.text('Calcule: lim x→5 (x² − 25)/(x − 5)'),
      findsOneWidget,
    );

    final correctAnswer = find.text('10');
    await tester.ensureVisible(correctAnswer);
    await tester.pumpAndSettle();
    await tester.tap(correctAnswer);
    await tester.pump();

    expect(find.textContaining('Correto. Fatore x² − 25'), findsOneWidget);
    expect(
      find.textContaining('também não altera sua nota nem seu progresso'),
      findsOneWidget,
    );
  });
}
