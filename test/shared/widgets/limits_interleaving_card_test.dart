import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/limits_interleaving_card.dart';

void main() {
  testWidgets('seleciona racionalização para limite com radical', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsInterleavingCard(isEnglish: false),
          ),
        ),
      ),
    );

    expect(find.text('Escolha a estratégia'), findsOneWidget);
    expect(find.textContaining('lim x→9'), findsOneWidget);

    final correctChoice = find.text('Racionalizar com o conjugado');
    await tester.ensureVisible(correctChoice);
    await tester.tap(correctChoice);
    await tester.pump();

    expect(
      find.textContaining('Correto. A substituição direta revela 0/0'),
      findsOneWidget,
    );
    expect(
      find.textContaining('não altera nota nem progresso'),
      findsOneWidget,
    );
  });

  testWidgets('estratégia inadequada orienta a discriminar a forma', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsInterleavingCard(isEnglish: false),
          ),
        ),
      ),
    );

    final wrongChoice = find.text('Fatorar uma diferença de quadrados');
    await tester.ensureVisible(wrongChoice);
    await tester.tap(wrongChoice);
    await tester.pump();

    expect(
      find.textContaining('Use a forma da expressão para escolher o método'),
      findsOneWidget,
    );
  });
}
