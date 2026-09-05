import 'package:flutter/widgets.dart';

import 'package:calcquest/shared/domain/course_lesson_data.dart';
import 'package:calcquest/shared/widgets/advanced_calculus_visualizations.dart';
import 'package:calcquest/shared/widgets/calculus_visualizations.dart';

Widget? lessonVisualizationFor(
  CourseLessonData lesson, {
  required bool isEnglish,
}) {
  return switch (lesson.id) {
    'limites-01-intuicao' => LimitApproachVisualization(
        isEnglish: isEnglish,
      ),
    'limites-02-laterais' => OneSidedLimitVisualization(
        isEnglish: isEnglish,
      ),
    'limites-06-infinito' => AsymptoteVisualization(
        isEnglish: isEnglish,
      ),
    'continuidade-01-significado' => ContinuityVisualization(
        isEnglish: isEnglish,
      ),
    'continuidade-03-descontinuidades' => DiscontinuityTypesVisualization(
        isEnglish: isEnglish,
      ),
    'derivadas-01-significado' => DerivativeTangentVisualization(
        isEnglish: isEnglish,
      ),
    'derivadas-06-tangente' => SecantToTangentVisualization(
        isEnglish: isEnglish,
      ),
    _ => null,
  };
}
