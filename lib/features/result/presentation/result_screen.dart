import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../reward/presentation/reward_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class ResultScreen extends StatelessWidget {
  static const double minimumPassingScore = 0.8;

  final String completedLessonId;
  final int totalQuestions;
  final int correctAnswers;
  final int xpEarned;
  final int goldEarned;

  const ResultScreen({
    super.key,
    this.completedLessonId = 'algebra-fundamental',
    this.totalQuestions = 5,
    this.correctAnswers = 5,
    this.xpEarned = 60,
    this.goldEarned = 25,
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

  void _goToReward(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RewardScreen(
          completedLessonId: completedLessonId,
          xpEarned: xpEarned,
          goldEarned: goldEarned,
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
    final incorrectAnswers = totalQuestions - correctAnswers;
    final accuracy = totalQuestions == 0
        ? 0.0
        : correctAnswers / totalQuestions;
    final accuracyPercentage = (accuracy * 100).round();
    final performanceText = '$accuracyPercentage% de precisão';
    final isApproved = accuracy >= minimumPassingScore;
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
                          semanticLabel: 'Exercícios concluídos',
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      isApproved ? 'Objetivo atingido!' : 'Continue praticando',
                      textAlign: TextAlign.center,
                      style: AppTypography.headingLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      isApproved
                          ? 'Você alcançou o rendimento necessário para avançar.'
                          : 'Você precisa de pelo menos 80% para desbloquear a próxima aula.',
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
                      title: 'Acertos',
                      value: '$correctAnswers',
                      iconColor: AppColors.success,
                      iconBackground: AppColors.successLight,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildResultCard(
                      icon: Icons.cancel_outlined,
                      title: 'Erros',
                      value: '$incorrectAnswers',
                      iconColor: AppColors.error,
                      iconBackground: AppColors.errorLight,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _buildResultCard(
                      icon: Icons.analytics_outlined,
                      title: 'Precisão',
                      value: '$accuracyPercentage%',
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    if (isApproved) ...[
                      _buildResultCard(
                        icon: Icons.bolt_outlined,
                        title: 'XP ganho',
                        value: '+$xpEarned XP',
                        iconColor: AppColors.xp,
                        iconBackground: AppColors.xpLight,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _buildResultCard(
                        icon: Icons.monetization_on_outlined,
                        title: 'Ouro ganho',
                        value: '+$goldEarned',
                        iconColor: AppColors.gold,
                        iconBackground: AppColors.goldLight,
                      ),
                    ],
                  ],
                ),
              ),
              PrimaryButton(
                text: isApproved
                    ? 'Receber recompensa'
                    : 'Revisar e tentar novamente',
                icon: isApproved
                    ? Icons.arrow_forward_rounded
                    : Icons.refresh_rounded,
                onPressed: () {
                  if (isApproved) {
                    _goToReward(context);
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
