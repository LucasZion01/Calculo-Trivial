import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/data/mock_derivatives_exercise_data.dart';
import 'package:calcquest/shared/services/learning_difficulty_tracker.dart';
import 'package:calcquest/shared/state/app_progress.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await LearningDifficultyTracker.clearCurrentScope();
  });

  test('derivatives attempts preserve lesson and skill metadata', () async {
    final exercise = mockDerivativesExercises.firstWhere(
      (item) => item.id == 'derivada-regra-cadeia',
    );

    await LearningDifficultyTracker.recordPracticeAttempt(
      exercise: exercise,
      isCorrect: false,
    );
    await LearningDifficultyTracker.recordFinalTestAttempt(
      moduleId: AppProgress.derivativesId,
      exercise: exercise,
      isCorrect: false,
    );
    await LearningDifficultyTracker.recordFinalTestAttempt(
      moduleId: AppProgress.derivativesId,
      exercise: exercise,
      isCorrect: true,
    );

    final restored = await LearningDifficultyTracker.loadSignals();
    final diagnosis = await LearningDifficultyTracker.diagnose(
      moduleId: AppProgress.derivativesId,
    );

    expect(restored, hasLength(3));
    expect(
      restored.every((signal) => signal.moduleId == AppProgress.derivativesId),
      isTrue,
    );
    expect(
      restored.every(
        (signal) => signal.contentLessonId == 'derivadas-04-cadeia',
      ),
      isTrue,
    );
    expect(
      restored.every((signal) => signal.skill == 'Regra da cadeia'),
      isTrue,
    );
    expect(diagnosis.analyzedAttempts, 3);
    expect(diagnosis.reviewRecommendations, hasLength(1));
    expect(
      diagnosis.reviewRecommendations.single.contentLessonId,
      'derivadas-04-cadeia',
    );
    expect(
      diagnosis.reviewRecommendations.single.skill,
      'Regra da cadeia',
    );
    expect(diagnosis.reviewRecommendations.single.finalTestErrors, 1);
  });
}
