import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:calcquest/shared/data/equations_learning_metadata.dart';
import 'package:calcquest/shared/data/mock_continuity_exercise_data.dart';
import 'package:calcquest/shared/data/mock_derivatives_exercise_data.dart';
import 'package:calcquest/shared/data/mock_equations_exercise_data.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/data/mock_functions_exercise_data.dart';
import 'package:calcquest/shared/data/mock_limits_exercise_data.dart';
import 'package:calcquest/shared/domain/learning_difficulty_diagnosis.dart';
import 'package:calcquest/shared/state/app_progress.dart';

class LearningDifficultyTracker {
  LearningDifficultyTracker._();

  static const String _storageKey = 'learning_difficulty_attempt_signals_v1';
  static const int _maxSignals = 180;

  static Future<void> _writeQueue = Future<void>.value();

  static final Map<String, String> _moduleByQuestionId = <String, String>{
    for (final exercise in mockExercises)
      exercise.id: AppProgress.algebraFundamentalId,
    for (final exercise in mockEquationsExercises)
      exercise.id: AppProgress.equationsAndInequationsId,
    for (final exercise in mockFunctionsExercises)
      exercise.id: AppProgress.functionsId,
    for (final exercise in mockLimitsExercises)
      exercise.id: AppProgress.limitsId,
    for (final exercise in mockContinuityExercises)
      exercise.id: AppProgress.continuityId,
    for (final exercise in mockDerivativesExercises)
      exercise.id: AppProgress.derivativesId,
  };

  static const Map<String, String> _functionSkillByQuestionId = <String, String>{
    'funcoes-dominio': 'Domínio de funções',
    'funcoes-dominio-racional': 'Domínio de funções',
    'funcoes-composicao': 'Composição de funções',
    'funcoes-composicao-inversa': 'Composição de funções',
    'funcoes-composicao-3': 'Composição de funções',
    'funcoes-inversa': 'Função inversa',
    'funcoes-inversa-2': 'Função inversa',
    'funcoes-paridade': 'Paridade de funções',
    'funcoes-impar': 'Paridade de funções',
    'funcoes-imagem-quadratica': 'Imagem e extremos de funções quadráticas',
    'funcoes-vertice': 'Imagem e extremos de funções quadráticas',
    'funcoes-imagem-quadratica-2': 'Imagem e extremos de funções quadráticas',
    'funcoes-valor-numerico': 'Avaliação de funções',
    'funcoes-valor-numerico-2': 'Avaliação de funções',
    'funcoes-exponencial': 'Avaliação de funções',
    'funcoes-raizes': 'Zeros de funções',
    'funcoes-coeficiente-angular': 'Interpretação de função afim',
    'funcoes-crescimento-afim': 'Interpretação de função afim',
    'funcoes-intersecao-eixo-y': 'Interpretação de função afim',
    'funcoes-imagem-modulo': 'Imagem de funções',
  };

  static String _scope() {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid.trim();
      if (uid != null && uid.isNotEmpty) return uid;
    } catch (_) {
      // Firebase may not be initialized in isolated unit tests.
    }

