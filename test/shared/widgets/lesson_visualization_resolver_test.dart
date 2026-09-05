import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/continuity_course_data.dart';
import 'package:calcquest/shared/data/derivatives_course_data.dart';
import 'package:calcquest/shared/data/limits_course_data.dart';
import 'package:calcquest/shared/widgets/calculus_visualizations.dart';
import 'package:calcquest/shared/widgets/lesson_visualization_resolver.dart';

void main() {
  test('maps the first limit lesson to the limit visualization', () {
    final lesson = limitsCourseLessons.firstWhere(
      (item) => item.id == 'limites-01-intuicao',
    );

    expect(
      lessonVisualizationFor(lesson, isEnglish: false),
      isA<LimitApproachVisualization>(),
    );
  });

  test('maps the first continuity lesson to the continuity visualization', () {
    final lesson = continuityCourseLessons.firstWhere(
      (item) => item.id == 'continuidade-01-significado',
    );

    expect(
      lessonVisualizationFor(lesson, isEnglish: false),
      isA<ContinuityVisualization>(),
    );
  });

  test('maps the first derivative lesson to the tangent visualization', () {
    final lesson = derivativesCourseLessons.firstWhere(
      (item) => item.id == 'derivadas-01-significado',
    );

    expect(
      lessonVisualizationFor(lesson, isEnglish: false),
      isA<DerivativeTangentVisualization>(),
    );
  });

  test('does not add a visualization to unrelated lessons', () {
    final lesson = limitsCourseLessons.firstWhere(
      (item) => item.id != 'limites-01-intuicao',
    );

    expect(lessonVisualizationFor(lesson, isEnglish: false), isNull);
  });
}
