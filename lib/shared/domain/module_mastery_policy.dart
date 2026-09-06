enum ModuleMasteryStatus {
  notStarted,
  practiceBelowTarget,
  readyForFinalTest,
  finalTestBelowTarget,
  mastered,
}

class ModuleMasteryEvidence {
  final double? bestPracticeAccuracy;
  final double? bestFinalTestAccuracy;
  final bool legacyCompleted;

  const ModuleMasteryEvidence({
    this.bestPracticeAccuracy,
    this.bestFinalTestAccuracy,
    this.legacyCompleted = false,
  });
}

class ModuleMasteryDecision {
  final ModuleMasteryStatus status;
  final bool canTakeFinalTest;
  final bool canUnlockNextModule;
  final bool shouldReview;

  const ModuleMasteryDecision({
    required this.status,
    required this.canTakeFinalTest,
    required this.canUnlockNextModule,
    required this.shouldReview,
  });
}

class ModuleMasteryPolicy {
  static const double minimumPracticeAccuracy = 0.70;
  static const double minimumFinalTestAccuracy = 0.80;

  const ModuleMasteryPolicy._();

  static ModuleMasteryDecision evaluate(ModuleMasteryEvidence evidence) {
    // Existing users who already completed a module must never lose access when
    // mastery-based progression is introduced.
    if (evidence.legacyCompleted) {
      return const ModuleMasteryDecision(
        status: ModuleMasteryStatus.mastered,
        canTakeFinalTest: true,
        canUnlockNextModule: true,
        shouldReview: false,
      );
    }

    final practice = evidence.bestPracticeAccuracy;
    final finalTest = evidence.bestFinalTestAccuracy;

    if (practice == null && finalTest == null) {
      return const ModuleMasteryDecision(
        status: ModuleMasteryStatus.notStarted,
        canTakeFinalTest: false,
        canUnlockNextModule: false,
        shouldReview: false,
      );
    }

    if (practice == null || practice < minimumPracticeAccuracy) {
      return const ModuleMasteryDecision(
        status: ModuleMasteryStatus.practiceBelowTarget,
        canTakeFinalTest: false,
        canUnlockNextModule: false,
        shouldReview: true,
      );
    }

    if (finalTest == null) {
      return const ModuleMasteryDecision(
        status: ModuleMasteryStatus.readyForFinalTest,
        canTakeFinalTest: true,
        canUnlockNextModule: false,
        shouldReview: false,
      );
    }

    if (finalTest < minimumFinalTestAccuracy) {
      return const ModuleMasteryDecision(
        status: ModuleMasteryStatus.finalTestBelowTarget,
        canTakeFinalTest: true,
        canUnlockNextModule: false,
        shouldReview: true,
      );
    }

    return const ModuleMasteryDecision(
      status: ModuleMasteryStatus.mastered,
      canTakeFinalTest: true,
      canUnlockNextModule: true,
      shouldReview: false,
    );
  }
}
