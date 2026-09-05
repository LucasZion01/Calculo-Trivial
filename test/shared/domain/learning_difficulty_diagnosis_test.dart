import 'package:flutter_test/flutter_test.dart';

import 'package:calcquest/shared/domain/learning_difficulty_diagnosis.dart';

LearningAttemptSignal signal({
  required String questionId,
  required bool correct,
  LearningAttemptPhase phase = LearningAttemptPhase.practice,
  String moduleId = 'limites',
  String lessonId = 'limites-04-fatoracao',
  String skill = 'Fatorar antes de calcular o limite',
}) {
  return LearningAttemptSignal(
    moduleId: moduleId,
    questionId: questionId,
    contentLessonId: lessonId,
    skill: skill,
    isCorrect: correct,
    phase: phase,
  );
}

void main() {
  test('não chama um erro isolado de dificuldade', () {
    final diagnosis = LearningDifficultyDiagnoser.evaluate([
      signal(questionId: 'q1', correct: false),
    ]);

    expect(diagnosis.reviewRecommendations, isEmpty);
  });

  test('não recomenda revisão com evidência insuficiente', () {
    final diagnosis = LearningDifficultyDiagnoser.evaluate([
      signal(questionId: 'q1', correct: false),
      signal(questionId: 'q2', correct: false),
    ]);

    expect(diagnosis.reviewRecommendations, isEmpty);
  });

  test('recomenda revisão após erros repetidos e taxa mínima', () {
    final diagnosis = LearningDifficultyDiagnoser.evaluate([
      signal(questionId: 'q1', correct: false),
      signal(questionId: 'q2', correct: false),
      signal(questionId: 'q3', correct: true),
    ]);

    expect(diagnosis.reviewRecommendations, hasLength(1));
    final evidence = diagnosis.reviewRecommendations.single;
    expect(evidence.attempts, 3);
    expect(evidence.errors, 2);
    expect(evidence.errorRate, closeTo(2 / 3, 0.001));
  });

  test('não recomenda revisão quando a taxa de erro fica abaixo de 50%', () {
    final diagnosis = LearningDifficultyDiagnoser.evaluate([
      signal(questionId: 'q1', correct: false),
      signal(questionId: 'q2', correct: false),
      signal(questionId: 'q3', correct: true),
      signal(questionId: 'q4', correct: true),
      signal(questionId: 'q5', correct: true),
    ]);

    expect(diagnosis.reviewRecommendations, isEmpty);
  });

  test('prioriza evidência com erros no teste final', () {
    final signals = [
      signal(
        questionId: 'a1',
        correct: false,
        lessonId: 'limites-04-fatoracao',
        skill: 'Fatoração',
      ),
      signal(
        questionId: 'a2',
        correct: false,
        lessonId: 'limites-04-fatoracao',
        skill: 'Fatoração',
      ),
      signal(
        questionId: 'a3',
        correct: true,
        lessonId: 'limites-04-fatoracao',
        skill: 'Fatoração',
      ),
      signal(
        questionId: 'b1',
        correct: false,
        phase: LearningAttemptPhase.finalTest,
        lessonId: 'limites-02-laterais',
        skill: 'Limites laterais',
      ),
      signal(
        questionId: 'b2',
        correct: false,
        phase: LearningAttemptPhase.finalTest,
        lessonId: 'limites-02-laterais',
        skill: 'Limites laterais',
      ),
      signal(
        questionId: 'b3',
        correct: true,
        lessonId: 'limites-02-laterais',
        skill: 'Limites laterais',
      ),
    ];

    final diagnosis = LearningDifficultyDiagnoser.evaluate(signals);

    expect(diagnosis.reviewRecommendations, hasLength(2));
    expect(diagnosis.reviewRecommendations.first.skill, 'Limites laterais');
    expect(diagnosis.reviewRecommendations.first.finalTestErrors, 2);
  });

  test('separa habilidades mesmo quando pertencem ao mesmo módulo', () {
    final diagnosis = LearningDifficultyDiagnoser.evaluate([
      signal(questionId: 'a1', correct: false, skill: 'Fatoração'),
      signal(questionId: 'a2', correct: false, skill: 'Fatoração'),
      signal(questionId: 'a3', correct: true, skill: 'Fatoração'),
      signal(
        questionId: 'b1',
        correct: false,
        lessonId: 'limites-05-racionalizacao',
        skill: 'Racionalização',
      ),
      signal(
        questionId: 'b2',
        correct: false,
        lessonId: 'limites-05-racionalizacao',
        skill: 'Racionalização',
      ),
      signal(
        questionId: 'b3',
        correct: true,
        lessonId: 'limites-05-racionalizacao',
        skill: 'Racionalização',
      ),
    ]);

    expect(diagnosis.reviewRecommendations, hasLength(2));
  });

  test('ignora sinais sem metadados pedagógicos estáveis', () {
    final diagnosis = LearningDifficultyDiagnoser.evaluate([
      const LearningAttemptSignal(
        moduleId: 'limites',
        questionId: 'q1',
        contentLessonId: '',
        skill: 'Fatoração',
        isCorrect: false,
        phase: LearningAttemptPhase.practice,
      ),
      signal(questionId: 'q2', correct: true),
    ]);

    expect(diagnosis.analyzedAttempts, 1);
    expect(diagnosis.reviewRecommendations, isEmpty);
  });
}
