import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/state/app_progress.dart';

class FinalTestSessionBuilder {
  const FinalTestSessionBuilder._();

  static List<ExerciseData> build({
    required String lessonId,
    required Iterable<ExerciseData> exercises,
    required Iterable<String> practiceQuestionIds,
    int questionCount = 10,
  }) {
    final exerciseList = exercises.toList(growable: false);
    final exercisesById = <String, ExerciseData>{
      for (final exercise in exerciseList) exercise.id: exercise,
    };

    final selectedIds = AppProgress.selectFinalTestQuestionIds(
      lessonId: lessonId,
      availableQuestionIds: exerciseList.map((exercise) => exercise.id),
      practiceQuestionIds: practiceQuestionIds,
      questionCount: questionCount,
    );

    return selectedIds
        .map((id) => exercisesById[id])
        .whereType<ExerciseData>()
        .toList(growable: false);
  }
}
