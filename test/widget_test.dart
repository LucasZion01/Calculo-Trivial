import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/main.dart';

void main() {
  testWidgets('Cálculo Trivial inicia sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(
      const CalcQuestApp(
        home: Scaffold(body: Center(child: Text('Cálculo Trivial'))),
      ),
    );

    await tester.pump();

    expect(find.text('Cálculo Trivial'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
