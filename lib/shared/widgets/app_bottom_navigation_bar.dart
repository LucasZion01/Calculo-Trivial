import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, semanticLabel: 'Início'),
              activeIcon: Icon(Icons.home_rounded, semanticLabel: 'Início'),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined, semanticLabel: 'Trilha'),
              activeIcon: Icon(Icons.map_rounded, semanticLabel: 'Trilha'),
              label: 'Trilha',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bar_chart_outlined,
                semanticLabel: 'Estatísticas',
              ),
              activeIcon: Icon(
                Icons.bar_chart_rounded,
                semanticLabel: 'Estatísticas',
              ),
              label: 'Estatísticas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, semanticLabel: 'Perfil'),
              activeIcon: Icon(Icons.person_rounded, semanticLabel: 'Perfil'),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
