import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/limits_progressive_scaffolding_card.dart';

void main() {
  testWidgets('revela suporte em níveis sem entregar o valor final', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsProgressiveScaffoldingCard(isEnglish: false),
          ),
        ),
      ),
    );

    expect(find.text('Suporte progressivo'), findsOneWidget);
    expect(find.text('Pista 1'), findsNothing);
    expect(find.text('Pista 2'), findsNothing);
    expect(find.text('Próximo passo mostrado'), findsNothing);

    await tester.tap(find.text('Revelar primeira pista'));
    await tester.pump();
    expect(find.text('Pista 1'), findsOneWidget);
    expect(find.text('Pista 2'), findsNothing);

    await tester.tap(find.text('Preciso de outra pista'));
    await tester.pump();
    expect(find.text('Pista 2'), findsOneWidget);
    expect(find.text('Próximo passo mostrado'), findsNothing);

    await tester.tap(find.text('Mostrar o próximo passo'));
    await tester.pump();
    expect(find.text('Próximo passo mostrado'), findsOneWidget);
    expect(
      find.textContaining('O suporte termina antes do valor final'),
      findsOneWidget,
    );
    expect(find.textContaining('= 8'), findsNothing);
  });

  testWidgets('mantém explícito que o suporte é opcional e sem pontuação', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsProgressiveScaffoldingCard(isEnglish: false),
          ),
        ),
      ),
    );

    expect(
      find.textContaining('Este suporte é opcional e não altera nota nem progresso'),
      findsOneWidget,
    );
  });
}
