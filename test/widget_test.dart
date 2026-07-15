import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/main.dart';

void main() {
  testWidgets('CalcQuest inicia sem erros', (WidgetTester tester) async {
    await tester.pumpWidget(const CalcQuestApp());

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}