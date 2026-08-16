import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';

enum AppProgressBarState { normal, success, locked }

class AppProgressBar extends StatelessWidget {
  final double value;
  final AppProgressBarState state;
  final double height;

  const AppProgressBar({
    super.key,
    required this.value,
    this.state = AppProgressBarState.normal,
    this.height = 8,
  });

  double get _safeValue {
    return value.clamp(0.0, 1.0).toDouble();
  }

  Color get _progressColor {
    switch (state) {
      case AppProgressBarState.normal:
        return AppColors.progressValue;

      case AppProgressBarState.success:
        return AppColors.progressComplete;

      case AppProgressBarState.locked:
        return AppColors.progressLocked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
      child: LinearProgressIndicator(
        value: _safeValue,
        minHeight: height,
        backgroundColor: AppColors.progressTrack,
        valueColor: AlwaysStoppedAnimation<Color>(_progressColor),
      ),
    );
  }
}
