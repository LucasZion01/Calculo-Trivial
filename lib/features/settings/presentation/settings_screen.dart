import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

import 'package:calcquest/shared/services/revenuecat_service.dart';
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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _processingSubscriptionAction = false;

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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    }
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _restorePurchases() async {
    if (_processingSubscriptionAction) {
      return;
    }

    if (!RevenueCatService.isConfigured) {
      _showMessage('O sistema Premium está indisponível no momento.');
      return;
    }

    setState(() {
      _processingSubscriptionAction = true;
    });

    try {
      await RevenueCatService.restorePurchases();

      if (!mounted) {
        return;
      }

      if (RevenueCatService.isPremium) {
        _showMessage('Compras restauradas. Seu acesso Premium está ativo.');
      } else {
        _showMessage('Nenhuma compra Premium foi encontrada para esta conta.');
      }
    } catch (error) {
      debugPrint('Configurações: erro ao restaurar compras: $error');

      _showMessage('Não foi possível restaurar suas compras.');
    } finally {
      if (mounted) {
        setState(() {
          _processingSubscriptionAction = false;
        });
      }
    }
  }

  Future<void> _openCustomerCenter() async {
    if (_processingSubscriptionAction) {
      return;
    }

    if (!RevenueCatService.isConfigured) {
      _showMessage('O sistema Premium está indisponível no momento.');
      return;
    }

    setState(() {
      _processingSubscriptionAction = true;
    });

    try {
      await RevenueCatUI.presentCustomerCenter();
      await RevenueCatService.refreshPremiumStatus();
    } catch (error) {
      debugPrint(
        'Configurações: erro ao abrir a central de assinatura: $error',
      );

      _showMessage('Não foi possível abrir o gerenciamento da assinatura.');
    } finally {
      if (mounted) {
        setState(() {
          _processingSubscriptionAction = false;
        });
      }
    }
  }

  Widget _buildSubscriptionStatus(bool isPremium) {
    final statusColor = isPremium ? AppColors.success : const Color(0xFFFFB300);

    final statusBackground = statusColor.withValues(alpha: 0.12);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
        border: Border.all(color: statusColor.withValues(alpha: 0.45)),
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
              color: statusBackground,
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
                      ? 'Você possui acesso aos recursos Premium.'
                      : 'Assine para liberar todos os recursos.',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            isPremium
                ? Icons.verified_rounded
                : Icons.workspace_premium_outlined,
            color: statusColor,
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
                'Configurações',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text('Ajustes da conta', style: AppTypography.headingMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Gerencie sua conta, preferências e assinatura.',
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
              Text('Assinatura', style: AppTypography.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              ValueListenableBuilder<bool>(
                valueListenable: RevenueCatService.premiumAccess,
                builder: (context, isPremium, child) {
                  return _buildSubscriptionStatus(isPremium);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              _SettingsCard(
                icon: Icons.restore_rounded,
                title: 'Restaurar compras',
                subtitle: 'Recupere uma assinatura comprada anteriormente',
                onTap: _processingSubscriptionAction ? null : _restorePurchases,
                trailing: _processingSubscriptionAction
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : null,
              ),
              const SizedBox(height: AppSpacing.md),
              _SettingsCard(
                icon: Icons.manage_accounts_outlined,
                title: 'Gerenciar assinatura',
                subtitle: 'Consulte, altere ou cancele seu plano',
                onTap: _processingSubscriptionAction
                    ? null
                    : _openCustomerCenter,
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
  final VoidCallback? onTap;
  final Widget? trailing;

  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: InkWell(
        onTap: onTap,
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
                    Text(title, style: AppTypography.titleMedium),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(subtitle, style: AppTypography.bodySmall),
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else if (onTap != null)
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
