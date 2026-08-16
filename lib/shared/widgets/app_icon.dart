import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';

enum AppIconSize { small, medium, large, extraLarge }

class AppIcon extends StatelessWidget {
  final IconData icon;
  final AppIconSize size;
  final Color? color;
  final String? semanticLabel;

  const AppIcon({
    super.key,
    required this.icon,
    this.size = AppIconSize.medium,
    this.color,
    this.semanticLabel,
  });

  double get _size {
    switch (size) {
      case AppIconSize.small:
        return AppSpacing.iconSmall;

      case AppIconSize.medium:
        return AppSpacing.iconMedium;

      case AppIconSize.large:
        return AppSpacing.iconLarge;

      case AppIconSize.extraLarge:
        return AppSpacing.iconXLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: _size,
      color: color ?? AppColors.textSecondary,
      semanticLabel: semanticLabel,
    );
  }
}
