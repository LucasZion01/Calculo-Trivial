class ExerciseReviewItem {
  final String questionId;
  final String statement;
  final String selectedAnswer;
  final String correctAnswer;
  final String explanation;

  const ExerciseReviewItem({
    required this.questionId,
    required this.statement,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.explanation,
  });
}
