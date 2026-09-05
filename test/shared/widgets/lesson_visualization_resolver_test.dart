import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/data/continuity_course_data.dart';
import 'package:calcquest/shared/data/derivatives_course_data.dart';
import 'package:calcquest/shared/data/limits_course_data.dart';
import 'package:calcquest/shared/widgets/advanced_calculus_visualizations.dart';
import 'package:calcquest/shared/widgets/calculus_visualizations.dart';
import 'package:calcquest/shared/widgets/lesson_visualization_resolver.dart';

void main() {
  test('maps the initial limit lesson to the approach visualization', () {
    final lesson = limitsCourseLessons.firstWhere(
      (item) => item.id == 'limites-01-intuicao',
    );

    expect(
      lessonVisualizationFor(lesson, isEnglish: false),
      isA<LimitApproachVisualization>(),
    );
  });

  test('maps one-sided limits and infinity lessons', () {
    final oneSided = limitsCourseLessons.firstWhere(
      (item) => item.id == 'limites-02-laterais',
    );
    final infinity = limitsCourseLessons.firstWhere(
      (item) => item.id == 'limites-06-infinito',
    );

    expect(
      lessonVisualizationFor(oneSided, isEnglish: false),
      isA<OneSidedLimitVisualization>(),
    );
    expect(
      lessonVisualizationFor(infinity, isEnglish: false),
      isA<AsymptoteVisualization>(),
    );
  });

  test('maps continuity meaning and discontinuity types lessons', () {
    final meaning = continuityCourseLessons.firstWhere(
      (item) => item.id == 'continuidade-01-significado',
    );
    final types = continuityCourseLessons.firstWhere(
      (item) => item.id == 'continuidade-03-descontinuidades',
    );

    expect(
      lessonVisualizationFor(meaning, isEnglish: false),
      isA<ContinuityVisualization>(),
    );
    expect(
      lessonVisualizationFor(types, isEnglish: false),
      isA<DiscontinuityTypesVisualization>(),
    );
  });

  test('maps derivative meaning and secant to tangent lessons', () {
    final meaning = derivativesCourseLessons.firstWhere(
      (item) => item.id == 'derivadas-01-significado',
    );
    final tangent = derivativesCourseLessons.firstWhere(
      (item) => item.id == 'derivadas-06-tangente',
    );

    expect(
      lessonVisualizationFor(meaning, isEnglish: false),
      isA<DerivativeTangentVisualization>(),
    );
    expect(
      lessonVisualizationFor(tangent, isEnglish: false),
      isA<SecantToTangentVisualization>(),
    );
  });

  test('does not add a visualization to unrelated lessons', () {
    final lesson = limitsCourseLessons.firstWhere(
      (item) => item.id == 'limites-03-propriedades',
    );

    expect(lessonVisualizationFor(lesson, isEnglish: false), isNull);
  });
}
