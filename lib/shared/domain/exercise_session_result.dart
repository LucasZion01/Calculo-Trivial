class ExerciseSessionResult {
  static const double minimumPassingScore = 0.8;

  final int totalQuestions;
  final int correctAnswers;
  final int configuredXp;
  final int configuredGold;

  const ExerciseSessionResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.configuredXp,
    required this.configuredGold,
  }) : assert(totalQuestions >= 0),
       assert(correctAnswers >= 0),
       assert(correctAnswers <= totalQuestions),
       assert(configuredXp >= 0),
       assert(configuredGold >= 0);

  int get incorrectAnswers => totalQuestions - correctAnswers;

  double get accuracy {
    if (totalQuestions == 0) {
      return 0;
    }

    return correctAnswers / totalQuestions;
  }

  int get accuracyPercentage => (accuracy * 100).round();

  bool get isApproved => totalQuestions > 0 && accuracy >= minimumPassingScore;

  int get earnedXp => isApproved ? configuredXp : 0;

  int get earnedGold => isApproved ? configuredGold : 0;
}
