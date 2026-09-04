import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/data/localized_algebra_exercise_content.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/domain/exercise_review_item.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/exercise_answer_feedback.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import 'algebra_final_test_screen.dart';

class AlgebraPracticeScreen extends StatefulWidget {
  const AlgebraPracticeScreen({super.key});

  @override
  State<AlgebraPracticeScreen> createState() => _AlgebraPracticeScreenState();
}

class _AlgebraPracticeScreenState extends State<AlgebraPracticeScreen> {
  late final List<ExerciseData> sessionExercises;
  final List<ExerciseReviewItem> reviewItems = <ExerciseReviewItem>[];

  int currentExerciseIndex = 0;
  int correctAnswers = 0;
  String? selectedOptionId;
  bool isShowingFeedback = false;

  bool get _isEnglish =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  @override
  void initState() {
    super.initState();

    final selectedIds = AppProgress.selectExerciseQuestionIds(
      lessonId: AppProgress.algebraFundamentalId,
      availableQuestionIds: mockExercises.map((exercise) => exercise.id),
    );

    final exercisesById = <String, ExerciseData>{
      for (final exercise in mockExercises) exercise.id: exercise,
    };

    sessionExercises = selectedIds
        .map((questionId) => exercisesById[questionId])
        .whereType<ExerciseData>()
        .toList(growable: false);
  }

  ExerciseData get currentExercise => localizeAlgebraExerciseContent(
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

  Future<void> _confirmAnswer() async {
    if (isShowingFeedback) return;

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

    setState(() => isShowingFeedback = true);
    AppProgress.recordExerciseAnswer(isCorrect: isCorrect);

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

    await showExerciseAnswerFeedback(
      context: context,
      exercise: exercise,
      isCorrect: isCorrect,
      selectedAnswer: selectedOption.text,
      correctAnswer: correctOption.text,
      isLastExercise: isLastExercise,
    );

    if (!mounted) return;

    if (isLastExercise) {
      _finishPractice();
      return;
    }

    setState(() {
      currentExerciseIndex++;
      selectedOptionId = null;
      isShowingFeedback = false;
    });
  }

  void _finishPractice() {
    final practiceIds = sessionExercises.map((exercise) => exercise.id).toSet();

    if (reviewItems.isEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => AlgebraFinalTestScreen(
            practiceQuestionIds: practiceIds,
          ),
        ),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => _AlgebraPracticeReviewScreen(
          reviewItems: List<ExerciseReviewItem>.unmodifiable(reviewItems),
          practiceQuestionIds: practiceIds,
          correctAnswers: correctAnswers,
          totalQuestions: sessionExercises.length,
        ),
      ),
    );
  }

  Widget _buildOption(ExerciseOptionData option, int index) {
    final isSelected = selectedOptionId == option.id;
    const letters = <String>['A', 'B', 'C', 'D'];

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: isShowingFeedback
            ? null
            : () => setState(() => selectedOptionId = option.id),
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
              Expanded(
                child: Text(option.text, style: AppTypography.bodyLarge),
              ),
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
        title: Text(_isEnglish ? 'Guided practice' : 'Prática guiada'),
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEnglish
                          ? 'Question ${currentExerciseIndex + 1} of ${sessionExercises.length}'
                          : 'Questão ${currentExerciseIndex + 1} de ${sessionExercises.length}',
                      style: AppTypography.headingSmall,
                    ),
                  ),
                  Text(
                    '${(progress * 100).round()}%',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _isEnglish
                    ? 'Use the feedback to correct your reasoning before the final test.'
                    : 'Use o feedback para corrigir seu raciocínio antes do teste final.',
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
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) =>
                      _buildOption(exercise.options[index], index),
                ),
              ),
              PrimaryButton(
                text: isLastExercise
                    ? (_isEnglish ? 'Finish practice' : 'Finalizar prática')
                    : (_isEnglish ? 'Check answer' : 'Verificar resposta'),
                icon: isLastExercise
                    ? Icons.fact_check_outlined
                    : Icons.arrow_forward_rounded,
                onPressed: isShowingFeedback ? null : _confirmAnswer,
                isLoading: isShowingFeedback,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlgebraPracticeReviewScreen extends StatefulWidget {
  final List<ExerciseReviewItem> reviewItems;
  final Set<String> practiceQuestionIds;
  final int correctAnswers;
  final int totalQuestions;

  const _AlgebraPracticeReviewScreen({
    required this.reviewItems,
    required this.practiceQuestionIds,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  State<_AlgebraPracticeReviewScreen> createState() =>
      _AlgebraPracticeReviewScreenState();
}

class _AlgebraPracticeReviewScreenState
    extends State<_AlgebraPracticeReviewScreen> {
  int currentIndex = 0;

  bool get _isEnglish =>
      Localizations.localeOf(context).languageCode.toLowerCase() == 'en';

  ExerciseReviewItem get currentItem => widget.reviewItems[currentIndex];

  bool get isLastItem => currentIndex == widget.reviewItems.length - 1;

  void _continue() {
    if (!isLastItem) {
      setState(() => currentIndex++);
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AlgebraFinalTestScreen(
          practiceQuestionIds: widget.practiceQuestionIds,
        ),
      ),
    );
  }

  Widget _answerCard({
    required String title,
    required String answer,
    required Color backgroundColor,
    required Color borderColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelMedium),
                const SizedBox(height: AppSpacing.xxs),
                Text(answer, style: AppTypography.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reviewProgress = (currentIndex + 1) / widget.reviewItems.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(_isEnglish ? 'Practice review' : 'Revisão da prática'),
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
                    ? '${widget.correctAnswers}/${widget.totalQuestions} correct in practice'
                    : '${widget.correctAnswers}/${widget.totalQuestions} acertos na prática',
                style: AppTypography.headingSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _isEnglish
                    ? 'Review every mistake before starting the final test.'
                    : 'Revise cada erro antes de iniciar o teste final.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              AppProgressBar(value: reviewProgress),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        currentItem.statement,
                        style: AppTypography.titleMedium,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _answerCard(
                      title: _isEnglish ? 'Your answer' : 'Sua resposta',
                      answer: currentItem.selectedAnswer,
                      backgroundColor: AppColors.errorLight,
                      borderColor: AppColors.error,
                      icon: Icons.close_rounded,
                      iconColor: AppColors.error,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _answerCard(
                      title: _isEnglish ? 'Correct answer' : 'Resposta correta',
                      answer: currentItem.correctAnswer,
                      backgroundColor: AppColors.successLight,
                      borderColor: AppColors.success,
                      icon: Icons.check_rounded,
                      iconColor: AppColors.success,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                      decoration: BoxDecoration(
                        color: AppColors.selectedBackground,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isEnglish ? 'Why?' : 'Por quê?',
                            style: AppTypography.titleMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            currentItem.explanation,
                            style: AppTypography.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                text: isLastItem
                    ? (_isEnglish ? 'Start final test' : 'Iniciar teste final')
                    : (_isEnglish ? 'Next mistake' : 'Próximo erro'),
                icon: isLastItem
                    ? Icons.quiz_outlined
                    : Icons.arrow_forward_rounded,
                onPressed: _continue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
