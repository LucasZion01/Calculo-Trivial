import 'dart:math';

class FinalTestQuestionSelector {
  const FinalTestQuestionSelector._();

  static List<String> select({
    required Iterable<String> availableQuestionIds,
    Iterable<String> practiceQuestionIds = const <String>[],
    Iterable<String> previousFinalTestIds = const <String>[],
    int questionCount = 10,
    Random? random,
  }) {
    final uniqueQuestionIds = availableQuestionIds.toSet().toList();

    if (uniqueQuestionIds.isEmpty || questionCount <= 0) {
      return <String>[];
    }

    final practiceIds = practiceQuestionIds.toSet();
    final previousIds = previousFinalTestIds.toSet();
    final randomGenerator = random ?? Random();

    List<String> shuffledWhere(bool Function(String id) predicate) {
      final ids = uniqueQuestionIds.where(predicate).toList()
        ..shuffle(randomGenerator);
      return ids;
    }

    final freshOutsidePractice = shuffledWhere(
      (id) => !practiceIds.contains(id) && !previousIds.contains(id),
    );
    final repeatedOutsidePractice = shuffledWhere(
      (id) => !practiceIds.contains(id) && previousIds.contains(id),
    );
    final freshFromPractice = shuffledWhere(
      (id) => practiceIds.contains(id) && !previousIds.contains(id),
    );
    final repeatedFromPractice = shuffledWhere(
      (id) => practiceIds.contains(id) && previousIds.contains(id),
    );

    final targetCount = min(questionCount, uniqueQuestionIds.length);

    return <String>[
      ...freshOutsidePractice,
      ...repeatedOutsidePractice,
      ...freshFromPractice,
      ...repeatedFromPractice,
    ].take(targetCount).toList(growable: false);
  }
}
