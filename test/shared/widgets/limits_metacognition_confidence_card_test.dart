import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/limits_metacognition_confidence_card.dart';

void main() {
  testWidgets('compara confiança baixa com resposta correta', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsMetacognitionConfidenceCard(isEnglish: false),
          ),
        ),
      ),
    );

    expect(find.text('Cheque sua confiança'), findsOneWidget);

    final strategy = find.text('Racionalizar com o conjugado');
    expect(tester.widget<OutlinedButton>(find.ancestor(
      of: strategy,
      matching: find.byType(OutlinedButton),
    )).onPressed, isNull);

    await tester.tap(find.text('Baixa'));
    await tester.pump();

    await tester.ensureVisible(strategy);
    await tester.tap(strategy);
    await tester.pump();

    expect(
      find.textContaining('Seu resultado foi melhor que sua confiança inicial'),
      findsOneWidget,
    );
    expect(find.textContaining('Confiança é uma previsão, não uma nota'), findsOneWidget);
  });

  testWidgets('confiança alta com erro gera feedback de recalibração', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        home: Scaffold(
          body: SingleChildScrollView(
            child: LimitsMetacognitionConfidenceCard(isEnglish: false),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Alta'));
    await tester.pump();

    final wrongChoice = find.text('Fatoração polinomial');
    await tester.ensureVisible(wrongChoice);
    await tester.tap(wrongChoice);
    await tester.pump();

    expect(
      find.textContaining('Sua confiança estava alta, mas esta tentativa não foi correta'),
      findsOneWidget,
    );
  });
}
