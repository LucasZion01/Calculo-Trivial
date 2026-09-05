import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/guided_factoring_practice_card.dart';

Widget buildCard({bool isEnglish = false}) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: GuidedFactoringPracticeCard(isEnglish: isEnglish),
      ),
    ),
  );
}

void main() {
  testWidgets('prática guiada pede apenas a etapa faltante', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildCard());

    expect(find.text('PRÁTICA GUIADA'), findsOneWidget);
    expect(find.text('Complete a etapa de fatoração que falta'), findsOneWidget);
    expect(find.text('(x − 4)(x + 4)'), findsOneWidget);
    expect(find.textContaining('Correto.'), findsNothing);
  });

  testWidgets('resposta correta explica o passo sem pontuação', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildCard());

    await tester.tap(find.text('(x − 4)(x + 4)'));
    await tester.pump();

    expect(find.textContaining('Correto.'), findsOneWidget);
    expect(find.textContaining('diferença de quadrados'), findsOneWidget);
    expect(find.textContaining('XP'), findsNothing);
    expect(find.textContaining('ouro'), findsNothing);
  });

  testWidgets('resposta incorreta orienta revisão do padrão', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildCard());

    await tester.tap(find.text('(x − 4)(x + 1)'));
    await tester.pump();

    expect(
      find.textContaining('Revise o padrão da diferença de quadrados'),
      findsOneWidget,
    );
  });

  testWidgets('versão em inglês mantém o mesmo fluxo', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildCard(isEnglish: true));

    expect(find.text('GUIDED PRACTICE'), findsOneWidget);
    expect(find.text('Complete the missing factoring step'), findsOneWidget);
  });
}
