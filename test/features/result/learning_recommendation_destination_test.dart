import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/features/lesson/presentation/algebra_course_screen.dart';
import 'package:calcquest/features/lesson/presentation/continuity_course_screen.dart';
import 'package:calcquest/features/lesson/presentation/derivatives_course_screen.dart';
import 'package:calcquest/features/lesson/presentation/equations_course_screen.dart';
import 'package:calcquest/features/lesson/presentation/functions_lesson_screen.dart';
import 'package:calcquest/features/lesson/presentation/limits_course_screen.dart';
import 'package:calcquest/features/result/presentation/learning_recommendation_destination.dart';
import 'package:calcquest/shared/state/app_progress.dart';

void main() {
  test('routes every supported module to its own review destination', () {
    expect(
      learningRecommendationDestinationFor(AppProgress.algebraFundamentalId),
      isA<AlgebraCourseScreen>(),
    );
    expect(
      learningRecommendationDestinationFor(
        AppProgress.equationsAndInequationsId,
      ),
      isA<EquationsCourseScreen>(),
    );
    expect(
      learningRecommendationDestinationFor(AppProgress.functionsId),
      isA<FunctionsLessonScreen>(),
    );
    expect(
      learningRecommendationDestinationFor(AppProgress.limitsId),
      isA<LimitsCourseScreen>(),
    );
    expect(
      learningRecommendationDestinationFor(AppProgress.continuityId),
      isA<ContinuityCourseScreen>(),
    );
    expect(
      learningRecommendationDestinationFor(AppProgress.derivativesId),
      isA<DerivativesCourseScreen>(),
    );
  });

  test('returns null for an unsupported module', () {
    expect(learningRecommendationDestinationFor('unknown-module'), isNull);
  });
}
