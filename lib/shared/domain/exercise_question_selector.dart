import 'dart:math';

class ExerciseQuestionSelector {
  const ExerciseQuestionSelector._();

  static List<String> select({
    required Iterable<String> availableQuestionIds,
    Iterable<String> previousSessionIds = const <String>[],
    int questionCount = 10,
    Random? random,
  }) {
    final uniqueQuestionIds = availableQuestionIds.toSet().toList();

    if (uniqueQuestionIds.isEmpty || questionCount <= 0) {
      return <String>[];
    }

    final previousIds = previousSessionIds.toSet();
    final randomGenerator = random ?? Random();

    final unseenQuestionIds =
        uniqueQuestionIds
            .where((questionId) => !previousIds.contains(questionId))
            .toList()
          ..shuffle(randomGenerator);

    final previouslyUsedQuestionIds =
        uniqueQuestionIds.where(previousIds.contains).toList()
          ..shuffle(randomGenerator);

    final targetCount = min(questionCount, uniqueQuestionIds.length);

    return <String>[
      ...unseenQuestionIds,
      ...previouslyUsedQuestionIds,
    ].take(targetCount).toList(growable: false);
  }
}
