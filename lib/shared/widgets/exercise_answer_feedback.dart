import 'package:flutter/material.dart';

import 'package:calcquest/shared/data/mock_exercise_data.dart';
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
