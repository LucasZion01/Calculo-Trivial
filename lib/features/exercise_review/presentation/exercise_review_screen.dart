import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/domain/exercise_review_item.dart';
import 'package:calcquest/shared/domain/exercise_session_result.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../learning_path/presentation/learning_path_screen.dart';
import '../../reward/presentation/reward_screen.dart';

class ExerciseReviewScreen extends StatefulWidget {
  final List<ExerciseReviewItem> reviewItems;
  final String completedLessonId;
  final ExerciseSessionResult result;

  const ExerciseReviewScreen({
    super.key,
    required this.reviewItems,
    required this.completedLessonId,
    required this.result,
  }) : assert(reviewItems.length > 0);

  @override
  State<ExerciseReviewScreen> createState() => _ExerciseReviewScreenState();
}

class _ExerciseReviewScreenState extends State<ExerciseReviewScreen> {
  int currentIndex = 0;

  ExerciseReviewItem get currentItem => widget.reviewItems[currentIndex];

  bool get isLastItem => currentIndex == widget.reviewItems.length - 1;

  void _continueReview() {
    if (isLastItem) {
      _finishReview();
      return;
    }

    setState(() {
      currentIndex++;
    });
  }

  void _finishReview() {
    if (widget.result.isApproved) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => RewardScreen(
            completedLessonId: widget.completedLessonId,
            xpEarned: widget.result.earnedXp,
            goldEarned: widget.result.earnedGold,
          ),
        ),
        (route) => false,
      );
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LearningPathScreen()),
      (route) => false,
    );
  }

  Widget _buildAnswerCard({
    required String title,
    required String answer,
    required Color backgroundColor,
    required Color borderColor,
    required Color iconColor,
    required IconData icon,
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
    final l10n = AppLocalizations.of(context)!;
    final progress = (currentIndex + 1) / widget.reviewItems.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenHorizontal,
            AppSpacing.screenTop,
            AppSpacing.screenHorizontal,
            AppSpacing.screenBottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.reviewErrorsTitle,
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.reviewUnderstandEachAnswer,
                style: AppTypography.headingMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.reviewScoreUnchanged,
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.reviewErrorProgress(
                  currentIndex + 1,
                  widget.reviewItems.length,
                ),
                style: AppTypography.labelMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              AppProgressBar(value: progress),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView(
                  children: [
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
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        currentItem.statement,
                        style: AppTypography.titleMedium,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildAnswerCard(
                      title: l10n.reviewYourAnswer,
                      answer: currentItem.selectedAnswer,
                      backgroundColor: AppColors.errorLight,
                      borderColor: AppColors.error,
                      iconColor: AppColors.error,
                      icon: Icons.close_rounded,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildAnswerCard(
                      title: l10n.reviewCorrectAnswer,
                      answer: currentItem.correctAnswer,
                      backgroundColor: AppColors.successLight,
                      borderColor: AppColors.success,
                      iconColor: AppColors.success,
                      icon: Icons.check_rounded,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(
                        AppSpacing.cardPaddingLarge,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.selectedBackground,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusLarge,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.reviewExplanation,
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
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                text: isLastItem ? l10n.reviewFinish : l10n.reviewNextError,
                icon: isLastItem
                    ? Icons.check_rounded
                    : Icons.arrow_forward_rounded,
                onPressed: _continueReview,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