    return 'guest';
  }

  static String _scopedStorageKey() => '${_scope()}_$_storageKey';

  static Future<void> recordPracticeAttempt({
    required ExerciseData exercise,
    required bool isCorrect,
  }) {
    final moduleId = _moduleByQuestionId[exercise.id];
    if (moduleId == null) return Future<void>.value();

    return recordAttempt(
      moduleId: moduleId,
      exercise: exercise,
      isCorrect: isCorrect,
      phase: LearningAttemptPhase.practice,
    );
  }

  static Future<void> recordFinalTestAttempt({
    required String moduleId,
    required ExerciseData exercise,
    required bool isCorrect,
  }) {
    return recordAttempt(
      moduleId: moduleId,
      exercise: exercise,
      isCorrect: isCorrect,
      phase: LearningAttemptPhase.finalTest,
    );
  }

  static Future<void> recordAttempt({
    required String moduleId,
    required ExerciseData exercise,
    required bool isCorrect,
    required LearningAttemptPhase phase,
  }) {
    final normalizedExercise = moduleId == AppProgress.equationsAndInequationsId
        ? withEquationsLearningMetadata(exercise)
        : exercise;

    final explicitContentLessonId = normalizedExercise.contentLessonId?.trim();
    final explicitSkill = normalizedExercise.skill?.trim();

    final contentLessonId =
        explicitContentLessonId != null && explicitContentLessonId.isNotEmpty
        ? explicitContentLessonId
        : moduleId == AppProgress.functionsId
            ? AppProgress.functionsId
            : null;

    final skill = explicitSkill != null && explicitSkill.isNotEmpty
        ? explicitSkill
        : _functionSkillByQuestionId[normalizedExercise.id];

    if (moduleId.trim().isEmpty ||
        contentLessonId == null ||
        contentLessonId.isEmpty ||
        skill == null ||
        skill.isEmpty) {
      return Future<void>.value();
    }

    final signal = LearningAttemptSignal(
      moduleId: moduleId,
      questionId: normalizedExercise.id,
      contentLessonId: contentLessonId,
      skill: skill,
      isCorrect: isCorrect,
      phase: phase,
    );

    _writeQueue = _writeQueue.then((_) => _appendSignal(signal));
    return _writeQueue;
  }

  static Future<void> _appendSignal(LearningAttemptSignal signal) async {
    final signals = await _loadSignalsNow();
    final updated = <LearningAttemptSignal>[...signals, signal];
    final bounded = updated.length <= _maxSignals
        ? updated
        : updated.sublist(updated.length - _maxSignals);

    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _scopedStorageKey(),
      jsonEncode(bounded.map(_signalToJson).toList(growable: false)),
    );
  }

  static Future<List<LearningAttemptSignal>> loadSignals() async {
    await _writeQueue;
    return _loadSignalsNow();
  }

  static Future<List<LearningAttemptSignal>> _loadSignalsNow() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_scopedStorageKey());

    if (raw == null || raw.isEmpty) return const <LearningAttemptSignal>[];

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const <LearningAttemptSignal>[];

      return decoded
          .whereType<Map>()
          .map((item) => _signalFromJson(Map<String, dynamic>.from(item)))
          .whereType<LearningAttemptSignal>()
          .toList(growable: false);
    } catch (_) {
      return const <LearningAttemptSignal>[];
    }
  }

  static Future<LearningDifficultyDiagnosis> diagnose({String? moduleId}) async {
    final signals = await loadSignals();
    final selected = moduleId == null
        ? signals
        : signals.where((signal) => signal.moduleId == moduleId);

    return LearningDifficultyDiagnoser.evaluate(selected);
  }

  static Future<void> clearCurrentScope() {
    _writeQueue = _writeQueue.then((_) async {
      final preferences = await SharedPreferences.getInstance();
      await preferences.remove(_scopedStorageKey());
    });
    return _writeQueue;
  }

  static Map<String, dynamic> _signalToJson(LearningAttemptSignal signal) {
    return <String, dynamic>{
      'moduleId': signal.moduleId,
      'questionId': signal.questionId,
      'contentLessonId': signal.contentLessonId,
      'skill': signal.skill,
      'isCorrect': signal.isCorrect,
      'phase': signal.phase.name,
    };
  }

  static LearningAttemptSignal? _signalFromJson(Map<String, dynamic> json) {
    final moduleId = json['moduleId'];
    final questionId = json['questionId'];
    final contentLessonId = json['contentLessonId'];
    final skill = json['skill'];
    final isCorrect = json['isCorrect'];
    final phaseName = json['phase'];

    if (moduleId is! String ||
        questionId is! String ||
        contentLessonId is! String ||
        skill is! String ||
        isCorrect is! bool ||
        phaseName is! String) {
      return null;
    }

    LearningAttemptPhase? phase;
    for (final candidate in LearningAttemptPhase.values) {
      if (candidate.name == phaseName) {
        phase = candidate;
        break;
      }
    }

    if (phase == null) return null;

    return LearningAttemptSignal(
      moduleId: moduleId,
      questionId: questionId,
      contentLessonId: contentLessonId,
      skill: skill,
      isCorrect: isCorrect,
      phase: phase,
    );
  }
}
