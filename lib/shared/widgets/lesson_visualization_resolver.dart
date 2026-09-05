import 'package:flutter/widgets.dart';

import 'package:calcquest/shared/domain/course_lesson_data.dart';
import 'package:calcquest/shared/widgets/calculus_visualizations.dart';

Widget? lessonVisualizationFor(
  CourseLessonData lesson, {
  required bool isEnglish,
}) {
  return switch (lesson.id) {
    'limites-01-intuicao' => LimitApproachVisualization(
        isEnglish: isEnglish,
      ),
    'continuidade-01-significado' => ContinuityVisualization(
        isEnglish: isEnglish,
      ),
    'derivadas-01-significado' => DerivativeTangentVisualization(
        isEnglish: isEnglish,
      ),
    _ => null,
  };
}
