import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/limits_example_variability_card.dart';

void main() {
  testWidgets('reconhece a mesma estrutura em exemplos variados', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsExampleVariabilityCard(isEnglish: false),
          ),
        ),
      ),
    );

    expect(find.text('Mude o exemplo, preserve a estrutura'), findsOneWidget);
    expect(find.textContaining('lim x→3'), findsOneWidget);
    expect(find.textContaining('lim x→−2'), findsOneWidget);
    expect(find.textContaining('lim x→2 (x² + 1)'), findsOneWidget);

    final correctChoice = find.text('A e B');
    await tester.ensureVisible(correctChoice);
    await tester.tap(correctChoice);
    await tester.pump();

    expect(
      find.textContaining('Correto. A e B produzem 0/0'),
      findsOneWidget,
    );
    expect(
      find.textContaining('não altera nota nem progresso'),
      findsOneWidget,
    );
  });

  testWidgets('contraste inadequado destaca a diferença estrutural', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsExampleVariabilityCard(isEnglish: false),
          ),
        ),
      ),
    );

    final wrongChoice = find.text('A e C');
    await tester.ensureVisible(wrongChoice);
    await tester.tap(wrongChoice);
    await tester.pump();

    expect(
      find.textContaining('Compare a estrutura, não apenas os números'),
      findsOneWidget,
    );
  });
}
