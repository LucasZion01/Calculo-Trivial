import 'dart:async';

import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/data/localized_derivatives_exercise_content.dart';
import 'package:calcquest/shared/data/mock_derivatives_exercise_data.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/domain/exercise_review_item.dart';
import 'package:calcquest/shared/domain/final_test_session_builder.dart';
import 'package:calcquest/shared/services/learning_difficulty_tracker.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../result/presentation/result_screen.dart';

class DerivativesFinalTestScreen extends StatefulWidget {
  final Set<String> practiceQuestionIds;

  const DerivativesFinalTestScreen({
    super.key,
    required this.practiceQuestionIds,
  });

  @override
  State<DerivativesFinalTestScreen> createState() =>
      _DerivativesFinalTestScreenState();
}

class _DerivativesFinalTestScreenState extends State<DerivativesFinalTestScreen> {
  late final List<ExerciseData> sessionExercises;
  final List<ExerciseReviewItem> reviewItems = <ExerciseReviewItem>[];

  int currentExerciseIndex = 0;
  int correctAnswers = 0;
  String? selectedOptionId;

  bool get _isEnglish =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  @override
  void initState() {
    super.initState();

    sessionExercises = FinalTestSessionBuilder.build(
      lessonId: AppProgress.derivativesId,
      exercises: mockDerivativesExercises,
      practiceQuestionIds: widget.practiceQuestionIds,
    );
  }

  ExerciseData get currentExercise => localizeDerivativesExerciseContent(
        sessionExercises[currentExerciseIndex],
        Localizations.localeOf(context),
      );

  bool get isLastExercise =>
      currentExerciseIndex == sessionExercises.length - 1;

  double get progress => (currentExerciseIndex + 1) / sessionExercises.length;

  String _difficultyLabel(
    ExerciseDifficulty difficulty,
    AppLocalizations l10n,
  ) {
    return switch (difficulty) {
      ExerciseDifficulty.foundation => l10n.exerciseDifficultyFoundation,
      ExerciseDifficulty.intermediate => l10n.exerciseDifficultyIntermediate,
      ExerciseDifficulty.challenge => l10n.exerciseDifficultyChallenge,
    };
  }

  void _confirmAnswer() {
    final l10n = AppLocalizations.of(context)!;

    if (selectedOptionId == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.warning,
            content: Text(l10n.exerciseChooseAlternative),
          ),
        );
      return;
    }

    final exercise = currentExercise;
    final isCorrect = selectedOptionId == exercise.correctOptionId;
    final selectedOption = exercise.options.firstWhere(
      (option) => option.id == selectedOptionId,
    );
    final correctOption = exercise.options.firstWhere(
      (option) => option.id == exercise.correctOptionId,
    );

    AppProgress.recordExerciseAnswer(isCorrect: isCorrect);
    unawaited(
      LearningDifficultyTracker.recordFinalTestAttempt(
        moduleId: AppProgress.derivativesId,
        exercise: exercise,
        isCorrect: isCorrect,
      ),
    );

    if (isCorrect) {
      correctAnswers++;
    } else {
      reviewItems.add(
        ExerciseReviewItem(
          questionId: exercise.id,
          statement: exercise.statement,
          selectedAnswer: selectedOption.text,
          correctAnswer: correctOption.text,
          explanation: exercise.explanation,
        ),
      );
    }

    if (isLastExercise) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            completedLessonId: AppProgress.derivativesId,
            totalQuestions: sessionExercises.length,
            correctAnswers: correctAnswers,
            xpEarned: 110,
            goldEarned: 50,
            reviewItems: List<ExerciseReviewItem>.unmodifiable(reviewItems),
            enableLearningRecommendation: true,
          ),
        ),
      );
      return;
    }

    setState(() {
      currentExerciseIndex++;
      selectedOptionId = null;
    });
  }

  Widget _buildOption(ExerciseOptionData option, int index) {
    final isSelected = selectedOptionId == option.id;
    const letters = <String>['A', 'B', 'C', 'D'];

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: () => setState(() => selectedOptionId = option.id),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.selectedBackground
                : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Text(
                  letters[index],
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(option.text, style: AppTypography.bodyLarge)),
              if (isSelected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final exercise = currentExercise;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(_isEnglish ? 'Final test' : 'Teste final'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.md,
            AppSpacing.screenHorizontal,
            AppSpacing.screenBottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEnglish
                    ? 'Question ${currentExerciseIndex + 1} of ${sessionExercises.length}'
                    : 'Questão ${currentExerciseIndex + 1} de ${sessionExercises.length}',
                style: AppTypography.headingSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _isEnglish
                    ? 'Answer without immediate feedback. Corrections appear only after the test.'
                    : 'Responda sem feedback imediato. A correção aparece somente após o teste.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 300),
                builder: (context, value, child) => AppProgressBar(value: value),
              ),
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  if (exercise.skill != null)
                    Chip(
                      avatar: const Icon(Icons.school_outlined, size: 18),
                      label: Text(exercise.skill!),
                    ),
                  Chip(
                    avatar: const Icon(Icons.signal_cellular_alt_rounded, size: 18),
                    label: Text(_difficultyLabel(exercise.difficulty, l10n)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  exercise.statement,
                  style: AppTypography.headingSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView.separated(
                  itemCount: exercise.options.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) =>
                      _buildOption(exercise.options[index], index),
                ),
              ),
              PrimaryButton(
                text: isLastExercise
                    ? (_isEnglish ? 'Finish test' : 'Finalizar teste')
                    : (_isEnglish
                          ? 'Confirm and continue'
                          : 'Confirmar e continuar'),
                icon: isLastExercise
                    ? Icons.flag_rounded
                    : Icons.arrow_forward_rounded,
                onPressed: _confirmAnswer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
