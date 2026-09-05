import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/data/mock_equations_exercise_data.dart';
import 'package:calcquest/shared/services/learning_difficulty_tracker.dart';
import 'package:calcquest/shared/state/app_progress.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await LearningDifficultyTracker.clearCurrentScope();
  });

  test('equations practice and final test share learning metadata', () async {
    final exercise = mockEquationsExercises.firstWhere(
      (item) => item.id == 'inequacao-negativa',
    );

    await LearningDifficultyTracker.recordPracticeAttempt(
      exercise: exercise,
      isCorrect: false,
    );
    await LearningDifficultyTracker.recordFinalTestAttempt(
      moduleId: AppProgress.equationsAndInequationsId,
      exercise: exercise,
      isCorrect: false,
    );
    await LearningDifficultyTracker.recordFinalTestAttempt(
      moduleId: AppProgress.equationsAndInequationsId,
      exercise: exercise,
      isCorrect: true,
    );

    final restored = await LearningDifficultyTracker.loadSignals();
    final diagnosis = await LearningDifficultyTracker.diagnose(
      moduleId: AppProgress.equationsAndInequationsId,
    );

    expect(restored, hasLength(3));
    expect(
      restored.every(
        (signal) => signal.moduleId == AppProgress.equationsAndInequationsId,
      ),
      isTrue,
    );
    expect(
      restored.every(
        (signal) => signal.contentLessonId == 'equations-07-inequacoes',
      ),
      isTrue,
    );
    expect(
      restored.every(
        (signal) => signal.skill == 'Inversão do sinal em inequações',
      ),
      isTrue,
    );
    expect(diagnosis.analyzedAttempts, 3);
    expect(diagnosis.reviewRecommendations, hasLength(1));
    expect(
      diagnosis.reviewRecommendations.single.contentLessonId,
      'equations-07-inequacoes',
    );
    expect(
      diagnosis.reviewRecommendations.single.skill,
      'Inversão do sinal em inequações',
    );
    expect(diagnosis.reviewRecommendations.single.finalTestErrors, 1);
  });

  test('equations metadata covers every current question', () async {
    for (final exercise in mockEquationsExercises) {
      await LearningDifficultyTracker.recordPracticeAttempt(
        exercise: exercise,
        isCorrect: true,
      );
    }

    final restored = await LearningDifficultyTracker.loadSignals();

    expect(restored, hasLength(mockEquationsExercises.length));
    expect(
      restored.every((signal) => signal.contentLessonId.isNotEmpty),
      isTrue,
    );
    expect(restored.every((signal) => signal.skill.isNotEmpty), isTrue);
  });
}
