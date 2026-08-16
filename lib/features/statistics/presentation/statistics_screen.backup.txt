import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';
import 'package:calcquest/shared/widgets/app_progress_bar.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../profile/presentation/profile_screen.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
      );
      return;
    }

    if (index == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LearningPathScreen(),
        ),
      );
      return;
    }

    if (index == 2) {
      return;
    }

    if (index == 3) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
      );
    }
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
      padding: const EdgeInsets.all(
        AppSpacing.cardPadding,
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
              borderRadius: BorderRadius.circular(
                AppSpacing.radiusMedium,
              ),
            ),
            child: AppIcon(
              icon: icon,
              size: AppIconSize.medium,
              color: iconColor,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.headingSmall,
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            style: AppTypography.bodySmall,
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
                'Estatísticas',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Seu progresso',
                style: AppTypography.headingMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Acompanhe sua evolução nos estudos.',
                style: AppTypography.bodyMedium,
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
                    AppSpacing.radiusXLarge,
                  ),
                  border: Border.all(
                    color: AppColors.border,
                  ),
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
                          'XP total',
                          style: AppTypography.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      '120 XP',
                      style: AppTypography.headingLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Continue acumulando XP para subir de nível.',
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
                      icon: Icons.local_fire_department_outlined,
                      value: '3 dias',
                      label: 'Sequência',
                      iconColor: AppColors.warning,
                      iconBackground: AppColors.warningLight,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _buildSmallStatCard(
                      icon: Icons.flag_outlined,
                      value: '40%',
                      label: 'Meta diária',
                      iconColor: AppColors.primary,
                      iconBackground: AppColors.selectedBackground,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                'Desempenho',
                style: AppTypography.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),

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
                        Text(
                          'Acertos nos exercícios',
                          style: AppTypography.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      '80%',
                      style: AppTypography.headingLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const AppProgressBar(
                      value: 0.8,
                      state: AppProgressBarState.success,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Você acertou 4 de 5 questões.',
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
  }
}