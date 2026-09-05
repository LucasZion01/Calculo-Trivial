import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/calculus_visualizations.dart';

Widget _host(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    ),
  );
}

void main() {
  testWidgets('limit visualization exposes approach controls', (tester) async {
    await tester.pumpWidget(
      _host(const LimitApproachVisualization(isEnglish: false)),
    );

    expect(find.textContaining('Aproxime x de 3'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
    expect(find.textContaining('L = 7'), findsOneWidget);
  });

  testWidgets('continuity visualization switches between states', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(const ContinuityVisualization(isEnglish: false)),
    );

    expect(find.byType(SegmentedButton<bool>), findsOneWidget);
    expect(find.textContaining('função é contínua'), findsOneWidget);

    final holeButton = find.text('Com furo');
    await tester.ensureVisible(holeButton);
    await tester.tap(holeButton);
    await tester.pumpAndSettle();

    expect(find.textContaining('continuidade falha'), findsOneWidget);
  });

  testWidgets('derivative visualization exposes tangent slope', (tester) async {
    await tester.pumpWidget(
      _host(const DerivativeTangentVisualization(isEnglish: false)),
    );

    expect(find.textContaining('tangente'), findsWidgets);
    expect(find.byType(Slider), findsOneWidget);
    expect(find.textContaining("f'(x) = 2.0"), findsOneWidget);
  });
}
