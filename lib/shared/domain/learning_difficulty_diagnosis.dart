enum LearningAttemptPhase { practice, finalTest, recheck }

class LearningAttemptSignal {
  final String moduleId;
  final String questionId;
  final String contentLessonId;
  final String skill;
  final bool isCorrect;
  final LearningAttemptPhase phase;

  const LearningAttemptSignal({
    required this.moduleId,
    required this.questionId,
    required this.contentLessonId,
    required this.skill,
    required this.isCorrect,
    required this.phase,
  });
}

class LearningDifficultyEvidence {
  final String moduleId;
  final String contentLessonId;
  final String skill;
  final int attempts;
  final int errors;
  final int finalTestAttempts;
  final int finalTestErrors;

  const LearningDifficultyEvidence({
    required this.moduleId,
    required this.contentLessonId,
    required this.skill,
    required this.attempts,
    required this.errors,
    required this.finalTestAttempts,
    required this.finalTestErrors,
  });

  double get errorRate => attempts == 0 ? 0 : errors / attempts;

  bool get hasRepeatedErrors => errors >= 2;
}

class LearningDifficultyDiagnosis {
  final List<LearningDifficultyEvidence> reviewRecommendations;
  final int analyzedAttempts;

  const LearningDifficultyDiagnosis({
    required this.reviewRecommendations,
    required this.analyzedAttempts,
  });

  bool get hasRecommendations => reviewRecommendations.isNotEmpty;
}

class LearningDifficultyDiagnoser {
  const LearningDifficultyDiagnoser._();

  static const int minimumAttempts = 3;
  static const int minimumErrors = 2;
  static const double minimumErrorRate = 0.5;

  static LearningDifficultyDiagnosis evaluate(
    Iterable<LearningAttemptSignal> signals,
  ) {
    final validSignals = signals.where(_isValidSignal).toList(growable: false);
    final grouped = <String, List<LearningAttemptSignal>>{};

    for (final signal in validSignals) {
      final key = '${signal.moduleId}\u0000${signal.contentLessonId}\u0000${signal.skill}';
      grouped.putIfAbsent(key, () => <LearningAttemptSignal>[]).add(signal);
    }

    final recommendations = <LearningDifficultyEvidence>[];

    for (final group in grouped.values) {
      final errors = group.where((signal) => !signal.isCorrect).length;
      final finalAttempts = group
          .where((signal) => signal.phase == LearningAttemptPhase.finalTest)
          .length;
      final finalErrors = group
          .where(
            (signal) =>
                signal.phase == LearningAttemptPhase.finalTest &&
                !signal.isCorrect,
          )
          .length;
      final evidence = LearningDifficultyEvidence(
        moduleId: group.first.moduleId,
        contentLessonId: group.first.contentLessonId,
        skill: group.first.skill,
        attempts: group.length,
        errors: errors,
        finalTestAttempts: finalAttempts,
        finalTestErrors: finalErrors,
      );

      if (_shouldRecommendReview(evidence)) {
        recommendations.add(evidence);
      }
    }

    recommendations.sort((a, b) {
      final finalErrorComparison = b.finalTestErrors.compareTo(a.finalTestErrors);
      if (finalErrorComparison != 0) return finalErrorComparison;

      final rateComparison = b.errorRate.compareTo(a.errorRate);
      if (rateComparison != 0) return rateComparison;

      final errorComparison = b.errors.compareTo(a.errors);
      if (errorComparison != 0) return errorComparison;

      return a.skill.compareTo(b.skill);
    });

    return LearningDifficultyDiagnosis(
      reviewRecommendations: List<LearningDifficultyEvidence>.unmodifiable(
        recommendations,
      ),
      analyzedAttempts: validSignals.length,
    );
  }

  static bool _shouldRecommendReview(LearningDifficultyEvidence evidence) {
    if (evidence.attempts < minimumAttempts) return false;
    if (evidence.errors < minimumErrors) return false;
    if (evidence.errorRate < minimumErrorRate) return false;

    return true;
  }

  static bool _isValidSignal(LearningAttemptSignal signal) {
    return signal.moduleId.trim().isNotEmpty &&
        signal.questionId.trim().isNotEmpty &&
        signal.contentLessonId.trim().isNotEmpty &&
        signal.skill.trim().isNotEmpty;
  }
}
