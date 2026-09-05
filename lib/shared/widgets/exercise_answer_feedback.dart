import 'dart:async';

import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/domain/exercise_feedback_guidance.dart';
import 'package:calcquest/shared/services/learning_difficulty_tracker.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

Future<void> showExerciseAnswerFeedback({
  required BuildContext context,
  required ExerciseData exercise,
  required bool isCorrect,
  required String selectedAnswer,
  required String correctAnswer,
  required bool isLastExercise,
}) {
  unawaited(
    LearningDifficultyTracker.recordPracticeAttempt(
      exercise: exercise,
      isCorrect: isCorrect,
    ),
  );

  return showModalBottomSheet<void>(
    context: context,
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSpacing.radiusXLarge),
      ),
    ),
    builder: (sheetContext) => ExerciseAnswerFeedbackContent(
      exercise: exercise,
      isCorrect: isCorrect,
      selectedAnswer: selectedAnswer,
      correctAnswer: correctAnswer,
      isLastExercise: isLastExercise,
      onContinue: () => Navigator.of(sheetContext).pop(),
    ),
  );
}

class ExerciseAnswerFeedbackContent extends StatefulWidget {
  final ExerciseData exercise;
  final bool isCorrect;
  final String selectedAnswer;
  final String correctAnswer;
  final bool isLastExercise;
  final VoidCallback onContinue;

  const ExerciseAnswerFeedbackContent({
    super.key,
    required this.exercise,
    required this.isCorrect,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isLastExercise,
    required this.onContinue,
  });

  @override
  State<ExerciseAnswerFeedbackContent> createState() =>
      _ExerciseAnswerFeedbackContentState();
}

class _ExerciseAnswerFeedbackContentState
    extends State<ExerciseAnswerFeedbackContent> {
  int _helpStage = 0;

  bool get _isEnglish =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  ExerciseFeedbackGuidance get _guidance => resolveExerciseFeedbackGuidance(
        skill: widget.exercise.skill,
        isEnglish: _isEnglish,
      );

  Widget _guidanceCard({
    required String title,
    required String body,
    IconData icon = Icons.lightbulb_outline_rounded,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.selectedBackground,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(body, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }

  Widget _explanationCard(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.feedbackStepByStep, style: AppTypography.labelMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(widget.exercise.explanation, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final color = widget.isCorrect ? AppColors.success : AppColors.error;
    final background = widget.isCorrect
        ? AppColors.successLight
        : AppColors.errorLight;
    final guidance = _guidance;
    final showSolution = widget.isCorrect || _helpStage >= 2;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.lg,
          AppSpacing.screenHorizontal,
          MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.isCorrect ? Icons.check_rounded : Icons.close_rounded,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                widget.isCorrect
                    ? l10n.feedbackGoodAnalysis
                    : l10n.feedbackUnderstandError,
                style: AppTypography.headingSmall,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.feedbackYourAnswer(widget.selectedAnswer),
                style: AppTypography.bodyMedium.copyWith(
                  color: widget.isCorrect
                      ? AppColors.successDark
                      : AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!widget.isCorrect && !showSolution) ...[
                const SizedBox(height: AppSpacing.md),
                _guidanceCard(
                  title: _isEnglish ? 'First hint' : 'Primeira pista',
                  body: guidance.firstHint,
                ),
                if (_helpStage >= 1) ...[
                  const SizedBox(height: AppSpacing.sm),
                  _guidanceCard(
                    title: _isEnglish ? 'Next step' : 'Próximo passo',
                    body: guidance.nextStep,
                    icon: Icons.route_outlined,
                  ),
                ],
              ],
              if (!widget.isCorrect && showSolution) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.feedbackCorrectAnswer(widget.correctAnswer),
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.successDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              if (showSolution) ...[
                const SizedBox(height: AppSpacing.md),
                _explanationCard(l10n),
              ],
              const SizedBox(height: AppSpacing.lg),
              if (!widget.isCorrect && _helpStage == 0)
                PrimaryButton(
                  text: _isEnglish
                      ? 'Show next hint'
                      : 'Mostrar próxima pista',
                  icon: Icons.lightbulb_outline_rounded,
                  onPressed: () => setState(() => _helpStage = 1),
                )
              else if (!widget.isCorrect && _helpStage == 1)
                PrimaryButton(
                  text: _isEnglish ? 'Show solution' : 'Mostrar solução',
                  icon: Icons.visibility_outlined,
                  onPressed: () => setState(() => _helpStage = 2),
                )
              else
                PrimaryButton(
                  text: widget.isLastExercise
                      ? l10n.feedbackViewResult
                      : l10n.feedbackContinuePracticing,
                  icon: widget.isLastExercise
                      ? Icons.analytics_outlined
                      : Icons.arrow_forward_rounded,
                  onPressed: widget.onContinue,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
