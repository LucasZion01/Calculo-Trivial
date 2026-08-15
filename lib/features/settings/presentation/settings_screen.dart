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
import '../../statistics/presentation/statistics_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const StatisticsScreen(),
        ),
      );
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
                'Configurações',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Ajustes da conta',
                style: AppTypography.headingMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Gerencie preferências básicas do aplicativo.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),

              const _SettingsCard(
                icon: Icons.person_outline_rounded,
                title: 'Conta',
                subtitle: 'Editar nome, e-mail e senha',
              ),

              const SizedBox(height: AppSpacing.md),

              const _SettingsCard(
                icon: Icons.notifications_none_rounded,
                title: 'Notificações',
                subtitle: 'Lembretes de estudo e metas diárias',
              ),

              const SizedBox(height: AppSpacing.md),

              const _SettingsCard(
                icon: Icons.light_mode_outlined,
                title: 'Tema',
                subtitle: 'Modo claro ativado',
              ),

              const SizedBox(height: AppSpacing.lg),

              PrimaryButton(
                text: 'Sair da conta',
                icon: Icons.logout_rounded,
                variant: PrimaryButtonVariant.destructive,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          _onMenuTap(context, index);
        },
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(
        AppSpacing.radiusLarge,
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusLarge,
        ),
        child: Container(
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
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(
                    AppSpacing.radiusMedium,
                  ),
                ),
                child: AppIcon(
                  icon: icon,
                  size: AppIconSize.large,
                  color: AppColors.textSecondary,
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
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      subtitle,
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),
              const AppIcon(
                icon: Icons.chevron_right_rounded,
                size: AppIconSize.large,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}