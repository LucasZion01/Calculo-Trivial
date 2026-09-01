import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/learning_content.dart';

void main() {
  testWidgets('cartão de checagem explica erro e permite nova tentativa', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        supportedLocales: [Locale('pt')],
        home: Scaffold(
          body: SingleChildScrollView(
            child: LessonCheckCard(
              question: 'O que significa 0/0 em um limite?',
              choices: [
                'O limite é zero.',
                'A expressão precisa de nova análise.',
              ],
              correctIndex: 1,
              explanation: 'A forma 0/0 é indeterminada.',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Cheque seu entendimento'), findsOneWidget);

    await tester.tap(find.text('O limite é zero.'));
    await tester.pump();

    expect(find.textContaining('Quase!'), findsOneWidget);
    expect(find.textContaining('indeterminada'), findsOneWidget);

    await tester.tap(find.text('Responder novamente'));
    await tester.pump();

    await tester.tap(find.text('A expressão precisa de nova análise.'));
    await tester.pump();

    expect(find.textContaining('Muito bem!'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('cabeçalho de aula apresenta objetivo e duração', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('pt'),
        supportedLocales: [Locale('pt')],
        home: Scaffold(
          body: LessonHeroCard(
            eyebrow: 'Aula 1',
            title: 'Limites',
            description: 'Entenda aproximações.',
            duration: '10 min',
            objective: 'interpretar um limite',
            symbol: 'lim',
          ),
        ),
      ),
    );

    expect(find.text('Limites'), findsOneWidget);
    expect(find.text('10 min'), findsOneWidget);
    expect(
      find.text('Ao final, você será capaz de interpretar um limite.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
