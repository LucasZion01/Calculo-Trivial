import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/widgets/advanced_calculus_visualizations.dart';

Widget _host(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('function transformation switches range', (tester) async {
    await tester.pumpWidget(
      _host(const FunctionDomainTransformVisualization(isEnglish: false)),
    );

    expect(find.text('Im = [0, +∞)'), findsOneWidget);

    await tester.tap(find.text('x² + 2'));
    await tester.pumpAndSettle();

    expect(find.text('Im = [2, +∞)'), findsOneWidget);
  });

  testWidgets('one-sided limit shows different lateral limits', (tester) async {
    await tester.pumpWidget(
      _host(const OneSidedLimitVisualization(isEnglish: false)),
    );

    expect(find.text('lim x→0⁻ = 1'), findsOneWidget);
    expect(find.text('lim x→0⁺ = 3'), findsOneWidget);
  });

  testWidgets('discontinuity visualization changes type', (tester) async {
    await tester.pumpWidget(
      _host(const DiscontinuityTypesVisualization(isEnglish: false)),
    );

    expect(find.text('Tipo = Removível'), findsOneWidget);

    await tester.tap(find.text('Salto'));
    await tester.pumpAndSettle();

    expect(find.text('Tipo = Salto'), findsOneWidget);
  });

  testWidgets('secant visualization exposes derivative target', (tester) async {
    await tester.pumpWidget(
      _host(const SecantToTangentVisualization(isEnglish: false)),
    );

    expect(find.text('f′(1) = 2'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });

  testWidgets('asymptote visualization identifies x equals zero', (tester) async {
    await tester.pumpWidget(
      _host(const AsymptoteVisualization(isEnglish: false)),
    );

    expect(find.text('assíntota = x = 0'), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
  });
}
