import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/services/limits_spaced_practice_tracker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    await LimitsSpacedPracticeTracker.clearCurrentScope();
  });

  test('primeiro contato agenda revisão para o dia seguinte', () async {
    final now = DateTime(2026, 9, 6, 10);

    final state = await LimitsSpacedPracticeTracker.loadOrCreate(now: now);

    expect(state.stage, 0);
    expect(state.nextDueAt, now.add(const Duration(days: 1)));
    expect(state.isDue(now), isFalse);
    expect(state.isDue(now.add(const Duration(days: 1))), isTrue);
  });

  test('revisões corretas ampliam os intervalos para 3 e 7 dias', () async {
    final start = DateTime(2026, 9, 6, 10);
    await LimitsSpacedPracticeTracker.loadOrCreate(now: start);

    final firstReview = await LimitsSpacedPracticeTracker.completeReview(
      now: start.add(const Duration(days: 1)),
    );

    expect(firstReview.stage, 1);
    expect(
      firstReview.nextDueAt,
      start.add(const Duration(days: 4)),
    );

    final secondReview = await LimitsSpacedPracticeTracker.completeReview(
      now: firstReview.nextDueAt,
    );

    expect(secondReview.stage, 2);
    expect(
      secondReview.nextDueAt,
      firstReview.nextDueAt.add(const Duration(days: 7)),
    );
  });
}
