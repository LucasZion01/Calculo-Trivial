import 'exercise_feedback_guidance.dart';

class ExerciseSelfExplanationOption {
  final String id;
  final String text;

  const ExerciseSelfExplanationOption({
    required this.id,
    required this.text,
  });
}

class ExerciseSelfExplanationQuestion {
  final String prompt;
  final List<ExerciseSelfExplanationOption> options;
  final String correctOptionId;
  final String successMessage;
  final String correctionMessage;

  const ExerciseSelfExplanationQuestion({
    required this.prompt,
    required this.options,
    required this.correctOptionId,
    required this.successMessage,
    required this.correctionMessage,
  });
}

ExerciseSelfExplanationQuestion? resolveExerciseSelfExplanationQuestion({
  required String? skill,
  required bool isEnglish,
}) {
  final trimmedSkill = skill?.trim();
  if (trimmedSkill == null || trimmedSkill.isEmpty) {
    return null;
  }

  final guidance = resolveExerciseFeedbackGuidance(
    skill: trimmedSkill,
    isEnglish: isEnglish,
  );

  if (!guidance.isSpecific) {
    return null;
  }

  return ExerciseSelfExplanationQuestion(
    prompt: isEnglish
        ? 'Which idea was decisive in this question?'
        : 'Qual foi a ideia decisiva nesta questão?',
    options: [
      ExerciseSelfExplanationOption(
        id: 'skill',
        text: trimmedSkill,
      ),
      ExerciseSelfExplanationOption(
        id: 'numbers_only',
        text: isEnglish
            ? 'Focus only on the numerical calculations, without checking the mathematical structure.'
            : 'Focar apenas nos cálculos numéricos, sem verificar a estrutura matemática.',
      ),
      ExerciseSelfExplanationOption(
        id: 'visual_match',
        text: isEnglish
            ? 'Choose the alternative that looks most similar to the statement.'
            : 'Escolher a alternativa que mais se parece visualmente com o enunciado.',
      ),
    ],
    correctOptionId: 'skill',
    successMessage: isEnglish
        ? 'Exactly. That was the central mathematical idea.'
        : 'Isso. Essa foi a ideia matemática central.',
    correctionMessage: isEnglish
        ? 'Compare with the solution: the central idea was “$trimmedSkill”.'
        : 'Compare com a solução: a ideia central foi “$trimmedSkill”.',
  );
}
