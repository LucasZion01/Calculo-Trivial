import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/services/premium_access_guard.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  static const int _availableLessonCount = 6;

  bool _checkingPremiumAccess = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verifyPremiumAccess();
    });
  }

  Future<void> _verifyPremiumAccess() async {
    final hasAccess = await PremiumAccessGuard.ensureAccess(context);

    if (!mounted) {
      return;
    }

    if (!hasAccess) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
      return;
    }

    setState(() {
      _checkingPremiumAccess = false;
    });
  }

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LearningPathScreen()),
      );
      return;
    }

    if (index == 2) {
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  int _levelFromXp(int xp) {
    return (xp ~/ 250) + 1;
  }

  int _completedLessons() {
    return AppProgress.completedLessonIds.length
        .clamp(0, _availableLessonCount)
        .toInt();
  }

  double _progressValue() {
    return (_completedLessons() / _availableLessonCount)
        .clamp(0.0, 1.0)
        .toDouble();
  }

  String _progressDescription(
    int completedLessons,
    AppLocalizations l10n,
  ) {
    if (completedLessons == 0) {
      return l10n.statisticsProgressFirstLesson;
    }

    if (completedLessons >= _availableLessonCount) {
      return l10n.statisticsProgressAllCompleted;
    }

    final remaining = _availableLessonCount - completedLessons;
    final lessonWord = remaining == 1
        ? l10n.statisticsRemainingLesson
        : l10n.statisticsRemainingLessons;

    return l10n.statisticsProgressRemaining(remaining, lessonWord);
  }

  Widget _buildSmallStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color iconColor,
    required Color iconBackground,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: AppIcon(
              icon: icon,
              size: AppIconSize.medium,
              color: iconColor,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTypography.headingSmall),
          const SizedBox(height: AppSpacing.xxs),
          Text(label, style: AppTypography.bodySmall),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen(AppLocalizations l10n) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.statisticsCheckingPremium,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_checkingPremiumAccess) {
      return _buildLoadingScreen(l10n);
    }

    return ValueListenableBuilder<int>(
      valueListenable: AppProgress.revision,
      builder: (context, revision, child) {
        final xp = AppProgress.totalXp;
        final gold = AppProgress.totalGold;
        final level = _levelFromXp(xp);
        final completedLessons = _completedLessons();
        final progress = _progressValue();
        final progressPercentage = (progress * 100).round();
        final correctAnswers = AppProgress.correctAnswerAttempts;
        final incorrectAnswers = AppProgress.incorrectAnswerAttempts;
        final accuracyPercentage = (AppProgress.accuracy * 100).round();
        final studyStreak = AppProgress.studyStreak;
        final dailyAnswers = AppProgress.dailyAnsweredQuestions;
        final dailyGoal = AppProgress.dailyQuestionGoal;
        final dailyGoalProgress = AppProgress.dailyGoalProgress;
        final dailyGoalCompleted = dailyAnswers >= dailyGoal;
        final streakLabel = studyStreak == 1
            ? l10n.statisticsStreakDay
            : l10n.statisticsStreakDays;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
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
                    l10n.statistics,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.statisticsYourProgress,
                    style: AppTypography.headingMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.statisticsSubtitle,
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusXLarge,
                      ),
                      border: Border.all(color: AppColors.border),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 14,
                          offset: Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.xpLight,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMedium,
                                ),
                              ),
                              child: const AppIcon(
                                icon: Icons.bolt_outlined,
                                size: AppIconSize.large,
                                color: AppColors.xp,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              l10n.statisticsTotalXp,
                              style: AppTypography.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text('$xp XP', style: AppTypography.headingLarge),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.statisticsLevelStudyMessage(level),
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSmallStatCard(
                          icon: Icons.menu_book_outlined,
                          value: '$completedLessons/$_availableLessonCount',
                          label: l10n.statisticsCompletedLessons,
                          iconColor: AppColors.success,
                          iconBackground: AppColors.successLight,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _buildSmallStatCard(
                          icon: Icons.monetization_on_outlined,
                          value: '$gold',
                          label: l10n.statisticsAccumulatedGold,
                          iconColor: AppColors.gold,
                          iconBackground: AppColors.goldLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.statisticsTodayActivity,
                    style: AppTypography.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusLarge,
                      ),
                      border: Border.all(color: AppColors.border),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: dailyGoalCompleted
                                    ? AppColors.successLight
                                    : AppColors.selectedBackground,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMedium,
                                ),
                              ),
                              child: AppIcon(
                                icon: dailyGoalCompleted
                                    ? Icons.task_alt_rounded
                                    : Icons.flag_outlined,
                                size: AppIconSize.large,
                                color: dailyGoalCompleted
                                    ? AppColors.success
                                    : AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.statisticsDailyGoal,
                                style: AppTypography.titleMedium,
                              ),
                            ),
                            Text(
                              '$dailyAnswers/$dailyGoal',
                              style: AppTypography.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppProgressBar(
                          value: dailyGoalProgress,
                          state: dailyGoalCompleted
                              ? AppProgressBarState.success
                              : AppProgressBarState.normal,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          dailyGoalCompleted
                              ? l10n.statisticsDailyGoalCompleted(dailyAnswers)
                              : l10n.statisticsDailyGoalRemaining(
                                  dailyGoal - dailyAnswers,
                                ),
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildSmallStatCard(
                    icon: Icons.local_fire_department_outlined,
                    value: '$studyStreak',
                    label: streakLabel,
                    iconColor: AppColors.warning,
                    iconBackground: AppColors.warningLight,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.statisticsPerformance,
                    style: AppTypography.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSmallStatCard(
                          icon: Icons.check_circle_outline_rounded,
                          value: '$correctAnswers',
                          label: l10n.statisticsCorrectAnswers,
                          iconColor: AppColors.success,
                          iconBackground: AppColors.successLight,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _buildSmallStatCard(
                          icon: Icons.cancel_outlined,
                          value: '$incorrectAnswers',
                          label: l10n.statisticsIncorrectAnswers,
                          iconColor: AppColors.error,
                          iconBackground: AppColors.errorLight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusLarge,
                      ),
                      border: Border.all(color: AppColors.border),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.selectedBackground,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMedium,
                                ),
                              ),
                              child: const AppIcon(
                                icon: Icons.analytics_outlined,
                                size: AppIconSize.large,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.statisticsOverallAccuracy,
                                style: AppTypography.titleMedium,
                              ),
                            ),
                            Text(
                              '$accuracyPercentage%',
                              style: AppTypography.headingSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppProgressBar(value: AppProgress.accuracy),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          correctAnswers + incorrectAnswers == 0
                              ? l10n.statisticsAccuracyNoAnswers
                              : l10n.statisticsAccuracyCalculated,
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.statisticsContent,
                    style: AppTypography.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusLarge,
                      ),
                      border: Border.all(color: AppColors.border),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.successLight,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMedium,
                                ),
                              ),
                              child: const AppIcon(
                                icon: Icons.check_circle_outline_rounded,
                                size: AppIconSize.large,
                                color: AppColors.success,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                l10n.statisticsContentCompleted,
                                style: AppTypography.titleMedium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          '$progressPercentage%',
                          style: AppTypography.headingLarge,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        AppProgressBar(
                          value: progress,
                          state: progress >= 1
                              ? AppProgressBarState.success
                              : AppProgressBarState.normal,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          _progressDescription(completedLessons, l10n),
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: 2,
            onTap: (index) {
              _onMenuTap(context, index);
            },
          ),
        );
      },
    );
  }
}
