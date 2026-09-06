import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/limits_multiple_representations_card.dart';

void main() {
  testWidgets('conecta expressão, tabela e comportamento do limite', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsMultipleRepresentationsCard(isEnglish: false),
          ),
        ),
      ),
    );

    expect(
      find.text('Mesmo limite, representações diferentes'),
      findsOneWidget,
    );
    expect(find.text('Algébrica'), findsOneWidget);
    expect(find.text('Tabela numérica'), findsOneWidget);
    expect(find.text('Comportamento'), findsOneWidget);
    expect(find.text('1.99'), findsOneWidget);
    expect(find.text('3.99'), findsOneWidget);

    final correctChoice = find.textContaining('O limite é 4');
    await tester.ensureVisible(correctChoice);
    await tester.tap(correctChoice);
    await tester.pump();

    expect(
      find.textContaining('Correto. Algebricamente'),
      findsOneWidget,
    );
  });

  testWidgets('erro diferencia valor no ponto de comportamento próximo', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsMultipleRepresentationsCard(isEnglish: false),
          ),
        ),
      ),
    );

    final wrongChoice = find.textContaining('O limite é 0');
    await tester.ensureVisible(wrongChoice);
    await tester.tap(wrongChoice);
    await tester.pump();

    expect(
      find.textContaining('Separe o valor em x = 2'),
      findsOneWidget,
    );
    expect(
      find.textContaining('não altera nota nem progresso'),
      findsOneWidget,
    );
  });
}
