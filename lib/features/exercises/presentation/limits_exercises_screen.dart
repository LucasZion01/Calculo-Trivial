import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/mock_exercise_data.dart';
import 'package:calcquest/shared/data/mock_limits_exercise_data.dart';
import 'package:calcquest/shared/domain/exercise_review_item.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../result/presentation/result_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class LimitsExercisesScreen extends StatefulWidget {
  const LimitsExercisesScreen({super.key});

  @override
  State<LimitsExercisesScreen> createState() => _LimitsExercisesScreenState();
}

class _LimitsExercisesScreenState extends State<LimitsExercisesScreen> {
  late final List<ExerciseData> sessionExercises;
  final List<ExerciseReviewItem> reviewItems = <ExerciseReviewItem>[];

  int currentExerciseIndex = 0;
  int correctAnswers = 0;
  String? selectedOptionId;
  bool isShowingFeedback = false;

  @override
  void initState() {
    super.initState();

    sessionExercises = _createSession(
      lessonId: AppProgress.limitsId,
      questionBank: mockLimitsExercises,
    );
  }

  List<ExerciseData> _createSession({
    required String lessonId,
    required List<ExerciseData> questionBank,
  }) {
    final selectedIds = AppProgress.selectExerciseQuestionIds(
      lessonId: lessonId,
      availableQuestionIds: questionBank.map((exercise) => exercise.id),
    );

    final exercisesById = <String, ExerciseData>{
      for (final exercise in questionBank) exercise.id: exercise,
    };

    return selectedIds
        .map((questionId) => exercisesById[questionId])
        .whereType<ExerciseData>()
        .toList();
  }

  ExerciseData get currentExercise => sessionExercises[currentExerciseIndex];

  bool get isLastExercise =>
      currentExerciseIndex == sessionExercises.length - 1;

  double get progress => (currentExerciseIndex + 1) / sessionExercises.length;

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LearningPathScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 2) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const StatisticsScreen()),
        (route) => false,
      );
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
        (route) => false,
      );
    }
  }

  void _showFeedback({
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          margin: const EdgeInsets.all(AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
          ),
          content: Row(
            children: [
              Icon(icon, color: AppColors.white),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  String _difficultyLabel(ExerciseDifficulty difficulty) {
    return switch (difficulty) {
      ExerciseDifficulty.foundation => 'Fundamentos',
      ExerciseDifficulty.intermediate => 'Intermediária',
      ExerciseDifficulty.challenge => 'Desafio',
    };
  }

  Future<void> _showAnswerFeedback({
    required ExerciseData exercise,
    required bool isCorrect,
    required String selectedAnswer,
    required String correctAnswer,
  }) {
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
      builder: (sheetContext) {
        final color = isCorrect ? AppColors.success : AppColors.error;
        final background = isCorrect
            ? AppColors.successLight
            : AppColors.errorLight;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.lg,
              AppSpacing.screenHorizontal,
              MediaQuery.viewInsetsOf(sheetContext).bottom + AppSpacing.lg,
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
                      isCorrect ? Icons.check_rounded : Icons.close_rounded,
                      color: color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    isCorrect ? 'Boa análise!' : 'Vamos entender o erro',
                    style: AppTypography.headingSmall,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Sua resposta: $selectedAnswer',
                    style: AppTypography.bodyMedium.copyWith(
                      color: isCorrect ? AppColors.successDark : AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (!isCorrect) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Resposta correta: $correctAnswer',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.successDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.cardPadding),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusMedium,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explicação passo a passo',
                          style: AppTypography.labelMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          exercise.explanation,
                          style: AppTypography.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    text: isLastExercise
                        ? 'Ver meu resultado'
                        : 'Continuar praticando',
                    icon: isLastExercise
                        ? Icons.analytics_outlined
                        : Icons.arrow_forward_rounded,
                    onPressed: () => Navigator.of(sheetContext).pop(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmAnswer() async {
    if (isShowingFeedback) return;

    if (selectedOptionId == null) {
      _showFeedback(
        message: 'Escolha uma alternativa antes de continuar.',
        backgroundColor: AppColors.warning,
        icon: Icons.warning_amber_rounded,
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

    await _showAnswerFeedback(
      exercise: exercise,
      isCorrect: isCorrect,
      selectedAnswer: selectedOption.text,
      correctAnswer: correctOption.text,
    );

    if (!mounted) return;

    if (isLastExercise) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            completedLessonId: 'limites',
            totalQuestions: sessionExercises.length,
            correctAnswers: correctAnswers,
            xpEarned: 90,
            goldEarned: 40,
            reviewItems: List<ExerciseReviewItem>.unmodifiable(reviewItems),
          ),
        ),
      );

      return;
    }

    setState(() {
      currentExerciseIndex++;
      selectedOptionId = null;
      isShowingFeedback = false;
    });
  }

  String _letterForIndex(int index) {
    const letters = ['A', 'B', 'C', 'D'];
    return letters[index];
  }

  Widget _buildOption({
    required ExerciseOptionData option,
    required int index,
  }) {
    final isSelected = selectedOptionId == option.id;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedOptionId = option.id;
          });
        },
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
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
                  _letterForIndex(index),
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  option.text,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: AppSpacing.iconLarge,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = currentExercise;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.screenTop,
            AppSpacing.screenHorizontal,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Questão ${currentExerciseIndex + 1} de ${sessionExercises.length}',
                style: AppTypography.headingSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Resolva o limite usando a estratégia adequada.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
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
                    label: Text(_difficultyLabel(exercise.difficulty)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              AppProgressBar(value: progress),
              const SizedBox(height: AppSpacing.lg),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
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
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  itemCount: exercise.options.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final option = exercise.options[index];

                    return _buildOption(option: option, index: index);
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              PrimaryButton(
                text: isLastExercise
                    ? 'Finalizar exercícios'
                    : 'Próxima questão',
                icon: isLastExercise
                    ? Icons.flag_rounded
                    : Icons.arrow_forward_rounded,
                onPressed: isShowingFeedback ? null : _confirmAnswer,
                isLoading: isShowingFeedback,
              ),
              const SizedBox(height: AppSpacing.screenBottom),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          _onMenuTap(context, index);
        },
      ),
    );
  }
}
