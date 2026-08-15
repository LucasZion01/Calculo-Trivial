import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/primary_button.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../mini_challenge/presentation/mini_challenge_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

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

  void _goToMiniChallenge(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const MiniChallengeScreen(),
      ),
    );
  }

  Widget _buildContentCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.selectedBackground,
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMedium,
              ),
            ),
            child: AppIcon(
              icon: icon,
              size: AppIconSize.large,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  content,
                  style: AppTypography.bodyMedium,
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
                'Aula 1',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Álgebra Fundamental',
                style: AppTypography.headingMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Entenda a base algébrica necessária para avançar em Cálculo.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.md,
                  ),
                  children: [
                    _buildContentCard(
                      icon: Icons.school_outlined,
                      title: 'Motivação',
                      content:
                          'Antes de estudar limites, derivadas e integrais, você precisa dominar operações algébricas, simplificação de expressões e manipulação de equações.',
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(
                        AppSpacing.cardPaddingLarge,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusXLarge,
                        ),
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
                          Text(
                            'Exemplo rápido',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primaryLight,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            'Simplifique: 2x + 3x',
                            style: AppTypography.headingSmall.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'Resposta: 5x',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                text: 'Continuar',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  _goToMiniChallenge(context);
                },
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