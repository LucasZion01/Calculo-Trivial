import 'package:flutter/widgets.dart';

import 'package:calcquest/shared/state/app_progress.dart';

import '../../learning_path/presentation/learning_path_screen.dart';
import '../../lesson/presentation/algebra_course_screen.dart';
import '../../lesson/presentation/continuity_course_screen.dart';
import '../../lesson/presentation/derivatives_course_screen.dart';
import '../../lesson/presentation/equations_course_screen.dart';
import '../../lesson/presentation/functions_lesson_screen.dart';
import '../../lesson/presentation/limits_course_screen.dart';

Widget learningRecommendationDestinationFor(String moduleId) {
  return switch (moduleId) {
    AppProgress.algebraFundamentalId => const AlgebraCourseScreen(),
    AppProgress.equationsAndInequationsId => const EquationsCourseScreen(),
    AppProgress.functionsId => const FunctionsLessonScreen(),
    AppProgress.limitsId => const LimitsCourseScreen(),
    AppProgress.continuityId => const ContinuityCourseScreen(),
    AppProgress.derivativesId => const DerivativesCourseScreen(),
    _ => const LearningPathScreen(),
  };
}
