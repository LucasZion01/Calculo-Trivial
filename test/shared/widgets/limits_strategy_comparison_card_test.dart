import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/limits_strategy_comparison_card.dart';

void main() {
  testWidgets('compara papéis das estratégias e explica a escolha correta', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsStrategyComparisonCard(isEnglish: false),
          ),
        ),
      ),
    );

    expect(find.text('Compare estratégias'), findsOneWidget);
    expect(find.textContaining('Estratégia A — substituição direta'), findsOneWidget);
    expect(find.textContaining('Estratégia B — fatorar primeiro'), findsOneWidget);

    final correctChoice = find.textContaining('A diagnostica o obstáculo');
    await tester.ensureVisible(correctChoice);
    await tester.tap(correctChoice);
    await tester.pump();

    expect(
      find.textContaining('Correto. A substituição direta é útil primeiro'),
      findsOneWidget,
    );
    expect(
      find.textContaining('não altera nota nem progresso'),
      findsOneWidget,
    );
  });

  testWidgets('alternativa inadequada orienta a rever o papel de cada estratégia', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsStrategyComparisonCard(isEnglish: false),
          ),
        ),
      ),
    );

    final wrongChoice = find.textContaining('0/0 significa que o limite é zero');
    await tester.ensureVisible(wrongChoice);
    await tester.tap(wrongChoice);
    await tester.pump();

    expect(
      find.textContaining('Revise o papel de cada estratégia'),
      findsOneWidget,
    );
  });
}
