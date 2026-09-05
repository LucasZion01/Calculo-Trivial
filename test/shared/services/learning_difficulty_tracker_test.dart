import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/data/mock_functions_exercise_data.dart';
import 'package:calcquest/shared/domain/learning_difficulty_diagnosis.dart';
import 'package:calcquest/shared/services/learning_difficulty_tracker.dart';
import 'package:calcquest/shared/state/app_progress.dart';

void main() {
  setUp(() async {
    await LearningDifficultyTracker.clearCurrentScope();
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  test('persists attempts and restores them for diagnosis', () async {
    final exercise = mockFunctionsExercises.first;

    await LearningDifficultyTracker.recordAttempt(
      moduleId: AppProgress.functionsId,
      exercise: exercise,
      isCorrect: false,
      phase: LearningAttemptPhase.practice,
    );
    await LearningDifficultyTracker.recordAttempt(
      moduleId: AppProgress.functionsId,
      exercise: exercise,
      isCorrect: true,
      phase: LearningAttemptPhase.practice,
    );
    await LearningDifficultyTracker.recordAttempt(
      moduleId: AppProgress.functionsId,
      exercise: exercise,
      isCorrect: false,
      phase: LearningAttemptPhase.finalTest,
    );

    final restored = await LearningDifficultyTracker.loadSignals();
    final diagnosis = await LearningDifficultyTracker.diagnose(
      moduleId: AppProgress.functionsId,
    );

    expect(restored, hasLength(3));
    expect(restored.first.contentLessonId, AppProgress.functionsId);
    expect(restored.first.skill, 'Domínio de funções');
    expect(diagnosis.analyzedAttempts, 3);
    expect(diagnosis.reviewRecommendations, hasLength(1));
    expect(diagnosis.reviewRecommendations.single.skill, 'Domínio de funções');
    expect(diagnosis.reviewRecommendations.single.finalTestErrors, 1);
  });

  test('practice helper identifies the module from the question bank', () async {
    final exercise = mockFunctionsExercises.first;

    await LearningDifficultyTracker.recordPracticeAttempt(
      exercise: exercise,
      isCorrect: false,
    );

    final restored = await LearningDifficultyTracker.loadSignals();

    expect(restored, hasLength(1));
    expect(restored.single.moduleId, AppProgress.functionsId);
    expect(restored.single.phase, LearningAttemptPhase.practice);
  });

  test('concurrent attempts are serialized without losing signals', () async {
    final exercise = mockFunctionsExercises.first;

    final writes = List<Future<void>>.generate(
      12,
      (index) => LearningDifficultyTracker.recordAttempt(
        moduleId: AppProgress.functionsId,
        exercise: exercise,
        isCorrect: index.isEven,
        phase: LearningAttemptPhase.practice,
      ),
    );

    await Future.wait(writes);

    final restored = await LearningDifficultyTracker.loadSignals();
    expect(restored, hasLength(12));
  });

  test('clear removes only the current local diagnosis scope', () async {
    final exercise = mockFunctionsExercises.first;

    await LearningDifficultyTracker.recordPracticeAttempt(
      exercise: exercise,
      isCorrect: false,
    );

    await LearningDifficultyTracker.clearCurrentScope();

    expect(await LearningDifficultyTracker.loadSignals(), isEmpty);
  });
}
