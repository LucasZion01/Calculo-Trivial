import 'package:calcquest/shared/data/mock_exercise_data.dart';

class EquationLearningMetadata {
  final String contentLessonId;
  final String skill;

  const EquationLearningMetadata({
    required this.contentLessonId,
    required this.skill,
  });
}

const Map<String, EquationLearningMetadata> equationsLearningMetadata = {
  'equacao-1': EquationLearningMetadata(
    contentLessonId: 'equations-01-equilibrio',
    skill: 'Preservação da igualdade',
  ),
  'equacao-2': EquationLearningMetadata(
    contentLessonId: 'equations-02-primeiro-grau',
    skill: 'Isolamento da incógnita por divisão',
  ),
  'equacao-3': EquationLearningMetadata(
    contentLessonId: 'equations-01-equilibrio',
    skill: 'Preservação da igualdade',
  ),
  'equacao-4': EquationLearningMetadata(
    contentLessonId: 'equations-02-primeiro-grau',
    skill: 'Operações inversas em equação linear',
  ),
  'inequacao-1': EquationLearningMetadata(
    contentLessonId: 'equations-07-inequacoes',
    skill: 'Isolamento da incógnita em inequações',
  ),
  'equacao-5': EquationLearningMetadata(
    contentLessonId: 'equations-02-primeiro-grau',
    skill: 'Operações inversas em equação linear',
  ),
  'equacao-distributiva': EquationLearningMetadata(
    contentLessonId: 'equations-03-parenteses-fracoes',
    skill: 'Equações com parênteses',
  ),
  'equacao-fracao': EquationLearningMetadata(
    contentLessonId: 'equations-03-parenteses-fracoes',
    skill: 'Equações com frações',
  ),
  'inequacao-2': EquationLearningMetadata(
    contentLessonId: 'equations-07-inequacoes',
    skill: 'Inequações lineares',
  ),
  'inequacao-negativa': EquationLearningMetadata(
    contentLessonId: 'equations-07-inequacoes',
    skill: 'Inversão do sinal em inequações',
  ),
  'equacao-termos-dois-lados': EquationLearningMetadata(
    contentLessonId: 'equations-02-primeiro-grau',
    skill: 'Incógnita nos dois membros',
  ),
  'equacao-distributiva-dois-lados': EquationLearningMetadata(
    contentLessonId: 'equations-03-parenteses-fracoes',
    skill: 'Distributiva em equações',
  ),
  'equacao-fracionaria-2': EquationLearningMetadata(
    contentLessonId: 'equations-03-parenteses-fracoes',
    skill: 'Eliminação de denominadores',
  ),
  'sistema-linear-1': EquationLearningMetadata(
    contentLessonId: 'equations-05-sistemas-lineares',
    skill: 'Resolução de sistemas lineares',
  ),
  'equacao-quadratica-1': EquationLearningMetadata(
    contentLessonId: 'equations-06-quadraticas',
    skill: 'Raízes de equação quadrática simples',
  ),
  'equacao-quadratica-2': EquationLearningMetadata(
    contentLessonId: 'equations-06-quadraticas',
    skill: 'Fatoração e produto nulo',
  ),
  'inequacao-3': EquationLearningMetadata(
    contentLessonId: 'equations-07-inequacoes',
    skill: 'Inversão do sinal em inequações',
  ),
  'inequacao-distributiva': EquationLearningMetadata(
    contentLessonId: 'equations-07-inequacoes',
    skill: 'Distributiva em inequações',
  ),
  'equacao-modular-1': EquationLearningMetadata(
    contentLessonId: 'equations-08-modulo-revisao',
    skill: 'Equação modular básica',
  ),
  'equacao-sem-solucao': EquationLearningMetadata(
    contentLessonId: 'equations-04-casos-especiais',
    skill: 'Identificação de contradição',
  ),
};

ExerciseData withEquationsLearningMetadata(ExerciseData exercise) {
  final metadata = equationsLearningMetadata[exercise.id];
  if (metadata == null) return exercise;

  return ExerciseData(
    id: exercise.id,
    title: exercise.title,
    statement: exercise.statement,
    options: exercise.options,
    correctOptionId: exercise.correctOptionId,
    explanation: exercise.explanation,
    contentLessonId: metadata.contentLessonId,
    skill: metadata.skill,
    difficulty: exercise.difficulty,
  );
}
