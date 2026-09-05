import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/services/learning_difficulty_tracker.dart';
import 'package:calcquest/shared/state/app_progress.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await LearningDifficultyTracker.clearCurrentScope();
  });

  test('algebra final-test attempts preserve lesson and skill metadata', () async {
    final exercise = mockExercises.firstWhere(
      (item) => item.id == 'produto-notavel-1',
    );

    await LearningDifficultyTracker.recordPracticeAttempt(
      exercise: exercise,
      isCorrect: false,
    );
    await LearningDifficultyTracker.recordFinalTestAttempt(
      moduleId: AppProgress.algebraFundamentalId,
      exercise: exercise,
      isCorrect: false,
    );
    await LearningDifficultyTracker.recordFinalTestAttempt(
      moduleId: AppProgress.algebraFundamentalId,
      exercise: exercise,
      isCorrect: true,
    );

    final restored = await LearningDifficultyTracker.loadSignals();
    final diagnosis = await LearningDifficultyTracker.diagnose(
      moduleId: AppProgress.algebraFundamentalId,
    );

    expect(restored, hasLength(3));
    expect(
      restored.every(
        (signal) => signal.moduleId == AppProgress.algebraFundamentalId,
      ),
      isTrue,
    );
    expect(
      restored.every(
        (signal) => signal.contentLessonId == 'algebra-05-produtos-notaveis',
      ),
      isTrue,
    );
    expect(
      restored.every((signal) => signal.skill == 'Expandir binômios'),
      isTrue,
    );
    expect(diagnosis.analyzedAttempts, 3);
    expect(diagnosis.reviewRecommendations, hasLength(1));
    expect(
      diagnosis.reviewRecommendations.single.contentLessonId,
      'algebra-05-produtos-notaveis',
    );
    expect(
      diagnosis.reviewRecommendations.single.skill,
      'Expandir binômios',
    );
    expect(diagnosis.reviewRecommendations.single.finalTestErrors, 1);
  });
}
