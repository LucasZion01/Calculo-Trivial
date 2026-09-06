import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/services/module_mastery_tracker.dart';

void main() {
  const moduleId = 'algebra-fundamental';

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await ModuleMasteryTracker.clearCurrentScopeForTesting(moduleId);
  });

  test('mantém o melhor resultado de prática', () async {
    await ModuleMasteryTracker.recordPracticeResult(
      moduleId: moduleId,
      correctAnswers: 6,
      totalQuestions: 10,
    );
    final improved = await ModuleMasteryTracker.recordPracticeResult(
      moduleId: moduleId,
      correctAnswers: 8,
      totalQuestions: 10,
    );
    final worseLater = await ModuleMasteryTracker.recordPracticeResult(
      moduleId: moduleId,
      correctAnswers: 7,
      totalQuestions: 10,
    );

    expect(improved.bestPracticeAccuracy, 0.8);
    expect(worseLater.bestPracticeAccuracy, 0.8);
  });

  test('persiste prática e prova como evidências separadas', () async {
    await ModuleMasteryTracker.recordPracticeResult(
      moduleId: moduleId,
      correctAnswers: 7,
      totalQuestions: 10,
    );
    await ModuleMasteryTracker.recordFinalTestResult(
      moduleId: moduleId,
      correctAnswers: 9,
      totalQuestions: 10,
    );

    final evidence = await ModuleMasteryTracker.loadEvidence(moduleId: moduleId);

    expect(evidence.bestPracticeAccuracy, 0.7);
    expect(evidence.bestFinalTestAccuracy, 0.9);
  });

  test('normaliza resultados para a faixa de zero a um', () async {
    final evidence = await ModuleMasteryTracker.recordFinalTestResult(
      moduleId: moduleId,
      correctAnswers: 12,
      totalQuestions: 10,
    );

    expect(evidence.bestFinalTestAccuracy, 1.0);
  });
}
