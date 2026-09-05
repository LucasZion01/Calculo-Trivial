import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/domain/exercise_review_item.dart';
import 'package:calcquest/shared/domain/exercise_session_result.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/learning_difficulty_recommendation_card.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../diagnostic/presentation/factoring_diagnostic_screen.dart';
import '../../exercise_review/presentation/exercise_review_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../reward/presentation/reward_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';
import 'learning_recommendation_destination.dart';

class ResultScreen extends StatelessWidget {
  final String completedLessonId;
  final int totalQuestions;
  final int correctAnswers;
  final int xpEarned;
  final int goldEarned;
  final List<ExerciseReviewItem> reviewItems;
  final bool enableLearningRecommendation;

  const ResultScreen({
    super.key,
    this.completedLessonId = 'algebra-fundamental',
    this.totalQuestions = 5,
    this.correctAnswers = 5,
    this.xpEarned = 60,
    this.goldEarned = 25,
    this.reviewItems = const <ExerciseReviewItem>[],
    this.enableLearningRecommendation = false,
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

  void _reviewLearningRecommendation(BuildContext context) {
    final destination = learningRecommendationDestinationFor(completedLessonId);
    if (destination == null) {
      _backToLearningPath(context);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  Widget _buildResultCard({
    required IconData icon,
    required String title,
    required String value,
    required int index,
    Color? iconColor,
    Color? iconBackground,
  }) {
    final resolvedIconColor = iconColor ?? AppColors.primary;
    final resolvedIconBackground =
        iconBackground ?? AppColors.selectedBackground;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 420 + (index * 90)),
      curve: Curves.easeOutCubic,
      builder: (context, animationValue, child) {
        return Opacity(
          opacity: animationValue,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - animationValue)),
            child: child,
          ),
        );
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildHero({
    required AppLocalizations l10n,
    required bool isApproved,
    required Color statusColor,
    required Color statusBackground,
    required int accuracyPercentage,
    required String performanceText,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.scale(
            scale: 0.86 + (0.14 * value),
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: statusBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
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
          const SizedBox(height: AppSpacing.lg),
          Text(
            isApproved ? l10n.resultGoalReached : l10n.resultKeepPracticing,
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
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: statusBackground,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: accuracyPercentage.toDouble()),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Text(
                      '${value.round()}%',
                      style: AppTypography.titleMedium.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w800,
                      ),
                    );
                  },
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  performanceText,
                  style: AppTypography.labelMedium.copyWith(
                    color: statusColor,
                  ),
                ),
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
    final isEnglish =
        Localizations.localeOf(context).languageCode.toLowerCase() == 'en';
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
    final statusBackground =
        isApproved ? AppColors.successLight : AppColors.errorLight;

    int cardIndex = 0;

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
                    _buildHero(
                      l10n: l10n,
                      isApproved: isApproved,
                      statusColor: statusColor,
                      statusBackground: statusBackground,
                      accuracyPercentage: accuracyPercentage,
                      performanceText: performanceText,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _buildResultCard(
                      icon: Icons.check_circle_outline_rounded,
                      title: l10n.resultCorrectAnswers,
                      value: '$correctAnswers',
                      index: cardIndex++,
                      iconColor: AppColors.success,
                      iconBackground: AppColors.successLight,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildResultCard(
                      icon: Icons.cancel_outlined,
                      title: l10n.resultIncorrectAnswers,
                      value: '$incorrectAnswers',
                      index: cardIndex++,
                      iconColor: AppColors.error,
                      iconBackground: AppColors.errorLight,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildResultCard(
                      icon: Icons.analytics_outlined,
                      title: l10n.resultAccuracy,
                      value: '$accuracyPercentage%',
                      index: cardIndex++,
                    ),
                    if (enableLearningRecommendation) ...[
                      const SizedBox(height: AppSpacing.sm),
                      LearningDifficultyRecommendationSection(
                        moduleId: completedLessonId,
                        isEnglish: isEnglish,
                        onReview: () => _reviewLearningRecommendation(context),
                        onInvestigate: (evidence) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FactoringDiagnosticScreen(
                                sourceSkill: evidence.skill,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    if (isApproved) ...[
                      const SizedBox(height: AppSpacing.sm),
                      _buildResultCard(
                        icon: Icons.bolt_outlined,
                        title: l10n.resultXpEarned,
                        value: '+${result.earnedXp} XP',
                        index: cardIndex++,
                        iconColor: AppColors.xp,
                        iconBackground: AppColors.xpLight,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildResultCard(
                        icon: Icons.monetization_on_outlined,
                        title: l10n.resultGoldEarned,
                        value: '+${result.earnedGold}',
                        index: cardIndex++,
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
        onTap: (index) => _onMenuTap(context, index),
      ),
    );
  }
}
