import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:calcquest/shared/services/revenuecat_service.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/app_icon.dart';

import '../../dashboard/presentation/dashboard_screen.dart';
import '../../learning_path/presentation/learning_path_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const StatisticsScreen()),
      );
      return;
    }

    if (index == 3) {
      return;
    }
  }

  void _openSettings(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
  }

  String _displayName(User? user) {
    final name = user?.displayName?.trim();

    if (name != null && name.isNotEmpty) {
      return name;
    }

    final email = user?.email?.trim();

    if (email != null && email.isNotEmpty) {
      return email.split('@').first;
    }

    return 'Estudante';
  }

  int _levelFromXp(int xp) {
    return (xp ~/ 250) + 1;
  }

  String _levelDescription(int xp) {
    final currentLevelXp = xp % 250;
    final remainingXp = 250 - currentLevelXp;

    return 'Faltam $remainingXp XP para o próximo nível.';
  }

  ({String title, String description, bool unlocked}) _achievementData() {
    if (AppProgress.continuityCompleted) {
      return (
        title: 'Funções sem interrupções',
        description: 'Você concluiu Continuidade em Cálculo I.',
        unlocked: true,
      );
    }

    if (AppProgress.limitsCompleted) {
      return (
        title: 'Primeiros passos no Cálculo I',
        description: 'Você concluiu sua primeira sequência de Limites.',
        unlocked: true,
      );
    }

    if (AppProgress.functionsCompleted) {
      return (
        title: 'Fundamentos dominados',
        description: 'Você concluiu o módulo Fundamentos Matemáticos.',
        unlocked: true,
      );
    }

    if (AppProgress.equationsAndInequationsCompleted) {
      return (
        title: 'Equações concluídas',
        description: 'Você avançou em Equações e Inequações.',
        unlocked: true,
      );
    }

    if (AppProgress.algebraFundamentalCompleted) {
      return (
        title: 'Primeira aula concluída',
        description: 'Você iniciou sua jornada no Cálculo Trivial.',
        unlocked: true,
      );
    }

    return (
      title: 'Sua primeira conquista',
      description: 'Conclua a primeira aula para desbloquear.',
      unlocked: false,
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String value,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: AppIcon(
              icon: icon,
              size: AppIconSize.large,
              color: iconColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelMedium.copyWith(color: iconColor),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(value, style: AppTypography.headingSmall),
                const SizedBox(height: AppSpacing.xs),
                Text(description, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard() {
    final achievement = _achievementData();

    final iconColor = achievement.unlocked
        ? AppColors.achievement
        : AppColors.textMuted;

    final iconBackground = achievement.unlocked
        ? AppColors.achievementLight
        : AppColors.surfaceSecondary;

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
              color: iconBackground,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            ),
            child: AppIcon(
              icon: achievement.unlocked
                  ? Icons.emoji_events_outlined
                  : Icons.lock_outline_rounded,
              size: AppIconSize.large,
              color: iconColor,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(achievement.title, style: AppTypography.titleMedium),
                const SizedBox(height: AppSpacing.xs),
                Text(achievement.description, style: AppTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumCard(BuildContext context, bool isPremium) {
    final statusColor = isPremium ? AppColors.success : const Color(0xFFFFB300);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: () {
          _openSettings(context);
        },
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(color: statusColor.withValues(alpha: 0.45)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: AppIcon(
                  icon: isPremium
                      ? Icons.workspace_premium_rounded
                      : Icons.lock_outline_rounded,
                  size: AppIconSize.large,
                  color: statusColor,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isPremium ? 'Premium ativo' : 'Plano gratuito',
                      style: AppTypography.titleMedium.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      isPremium
                          ? 'Gerencie sua assinatura e suas compras.'
                          : 'Conheça os recursos do Cálculo Trivial Premium.',
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

  Widget _buildSettingsCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: () {
          _openSettings(context);
        },
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                ),
                child: const AppIcon(
                  icon: Icons.settings_outlined,
                  size: AppIconSize.large,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text('Configurações', style: AppTypography.titleMedium),
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: AppProgress.revision,
      builder: (context, revision, child) {
        final user = FirebaseAuth.instance.currentUser;
        final name = _displayName(user);
        final email = user?.email ?? 'E-mail não informado';
        final xp = AppProgress.totalXp;
        final gold = AppProgress.totalGold;
        final level = _levelFromXp(xp);

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
                    'Perfil',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(name, style: AppTypography.headingMedium),
                  const SizedBox(height: AppSpacing.xs),
                  Text(email, style: AppTypography.bodyMedium),
                  const SizedBox(height: AppSpacing.lg),
                  _buildInfoCard(
                    icon: Icons.military_tech_outlined,
                    iconColor: AppColors.primary,
                    iconBackground: AppColors.selectedBackground,
                    title: 'Nível $level',
                    value: '$xp XP • $gold de ouro',
                    description: _levelDescription(xp),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Conquistas', style: AppTypography.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  _buildAchievementCard(),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Premium', style: AppTypography.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  ValueListenableBuilder<bool>(
                    valueListenable: RevenueCatService.premiumAccess,
                    builder: (context, isPremium, child) {
                      return _buildPremiumCard(context, isPremium);
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildSettingsCard(context),
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
      },
    );
  }
}
