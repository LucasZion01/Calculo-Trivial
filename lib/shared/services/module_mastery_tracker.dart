import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/domain/module_mastery_policy.dart';

class ModuleMasteryTracker {
  static const String _practiceKey = 'module_mastery_best_practice_v1';
  static const String _finalTestKey = 'module_mastery_best_final_test_v1';

  const ModuleMasteryTracker._();

  static String _scope() {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid.trim();
      if (uid != null && uid.isNotEmpty) return uid;
    } catch (_) {
      // Firebase may be unavailable in isolated tests. Guest scope is safe.
    }
    return 'guest';
  }

  static String _key(String base, String moduleId) {
    return '${_scope()}_${base}_$moduleId';
  }

  static DocumentReference<Map<String, dynamic>>? _document(String moduleId) {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('module_mastery')
          .doc(moduleId);
    } catch (_) {
      return null;
    }
  }

  static double _accuracy({
    required int correctAnswers,
    required int totalQuestions,
  }) {
    if (totalQuestions <= 0) return 0;
    return (correctAnswers / totalQuestions).clamp(0.0, 1.0).toDouble();
  }

  static Future<ModuleMasteryEvidence> loadEvidence({
    required String moduleId,
    bool legacyCompleted = false,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    var bestPractice = preferences.getDouble(_key(_practiceKey, moduleId));
    var bestFinalTest = preferences.getDouble(_key(_finalTestKey, moduleId));

    final document = _document(moduleId);
    if (document != null) {
      try {
        final snapshot = await document.get();
        final data = snapshot.data();
        final remotePractice = data?['bestPracticeAccuracy'];
        final remoteFinalTest = data?['bestFinalTestAccuracy'];

        if (remotePractice is num) {
          bestPractice = max(bestPractice ?? 0, remotePractice.toDouble());
        }
        if (remoteFinalTest is num) {
          bestFinalTest = max(bestFinalTest ?? 0, remoteFinalTest.toDouble());
        }

        if (bestPractice != null) {
          await preferences.setDouble(_key(_practiceKey, moduleId), bestPractice);
        }
        if (bestFinalTest != null) {
          await preferences.setDouble(_key(_finalTestKey, moduleId), bestFinalTest);
        }
      } catch (_) {
        // Local evidence remains authoritative while the network is unavailable.
      }
    }

    return ModuleMasteryEvidence(
      bestPracticeAccuracy: bestPractice,
      bestFinalTestAccuracy: bestFinalTest,
      legacyCompleted: legacyCompleted,
    );
  }

  static Future<ModuleMasteryEvidence> recordPracticeResult({
    required String moduleId,
    required int correctAnswers,
    required int totalQuestions,
    bool legacyCompleted = false,
  }) async {
    final accuracy = _accuracy(
      correctAnswers: correctAnswers,
      totalQuestions: totalQuestions,
    );
    return _record(
      moduleId: moduleId,
      practiceAccuracy: accuracy,
      legacyCompleted: legacyCompleted,
    );
  }

  static Future<ModuleMasteryEvidence> recordFinalTestResult({
    required String moduleId,
    required int correctAnswers,
    required int totalQuestions,
    bool legacyCompleted = false,
  }) async {
    final accuracy = _accuracy(
      correctAnswers: correctAnswers,
      totalQuestions: totalQuestions,
    );
    return _record(
      moduleId: moduleId,
      finalTestAccuracy: accuracy,
      legacyCompleted: legacyCompleted,
    );
  }

  static Future<ModuleMasteryEvidence> _record({
    required String moduleId,
    double? practiceAccuracy,
    double? finalTestAccuracy,
    required bool legacyCompleted,
  }) async {
    final current = await loadEvidence(
      moduleId: moduleId,
      legacyCompleted: legacyCompleted,
    );
    final preferences = await SharedPreferences.getInstance();

    final bestPractice = practiceAccuracy == null
        ? current.bestPracticeAccuracy
        : max(current.bestPracticeAccuracy ?? 0, practiceAccuracy);
    final bestFinalTest = finalTestAccuracy == null
        ? current.bestFinalTestAccuracy
        : max(current.bestFinalTestAccuracy ?? 0, finalTestAccuracy);

    if (bestPractice != null) {
      await preferences.setDouble(_key(_practiceKey, moduleId), bestPractice);
    }
    if (bestFinalTest != null) {
      await preferences.setDouble(_key(_finalTestKey, moduleId), bestFinalTest);
    }

    final document = _document(moduleId);
    if (document != null) {
      try {
        await document.set(<String, dynamic>{
          if (bestPractice != null) 'bestPracticeAccuracy': bestPractice,
          if (bestFinalTest != null) 'bestFinalTestAccuracy': bestFinalTest,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } catch (_) {
        // The result is already durable locally and can be merged later.
      }
    }

    return ModuleMasteryEvidence(
      bestPracticeAccuracy: bestPractice,
      bestFinalTestAccuracy: bestFinalTest,
      legacyCompleted: legacyCompleted,
    );
  }

  static Future<void> clearCurrentScopeForTesting(String moduleId) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_key(_practiceKey, moduleId));
    await preferences.remove(_key(_finalTestKey, moduleId));
  }
}
