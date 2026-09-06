import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LimitsSpacedPracticeState {
  final int stage;
  final DateTime nextDueAt;

  const LimitsSpacedPracticeState({
    required this.stage,
    required this.nextDueAt,
  });

  bool isDue(DateTime now) => !now.isBefore(nextDueAt);
}

class LimitsSpacedPracticeTracker {
  LimitsSpacedPracticeTracker._();

  static const String _stageKey = 'limits_spaced_practice_stage_v1';
  static const String _nextDueKey = 'limits_spaced_practice_next_due_v1';

  static String _scope() {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid.trim();
      if (uid != null && uid.isNotEmpty) return uid;
    } catch (_) {
      // Firebase may not be initialized in isolated tests.
    }

    return 'guest';
  }

  static String _key(String base) => '${_scope()}_$base';

  static Future<LimitsSpacedPracticeState> loadOrCreate({
    DateTime? now,
  }) async {
    final current = now ?? DateTime.now();
    final preferences = await SharedPreferences.getInstance();
    final storedStage = preferences.getInt(_key(_stageKey));
    final storedDue = preferences.getString(_key(_nextDueKey));

    if (storedStage != null && storedDue != null) {
      final parsedDue = DateTime.tryParse(storedDue);
      if (parsedDue != null) {
        return LimitsSpacedPracticeState(
          stage: storedStage,
          nextDueAt: parsedDue,
        );
      }
    }

    final initial = LimitsSpacedPracticeState(
      stage: 0,
      nextDueAt: current.add(const Duration(days: 1)),
    );

    await _save(initial);
    return initial;
  }

  static Future<LimitsSpacedPracticeState> completeReview({
    DateTime? now,
  }) async {
    final current = now ?? DateTime.now();
    final previous = await loadOrCreate(now: current);
    final nextStage = previous.stage + 1;
    final intervalDays = switch (nextStage) {
      1 => 3,
      2 => 7,
      _ => 7,
    };

    final updated = LimitsSpacedPracticeState(
      stage: nextStage,
      nextDueAt: current.add(Duration(days: intervalDays)),
    );

    await _save(updated);
    return updated;
  }

  static Future<void> clearCurrentScope() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_key(_stageKey));
    await preferences.remove(_key(_nextDueKey));
  }

  static Future<void> _save(LimitsSpacedPracticeState state) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_key(_stageKey), state.stage);
    await preferences.setString(
      _key(_nextDueKey),
      state.nextDueAt.toIso8601String(),
    );
  }
}
