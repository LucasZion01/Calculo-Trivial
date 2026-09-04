import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class DashboardScreen extends StatelessWidget {
  final bool isFirstAccess;

  const DashboardScreen({
    super.key,
    this.isFirstAccess = false,
  });

  static const int _availableLessonCount = 6;

  void _openLearningPath(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LearningPathScreen()),
    );
  }

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      return;
    }

    if (index == 1) {
      _openLearningPath(context);
      return;
    }

    if (index == 2) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const StatisticsScreen()),
      );
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  String _firstName(AppLocalizations l10n) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName?.trim();

    if (displayName != null && displayName.isNotEmpty) {
      return displayName.split(RegExp(r'\s+')).first;
    }

    final email = user?.email?.trim();

    if (email != null && email.isNotEmpty) {
      return email.split('@').first;
    }

    return l10n.student;
  }

  String _welcomeTitle(AppLocalizations l10n) {
    if (isFirstAccess) {
      return l10n.dashboardFirstWelcome;
    }

    return l10n.dashboardWelcomeBack(_firstName(l10n));
  }

  String _welcomeSubtitle(AppLocalizations l10n) {
    if (isFirstAccess) {
      return l10n.dashboardFirstWelcomeSubtitle;
    }

    return l10n.dashboardWelcomeBackSubtitle;
  }

  int _levelFromXp(int xp) {
    return (xp ~/ 250) + 1;
  }

  double _progressValue() {
    final completedLessons = AppProgress.completedLessonIds.length;
    final value = completedLessons / _availableLessonCount;
    return value.clamp(0.0, 1.0).toDouble();
  }

  String _progressText(double progress) {
    return '${(progress * 100).round()}%';
  }

  String _lastLesson(AppLocalizations l10n) {
    if (AppProgress.derivativesCompleted) {
      return l10n.dashboardCalculusOneCompleted;
    }

    if (AppProgress.continuityCompleted) {
      return l10n.dashboardContinuityCompleted;
    }

    if (AppProgress.limitsCompleted) {
      return l10n.dashboardLimitsCompleted;
    }

    if (AppProgress.functionsCompleted) {
      return l10n.dashboardFoundationsCompleted;
    }

    if (AppProgress.equationsAndInequationsCompleted) {
      return l10n.dashboardEquationsCompleted;
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return l10n.dashboardAlgebraCompleted;
    }

    return l10n.dashboardStartFirstLesson;
  }

  String _nextMission(AppLocalizations l10n) {
    if (AppProgress.derivativesCompleted) {
      return l10n.dashboardMissionModuleCompleted;
    }

    if (AppProgress.continuityCompleted) {
      return l10n.dashboardMissionDerivatives;
    }

    if (AppProgress.limitsCompleted) {
      return l10n.dashboardMissionContinuity;
    }

    if (AppProgress.functionsCompleted) {
      return l10n.dashboardMissionLimits;
    }

    if (AppProgress.equationsAndInequationsCompleted) {
      return l10n.dashboardMissionFunctions;
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return l10n.dashboardMissionEquations;
    }

    return l10n.dashboardMissionFoundations;
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.cardPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            AppIcon(
              icon: icon,
              size: AppIconSize.large,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(value, style: AppTypography.titleLarge),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required AppLocalizations l10n,
    required double progress,
    required bool progressCompleted,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dashboardCurrentProgress,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Text(
                  _progressText(progress),
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppProgressBar(
            value: progress,
            state: progressCompleted
                ? AppProgressBarState.success
                : AppProgressBarState.normal,
            height: 8,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _lastLesson(l10n),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primaryLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextMissionCard(
    BuildContext context,
    AppLocalizations l10n,
  ) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.selectedBackground,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: Text(
                  'f(x)',
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.dashboardNextMission,
                      style: AppTypography.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      _nextMission(l10n),
                      style: AppTypography.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            text: l10n.dashboardContinuePath,
            icon: Icons.arrow_forward_rounded,
            onPressed: () => _openLearningPath(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ValueListenableBuilder<int>(
      valueListenable: AppProgress.revision,
      builder: (context, revision, child) {
        final xp = AppProgress.totalXp;
        final gold = AppProgress.totalGold;
        final level = _levelFromXp(xp);
        final progress = _progressValue();
        final progressCompleted = progress >= 1;

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
                    _welcomeTitle(l10n),
                    style: AppTypography.headingMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _welcomeSubtitle(l10n),
                    style: AppTypography.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildProgressCard(
                    l10n: l10n,
                    progress: progress,
                    progressCompleted: progressCompleted,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.military_tech_outlined,
                        title: l10n.level,
                        value: '$level',
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _buildInfoCard(
                        icon: Icons.bolt_outlined,
                        title: l10n.xp,
                        value: '$xp',
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _buildInfoCard(
                        icon: Icons.monetization_on_outlined,
                        title: l10n.gold,
                        value: '$gold',
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildNextMissionCard(context, l10n),
                ],
              ),
            ),
          ),
          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: 0,
            onTap: (index) {
              _onMenuTap(context, index);
            },
          ),
        );
      },
    );
  }
}
