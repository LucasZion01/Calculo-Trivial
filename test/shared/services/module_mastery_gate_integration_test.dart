import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/domain/module_mastery_policy.dart';
import 'package:calcquest/shared/services/module_mastery_tracker.dart';

void main() {
  const moduleId = 'algebra-fundamental';

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await ModuleMasteryTracker.clearCurrentScopeForTesting(moduleId);
  });

  test('prática abaixo de 70% não libera a prova final', () async {
    final evidence = await ModuleMasteryTracker.recordPracticeResult(
      moduleId: moduleId,
      correctAnswers: 6,
      totalQuestions: 10,
    );

    final decision = ModuleMasteryPolicy.evaluate(evidence);

    expect(evidence.bestPracticeAccuracy, 0.6);
    expect(decision.status, ModuleMasteryStatus.practiceBelowTarget);
    expect(decision.canTakeFinalTest, isFalse);
    expect(decision.shouldReview, isTrue);
  });

  test('70% na prática libera a prova, mas não o próximo módulo', () async {
    final evidence = await ModuleMasteryTracker.recordPracticeResult(
      moduleId: moduleId,
      correctAnswers: 7,
      totalQuestions: 10,
    );

    final decision = ModuleMasteryPolicy.evaluate(evidence);

    expect(evidence.bestPracticeAccuracy, 0.7);
    expect(decision.status, ModuleMasteryStatus.readyForFinalTest);
    expect(decision.canTakeFinalTest, isTrue);
    expect(decision.canUnlockNextModule, isFalse);
  });

  test('70% na prática e 80% na prova resultam em domínio', () async {
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

    expect(evidence.bestPracticeAccuracy, 0.7);
    expect(evidence.bestFinalTestAccuracy, 0.8);
    expect(decision.status, ModuleMasteryStatus.mastered);
    expect(decision.canUnlockNextModule, isTrue);
  });
}
