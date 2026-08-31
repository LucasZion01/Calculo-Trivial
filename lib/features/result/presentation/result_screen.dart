import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/domain/exercise_review_item.dart';
import 'package:calcquest/shared/domain/exercise_session_result.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../exercise_review/presentation/exercise_review_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../reward/presentation/reward_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class ResultScreen extends StatelessWidget {
  final String completedLessonId;
  final int totalQuestions;
  final int correctAnswers;
  final int xpEarned;
  final int goldEarned;
  final List<ExerciseReviewItem> reviewItems;

  const ResultScreen({
    super.key,
    this.completedLessonId = 'algebra-fundamental',
    this.totalQuestions = 5,
    this.correctAnswers = 5,
    this.xpEarned = 60,
    this.goldEarned = 25,
    this.reviewItems = const <ExerciseReviewItem>[],
  });

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

  void _goToReward(BuildContext context, ExerciseSessionResult result) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RewardScreen(
          completedLessonId: completedLessonId,
          xpEarned: result.earnedXp,
          goldEarned: result.earnedGold,
        ),
      ),
    );
  }

  void _backToLearningPath(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LearningPathScreen()),
      (route) => false,
    );
  }

  void _goToReview(BuildContext context, ExerciseSessionResult result) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExerciseReviewScreen(
          reviewItems: reviewItems,
          completedLessonId: completedLessonId,
          result: result,
        ),
      ),
    );
  }

  Widget _buildResultCard({
    required IconData icon,
    required String title,
    required String value,
    Color? iconColor,
    Color? iconBackground,
  }) {
    final resolvedIconColor = iconColor ?? AppColors.primary;
    final resolvedIconBackground =
        iconBackground ?? AppColors.selectedBackground;

    return Container(
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: resolvedIconBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: AppIcon(
              icon: icon,
              size: AppIconSize.large,
              color: resolvedIconColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(title, style: AppTypography.bodyMedium)),
          const SizedBox(width: AppSpacing.sm),
          Text(value, style: AppTypography.titleLarge),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final result = ExerciseSessionResult(
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      configuredXp: xpEarned,
      configuredGold: goldEarned,
    );

    final incorrectAnswers = result.incorrectAnswers;
    final accuracyPercentage = result.accuracyPercentage;
    final performanceText = l10n.resultAccuracyPerformance(accuracyPercentage);
    final isApproved = result.isApproved;
    final statusColor = isApproved ? AppColors.success : AppColors.error;
    final statusBackground = isApproved
        ? AppColors.successLight
        : AppColors.errorLight;

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
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  children: [
                    const SizedBox(height: AppSpacing.sm),
                    Center(
                      child: Container(
                        width: 88,
                        height: 88,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: statusBackground,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusXLarge,
                          ),
                        ),
                        child: AppIcon(
                          icon: isApproved
                              ? Icons.check_rounded
                              : Icons.refresh_rounded,
                          size: AppIconSize.extraLarge,
                          color: statusColor,
                          semanticLabel: l10n.resultExercisesCompletedSemantic,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      isApproved
                          ? l10n.resultGoalReached
                          : l10n.resultKeepPracticing,
                      textAlign: TextAlign.center,
                      style: AppTypography.headingLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      isApproved
                          ? l10n.resultApprovedMessage
                          : l10n.resultNeedEightyPercent,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      performanceText,
                      textAlign: TextAlign.center,
                      style: AppTypography.labelMedium.copyWith(
                        color: statusColor,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _buildResultCard(
                      icon: Icons.check_circle_outline_rounded,
                      title: l10n.resultCorrectAnswers,
                      value: '$correctAnswers',
                      iconColor: AppColors.success,
                      iconBackground: AppColors.successLight,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildResultCard(
                      icon: Icons.cancel_outlined,
                      title: l10n.resultIncorrectAnswers,
                      value: '$incorrectAnswers',
                      iconColor: AppColors.error,
                      iconBackground: AppColors.errorLight,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildResultCard(
                      icon: Icons.analytics_outlined,
                      title: l10n.resultAccuracy,
                      value: '$accuracyPercentage%',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    if (isApproved) ...[
                      _buildResultCard(
                        icon: Icons.bolt_outlined,
                        title: l10n.resultXpEarned,
                        value: '+${result.earnedXp} XP',
                        iconColor: AppColors.xp,
                        iconBackground: AppColors.xpLight,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildResultCard(
                        icon: Icons.monetization_on_outlined,
                        title: l10n.resultGoldEarned,
                        value: '+${result.earnedGold}',
                        iconColor: AppColors.gold,
                        iconBackground: AppColors.goldLight,
                      ),
                    ],
                  ],
                ),
              ),
              PrimaryButton(
                text: reviewItems.isNotEmpty
                    ? reviewItems.length == 1
                        ? l10n.resultReviewOneError
                        : l10n.resultReviewErrors(reviewItems.length)
                    : isApproved
                        ? l10n.resultReceiveReward
                        : l10n.resultBackToPath,
                icon: reviewItems.isNotEmpty
                    ? Icons.fact_check_outlined
                    : isApproved
                        ? Icons.arrow_forward_rounded
                        : Icons.refresh_rounded,
                onPressed: () {
                  if (reviewItems.isNotEmpty) {
                    _goToReview(context, result);
                    return;
                  }

                  if (isApproved) {
                    _goToReward(context, result);
                    return;
                  }

                  _backToLearningPath(context);
                },
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
