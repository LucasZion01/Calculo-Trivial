import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/function_visualization_card.dart';

void main() {
  testWidgets('shows the function, current values and interaction control', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FunctionVisualizationCard(isEnglish: false),
        ),
      ),
    );

    expect(find.text('f(x) = 2x + 1'), findsOneWidget);
    expect(find.text('x = 1'), findsOneWidget);
    expect(find.text('f(x) = 3'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets);
  });

  testWidgets('uses English explanatory copy when requested', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: FunctionVisualizationCard(isEnglish: true),
        ),
      ),
    );

    expect(
      find.text('Move x and watch the point change on the graph.'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Every chosen x produces exactly one y-value.'),
      findsOneWidget,
    );
  });
}
