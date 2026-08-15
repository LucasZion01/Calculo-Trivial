import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/mock_equations_exercise_data.dart';
import 'package:calcquest/shared/data/mock_exercise_data.dart';
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

class EquationsExercisesScreen extends StatefulWidget {
  const EquationsExercisesScreen({super.key});

  @override
  State<EquationsExercisesScreen> createState() =>
      _EquationsExercisesScreenState();
}

class _EquationsExercisesScreenState extends State<EquationsExercisesScreen> {
  int currentExerciseIndex = 0;
  String? selectedOptionId;

  ExerciseData get currentExercise =>
      mockEquationsExercises[currentExerciseIndex];

  bool get isLastExercise =>
      currentExerciseIndex == mockEquationsExercises.length - 1;

  double get progress =>
      (currentExerciseIndex + 1) / mockEquationsExercises.length;

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
        (route) => false,
      );
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const LearningPathScreen(),
        ),
        (route) => false,
      );
      return;
    }

    if (index == 2) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const StatisticsScreen(),
        ),
        (route) => false,
      );
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
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
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusMedium,
            ),
          ),
          content: Row(
            children: [
              Icon(
                icon,
                color: AppColors.white,
              ),
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

  void _confirmAnswer() {
    if (selectedOptionId == null) {
      _showFeedback(
        message: 'Escolha uma alternativa antes de continuar.',
        backgroundColor: AppColors.warning,
        icon: Icons.warning_amber_rounded,
      );
      return;
    }

    if (selectedOptionId != currentExercise.correctOptionId) {
      _showFeedback(
        message: 'Resposta incorreta. Tente novamente.',
        backgroundColor: AppColors.error,
        icon: Icons.close_rounded,
      );
      return;
    }

    _showFeedback(
      message: currentExercise.explanation,
      backgroundColor: AppColors.success,
      icon: Icons.check_rounded,
    );

    if (isLastExercise) {
      Future.delayed(
        const Duration(milliseconds: 700),
        () {
          if (!mounted) return;

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ResultScreen(
                completedLessonId: 'equacoes-inequacoes',
                totalQuestions: mockEquationsExercises.length,
                correctAnswers: mockEquationsExercises.length,
                xpEarned: 70,
                goldEarned: 30,
              ),
            ),
          );
        },
      );

      return;
    }

    setState(() {
      currentExerciseIndex++;
      selectedOptionId = null;
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
      borderRadius: BorderRadius.circular(
        AppSpacing.radiusLarge,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedOptionId = option.id;
          });
        },
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: double.infinity,
          padding: const EdgeInsets.all(
            AppSpacing.cardPadding,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.selectedBackground
                : AppColors.surface,
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusLarge,
            ),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.border,
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
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusMedium,
                  ),
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
                'Questão ${currentExerciseIndex + 1} de ${mockEquationsExercises.length}',
                style: AppTypography.headingSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Resolva a equação ou inequação.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              AppProgressBar(
                value: progress,
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  AppSpacing.cardPaddingLarge,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusLarge,
                  ),
                  border: Border.all(
                    color: AppColors.border,
                  ),
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
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.md,
                  ),
                  itemCount: exercise.options.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(
                    height: AppSpacing.sm,
                  ),
                  itemBuilder: (context, index) {
                    final option = exercise.options[index];

                    return _buildOption(
                      option: option,
                      index: index,
                    );
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
                onPressed: _confirmAnswer,
              ),
              const SizedBox(
                height: AppSpacing.screenBottom,
              ),
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