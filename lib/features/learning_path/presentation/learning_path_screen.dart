import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/data/mock_learning_data.dart';
import 'package:calcquest/shared/services/premium_access_guard.dart';
import 'package:calcquest/shared/services/revenuecat_service.dart';
import 'package:calcquest/shared/state/app_progress.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';
import 'package:calcquest/shared/widgets/app_bottom_navigation_bar.dart';
import 'package:calcquest/shared/widgets/math_card.dart';

import '../../calculus_one/presentation/calculus_one_detail_screen.dart';
import '../../dashboard/presentation/dashboard_screen.dart';
import '../../module_detail/presentation/module_detail_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../statistics/presentation/statistics_screen.dart';

class LearningPathScreen extends StatelessWidget {
  const LearningPathScreen({super.key});

  void _onMenuTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
      return;
    }

    if (index == 1) {
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

  void _goToModuleDetail(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const ModuleDetailScreen()));
  }

  void _goToCalculusOne(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const CalculusOneDetailScreen()));
  }

  bool _isPremiumModule(ModuleData module) {
    return module.id != 'fundamentos';
  }

  int _completedFundamentalsLessons() {
    int completed = 0;

    if (AppProgress.algebraFundamentalCompleted) {
      completed++;
    }

    if (AppProgress.equationsAndInequationsCompleted) {
      completed++;
    }

    if (AppProgress.functionsCompleted) {
      completed++;
    }

    return completed;
  }

  String _getModuleStatus({
    required ModuleData module,
    required bool isPremiumUser,
    required AppLocalizations l10n,
  }) {
    if (module.id == 'fundamentos') {
      final completed = _completedFundamentalsLessons();

      if (completed == 0) {
        return '0%';
      }

      if (completed == 1) {
        return '33%';
      }

      if (completed == 2) {
        return '66%';
      }

      return '100%';
    }

    if (module.id == 'calculo-1') {
      if (AppProgress.derivativesCompleted) {
        return '100%';
      }

      if (AppProgress.continuityCompleted) {
        return '66%';
      }

      if (AppProgress.limitsCompleted) {
        return '33%';
      }

      if (!AppProgress.functionsCompleted) {
        return l10n.locked;
      }

      if (isPremiumUser) {
        return l10n.unlocked;
      }

      return l10n.premium;
    }

    return l10n.locked;
  }

  Color _getModuleStatusColor({
    required ModuleData module,
    required bool isPremiumUser,
  }) {
    if (module.id == 'fundamentos') {
      if (_completedFundamentalsLessons() == 3) {
        return AppColors.success;
      }

      return AppColors.primary;
    }

    if (module.id == 'calculo-1' && AppProgress.functionsCompleted) {
      if (AppProgress.derivativesCompleted) {
        return AppColors.success;
      }

      if (isPremiumUser) {
        return AppColors.primary;
      }

      return const Color(0xFFFFB300);
    }

    return AppColors.locked;
  }

  MathCardState _getModuleCardState(ModuleData module) {
    if (module.id == 'fundamentos') {
      if (_completedFundamentalsLessons() == 3) {
        return MathCardState.completed;
      }

      return MathCardState.normal;
    }

    if (module.id == 'calculo-1') {
      if (AppProgress.derivativesCompleted) {
        return MathCardState.completed;
      }

      if (AppProgress.functionsCompleted) {
        return MathCardState.normal;
      }

      return MathCardState.locked;
    }

    return MathCardState.locked;
  }

  VoidCallback? _getModuleTap(BuildContext context, ModuleData module) {
    if (module.id == 'fundamentos') {
      return () {
        _goToModuleDetail(context);
      };
    }

    if (module.id == 'calculo-1' && AppProgress.functionsCompleted) {
      return () async {
        final hasAccess = await PremiumAccessGuard.ensureAccess(context);

        if (!context.mounted || !hasAccess) {
          return;
        }

        _goToCalculusOne(context);
      };
    }

    return null;
  }

  String _moduleTitle(ModuleData module, AppLocalizations l10n) {
    switch (module.id) {
      case 'fundamentos':
        return l10n.mathematicalFoundations;
      case 'calculo-1':
        return l10n.calculusOne;
      case 'calculo-2':
        return l10n.calculusTwo;
      default:
        return module.title;
    }
  }

  String _moduleSubtitle(ModuleData module, AppLocalizations l10n) {
    switch (module.id) {
      case 'fundamentos':
        return l10n.mathematicalFoundationsSubtitle;
      case 'calculo-1':
        return l10n.calculusOneSubtitle;
      case 'calculo-2':
        return l10n.calculusTwoSubtitle;
      default:
        return module.subtitle;
    }
  }

  Widget _buildPremiumBadge({
    required bool isPremiumUser,
    required AppLocalizations l10n,
  }) {
    final badgeColor = isPremiumUser
        ? AppColors.success
        : const Color(0xFFFFB300);

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: badgeColor.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: badgeColor.withValues(alpha: 0.55)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPremiumUser
                  ? Icons.workspace_premium_rounded
                  : Icons.lock_rounded,
              size: 16,
              color: badgeColor,
            ),
            const SizedBox(width: 6),
            Text(
              isPremiumUser
                  ? l10n.premiumActiveUppercase
                  : l10n.premiumUppercase,
              style: TextStyle(
                color: badgeColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard({
    required BuildContext context,
    required ModuleData module,
    required bool isPremiumUser,
    required AppLocalizations l10n,
  }) {
    final isPremiumModule = _isPremiumModule(module);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isPremiumModule) ...[
          _buildPremiumBadge(isPremiumUser: isPremiumUser, l10n: l10n),
          const SizedBox(height: AppSpacing.xs),
        ],
        MathCard(
          title: _moduleTitle(module, l10n),
          subtitle: _moduleSubtitle(module, l10n),
          symbol: module.symbol,
          status: _getModuleStatus(
            module: module,
            isPremiumUser: isPremiumUser,
            l10n: l10n,
          ),
          statusColor: _getModuleStatusColor(
            module: module,
            isPremiumUser: isPremiumUser,
          ),
          state: _getModuleCardState(module),
          onTap: _getModuleTap(context, module),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
              Text(l10n.learningPathTitle, style: AppTypography.headingMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(l10n.learningPathSubtitle, style: AppTypography.bodyMedium),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: RevenueCatService.premiumAccess,
                  builder: (context, isPremiumUser, child) {
                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      itemCount: mockModules.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: AppSpacing.md);
                      },
                      itemBuilder: (context, index) {
                        final module = mockModules[index];

                        return _buildModuleCard(
                          context: context,
                          module: module,
                          isPremiumUser: isPremiumUser,
                          l10n: l10n,
                        );
                      },
                    );
                  },
                ),
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
