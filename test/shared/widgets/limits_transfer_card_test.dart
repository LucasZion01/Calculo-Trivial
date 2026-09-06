import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/limits_transfer_card.dart';

void main() {
  testWidgets('transfere fatoração para contexto de engenharia', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsTransferCard(isEnglish: false),
          ),
        ),
      ),
    );

    expect(find.text('Aplique em um novo contexto'), findsOneWidget);
    expect(find.textContaining('modelo de engenharia'), findsOneWidget);

    final correctChoice = find.textContaining('Fatorar u² − 25');
    await tester.ensureVisible(correctChoice);
    await tester.tap(correctChoice);
    await tester.pump();

    expect(find.textContaining('O contexto mudou'), findsOneWidget);
    expect(
      find.textContaining('não altera nota nem progresso'),
      findsOneWidget,
    );
  });

  testWidgets('erro orienta a focar na estrutura matemática', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsTransferCard(isEnglish: false),
          ),
        ),
      ),
    );

    final wrongChoice = find.textContaining('se aproxima de zero');
    await tester.ensureVisible(wrongChoice);
    await tester.tap(wrongChoice);
    await tester.pump();

    expect(
      find.textContaining('Concentre-se na estrutura matemática'),
      findsOneWidget,
    );
  });
}
