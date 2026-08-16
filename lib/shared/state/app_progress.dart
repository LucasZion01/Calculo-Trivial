import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProgress {
  static const String algebraFundamentalId = 'algebra-fundamental';
  static const String equationsAndInequationsId = 'equacoes-inequacoes';
  static const String functionsId = 'funcoes';
  static const String limitsId = 'limites';

  static const String _algebraFundamentalLegacyKey =
      'algebra_fundamental_completed';
  static const String _equationsAndInequationsLegacyKey =
      'equations_and_inequations_completed';
  static const String _functionsLegacyKey = 'functions_completed';
  static const String _limitsLegacyKey = 'limits_completed';

  static const String _completedLessonsKey = 'completed_lesson_ids';

  static bool algebraFundamentalCompleted = false;
  static bool equationsAndInequationsCompleted = false;
  static bool functionsCompleted = false;
  static bool limitsCompleted = false;

  static int totalXp = 0;
  static int totalGold = 0;

  static String? _activeUserId;

  static final Set<String> _completedLessonIds = <String>{};

  static final ValueNotifier<int> revision = ValueNotifier<int>(0);

  static Set<String> get completedLessonIds =>
      Set<String>.unmodifiable(_completedLessonIds);

  static String _scopedKey(String baseKey, String? userId) {
    final scope = userId?.trim();

    if (scope == null || scope.isEmpty) {
      return 'guest_$baseKey';
    }

    return '${scope}_$baseKey';
  }

  static DocumentReference<Map<String, dynamic>>? _progressDocument() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return null;
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('progress')
        .doc('current');
  }

  static Future<void> loadProgress() async {
    final user = FirebaseAuth.instance.currentUser;

    _activeUserId = user?.uid;
    _completedLessonIds.clear();

    await _loadLocalProgress(
      userId: _activeUserId,
      allowLegacyMigration: user != null,
    );

    if (user == null) {
      _applyCompletedLessons();
      return;
    }

    final document = _progressDocument();

    if (document == null) {
      _applyCompletedLessons();
      return;
    }

    try {
      final snapshot = await document.get();

      if (snapshot.exists) {
        final data = snapshot.data();

        if (data != null) {
          _mergeRemoteProgress(data);
        }
      }

      _applyCompletedLessons();

      await _saveLocalProgress();
      await _saveRemoteProgress();
    } catch (error) {
      debugPrint('AppProgress: não foi possível carregar o Firestore: $error');

      _applyCompletedLessons();
    }
  }

  static Future<void> _loadLocalProgress({
    required String? userId,
    required bool allowLegacyMigration,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    final scopedCompletedLessonsKey = _scopedKey(_completedLessonsKey, userId);

    final scopedLessons = preferences.getStringList(scopedCompletedLessonsKey);

    if (scopedLessons != null) {
      _completedLessonIds.addAll(scopedLessons);
      return;
    }

    if (!allowLegacyMigration) {
      return;
    }

    if (preferences.getBool(_algebraFundamentalLegacyKey) ?? false) {
      _completedLessonIds.add(algebraFundamentalId);
    }

    if (preferences.getBool(_equationsAndInequationsLegacyKey) ?? false) {
      _completedLessonIds.add(equationsAndInequationsId);
    }

    if (preferences.getBool(_functionsLegacyKey) ?? false) {
      _completedLessonIds.add(functionsId);
    }

    if (preferences.getBool(_limitsLegacyKey) ?? false) {
      _completedLessonIds.add(limitsId);
    }
  }

  static void _mergeRemoteProgress(Map<String, dynamic> data) {
    final remoteLessons = data['completedLessonIds'];

    if (remoteLessons is Iterable) {
      _completedLessonIds.addAll(remoteLessons.whereType<String>());
      return;
    }

    if (data['algebraFundamentalCompleted'] == true) {
      _completedLessonIds.add(algebraFundamentalId);
    }

    if (data['equationsAndInequationsCompleted'] == true) {
      _completedLessonIds.add(equationsAndInequationsId);
    }

    if (data['functionsCompleted'] == true) {
      _completedLessonIds.add(functionsId);
    }

    if (data['limitsCompleted'] == true) {
      _completedLessonIds.add(limitsId);
    }
  }

  static void _applyCompletedLessons() {
    algebraFundamentalCompleted = _completedLessonIds.contains(
      algebraFundamentalId,
    );

    equationsAndInequationsCompleted = _completedLessonIds.contains(
      equationsAndInequationsId,
    );

    functionsCompleted = _completedLessonIds.contains(functionsId);

    limitsCompleted = _completedLessonIds.contains(limitsId);

    totalXp = 0;
    totalGold = 0;

    if (algebraFundamentalCompleted) {
      totalXp += 60;
      totalGold += 25;
    }

    if (equationsAndInequationsCompleted) {
      totalXp += 70;
      totalGold += 30;
    }

    if (functionsCompleted) {
      totalXp += 80;
      totalGold += 35;
    }

    if (limitsCompleted) {
      totalXp += 90;
      totalGold += 40;
    }

    revision.value++;
  }

  static Future<void> _saveLocalProgress() async {
    final preferences = await SharedPreferences.getInstance();

    final scopedCompletedLessonsKey = _scopedKey(
      _completedLessonsKey,
      _activeUserId,
    );

    final sortedLessons = _completedLessonIds.toList()..sort();

    await preferences.setStringList(scopedCompletedLessonsKey, sortedLessons);
  }

  static Future<void> _saveRemoteProgress() async {
    final document = _progressDocument();

    if (document == null) {
      return;
    }

    final sortedLessons = _completedLessonIds.toList()..sort();

    await document.set(<String, dynamic>{
      'completedLessonIds': sortedLessons,
      'algebraFundamentalCompleted': algebraFundamentalCompleted,
      'equationsAndInequationsCompleted': equationsAndInequationsCompleted,
      'functionsCompleted': functionsCompleted,
      'limitsCompleted': limitsCompleted,
      'totalXp': totalXp,
      'totalGold': totalGold,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> _completeLesson(String lessonId) async {
    _completedLessonIds.add(lessonId);
    _applyCompletedLessons();

    await _saveLocalProgress();

    try {
      await _saveRemoteProgress();
    } catch (error) {
      debugPrint(
        'AppProgress: progresso salvo localmente, '
        'mas não foi enviado ao Firestore: $error',
      );
    }
  }

  static Future<void> completeAlgebraFundamental() {
    return _completeLesson(algebraFundamentalId);
  }

  static Future<void> completeEquationsAndInequations() {
    return _completeLesson(equationsAndInequationsId);
  }

  static Future<void> completeFunctions() {
    return _completeLesson(functionsId);
  }

  static Future<void> completeLimits() {
    return _completeLesson(limitsId);
  }

  static Future<void> resetProgress() async {
    final user = FirebaseAuth.instance.currentUser;

    _activeUserId = user?.uid;
    _completedLessonIds.clear();
    _applyCompletedLessons();

    await _saveLocalProgress();

    final document = _progressDocument();

    if (document == null) {
      return;
    }

    try {
      await document.set(<String, dynamic>{
        'completedLessonIds': <String>[],
        'algebraFundamentalCompleted': false,
        'equationsAndInequationsCompleted': false,
        'functionsCompleted': false,
        'limitsCompleted': false,
        'totalXp': 0,
        'totalGold': 0,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      debugPrint(
        'AppProgress: não foi possível zerar o '
        'progresso remoto: $error',
      );

      rethrow;
    }
  }

  static void clearSession() {
    _activeUserId = null;
    _completedLessonIds.clear();

    algebraFundamentalCompleted = false;
    equationsAndInequationsCompleted = false;
    functionsCompleted = false;
    limitsCompleted = false;
    totalXp = 0;
    totalGold = 0;

    revision.value++;
  }
}
