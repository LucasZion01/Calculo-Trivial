import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/module_mastery_policy.dart';

void main() {
  group('ModuleMasteryPolicy', () {
    test('starts locked without evidence', () {
      final decision = ModuleMasteryPolicy.evaluate(
        const ModuleMasteryEvidence(),
      );

      expect(decision.status, ModuleMasteryStatus.notStarted);
      expect(decision.canTakeFinalTest, isFalse);
      expect(decision.canUnlockNextModule, isFalse);
      expect(decision.shouldReview, isFalse);
    });

    test('requires at least 70 percent in practice', () {
      final below = ModuleMasteryPolicy.evaluate(
        const ModuleMasteryEvidence(bestPracticeAccuracy: 0.69),
      );
      final atTarget = ModuleMasteryPolicy.evaluate(
        const ModuleMasteryEvidence(bestPracticeAccuracy: 0.70),
      );

      expect(below.status, ModuleMasteryStatus.practiceBelowTarget);
      expect(below.canTakeFinalTest, isFalse);
      expect(below.shouldReview, isTrue);

      expect(atTarget.status, ModuleMasteryStatus.readyForFinalTest);
      expect(atTarget.canTakeFinalTest, isTrue);
    });

    test('requires at least 80 percent in final test to master module', () {
      final below = ModuleMasteryPolicy.evaluate(
        const ModuleMasteryEvidence(
          bestPracticeAccuracy: 0.85,
          bestFinalTestAccuracy: 0.79,
        ),
      );
      final mastered = ModuleMasteryPolicy.evaluate(
        const ModuleMasteryEvidence(
          bestPracticeAccuracy: 0.85,
          bestFinalTestAccuracy: 0.80,
        ),
      );

      expect(below.status, ModuleMasteryStatus.finalTestBelowTarget);
      expect(below.canUnlockNextModule, isFalse);
      expect(below.shouldReview, isTrue);

      expect(mastered.status, ModuleMasteryStatus.mastered);
      expect(mastered.canUnlockNextModule, isTrue);
      expect(mastered.shouldReview, isFalse);
    });

    test('preserves access for modules completed before mastery rollout', () {
      final decision = ModuleMasteryPolicy.evaluate(
        const ModuleMasteryEvidence(legacyCompleted: true),
      );

      expect(decision.status, ModuleMasteryStatus.mastered);
      expect(decision.canTakeFinalTest, isTrue);
      expect(decision.canUnlockNextModule, isTrue);
      expect(decision.shouldReview, isFalse);
    });

    test('final test evidence cannot bypass weak practice evidence', () {
      final decision = ModuleMasteryPolicy.evaluate(
        const ModuleMasteryEvidence(
          bestPracticeAccuracy: 0.60,
          bestFinalTestAccuracy: 1.0,
        ),
      );

      expect(decision.status, ModuleMasteryStatus.practiceBelowTarget);
      expect(decision.canTakeFinalTest, isFalse);
      expect(decision.canUnlockNextModule, isFalse);
    });
  });
}
