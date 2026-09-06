import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/domain/module_mastery_policy.dart';
import 'package:calcquest/shared/services/module_mastery_tracker.dart';

void main() {
  const moduleId = 'equacoes-inequacoes';

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await ModuleMasteryTracker.clearCurrentScopeForTesting(moduleId);
  });

  test('60% na prática mantém Equações abaixo da meta', () async {
    final evidence = await ModuleMasteryTracker.recordPracticeResult(
      moduleId: moduleId,
      correctAnswers: 6,
      totalQuestions: 10,
    );

    final decision = ModuleMasteryPolicy.evaluate(evidence);

    expect(decision.status, ModuleMasteryStatus.practiceBelowTarget);
    expect(decision.canTakeFinalTest, isFalse);
    expect(decision.shouldReview, isTrue);
  });

  test('70% na prática libera a prova de Equações', () async {
    final evidence = await ModuleMasteryTracker.recordPracticeResult(
      moduleId: moduleId,
      correctAnswers: 7,
      totalQuestions: 10,
    );

    final decision = ModuleMasteryPolicy.evaluate(evidence);

    expect(decision.status, ModuleMasteryStatus.readyForFinalTest);
    expect(decision.canTakeFinalTest, isTrue);
    expect(decision.canUnlockNextModule, isFalse);
  });

  test('70% na prática e 80% na prova dominam Equações', () async {
    await ModuleMasteryTracker.recordPracticeResult(
      moduleId: moduleId,
      correctAnswers: 7,
      totalQuestions: 10,
    );

    final evidence = await ModuleMasteryTracker.recordFinalTestResult(
      moduleId: moduleId,
      correctAnswers: 8,
      totalQuestions: 10,
    );

    final decision = ModuleMasteryPolicy.evaluate(evidence);

    expect(decision.status, ModuleMasteryStatus.mastered);
    expect(decision.canUnlockNextModule, isTrue);
  });
}
