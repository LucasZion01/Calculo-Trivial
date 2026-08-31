import 'package:flutter/material.dart';

import 'package:calcquest/l10n/app_localizations.dart';
import 'package:calcquest/shared/services/premium_access_guard.dart';
import 'package:calcquest/shared/services/revenuecat_service.dart';
import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  Future<void> _handleTap(BuildContext context, int index) async {
    if (index == currentIndex) {
      return;
    }

    if (index == 2) {
      final hasAccess = await PremiumAccessGuard.ensureAccess(context);

      if (!context.mounted || !hasAccess) {
        return;
      }
    }

    onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navigationBackground,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.navigationBackground,
          selectedItemColor: AppColors.navigationActive,
          unselectedItemColor: AppColors.navigationInactive,
          selectedFontSize: AppTypography.labelSmall.fontSize!,
          unselectedFontSize: AppTypography.labelSmall.fontSize!,
          selectedLabelStyle: AppTypography.labelSmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: AppTypography.labelSmall,
          elevation: 0,
          iconSize: AppSpacing.iconLarge,
          onTap: (index) {
            _handleTap(context, index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, semanticLabel: l10n.home),
              activeIcon: Icon(Icons.home_rounded, semanticLabel: l10n.home),
              label: l10n.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined, semanticLabel: l10n.learningPath),
              activeIcon: Icon(
                Icons.map_rounded,
                semanticLabel: l10n.learningPath,
              ),
              label: l10n.learningPath,
            ),
            BottomNavigationBarItem(
              icon: _PremiumStatisticsIcon(
                isActive: false,
                semanticLabel: l10n.statistics,
              ),
              activeIcon: _PremiumStatisticsIcon(
                isActive: true,
                semanticLabel: l10n.statistics,
              ),
              label: l10n.statistics,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_rounded,
                semanticLabel: l10n.profile,
              ),
              activeIcon: Icon(
                Icons.person_rounded,
                semanticLabel: l10n.profile,
              ),
              label: l10n.profile,
            ),
          ],
        ),
      ),
    );
  }
}

class _PremiumStatisticsIcon extends StatelessWidget {
  final bool isActive;
  final String semanticLabel;

  const _PremiumStatisticsIcon({
    required this.isActive,
    required this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: RevenueCatService.premiumAccess,
      builder: (context, isPremiumUser, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              isActive ? Icons.bar_chart_rounded : Icons.bar_chart_outlined,
              semanticLabel: semanticLabel,
            ),
            if (!isPremiumUser)
              Positioned(
                top: -5,
                right: -8,
                child: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFB300),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
