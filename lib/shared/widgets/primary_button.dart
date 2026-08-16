import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

enum PrimaryButtonVariant { primary, secondary, destructive }

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final PrimaryButtonVariant variant;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.variant = PrimaryButtonVariant.primary,
  });

  Color get _backgroundColor {
    switch (variant) {
      case PrimaryButtonVariant.primary:
        return AppColors.primary;

      case PrimaryButtonVariant.secondary:
        return AppColors.surface;

      case PrimaryButtonVariant.destructive:
        return AppColors.error;
    }
  }

  Color get _foregroundColor {
    switch (variant) {
      case PrimaryButtonVariant.primary:
      case PrimaryButtonVariant.destructive:
        return AppColors.white;

      case PrimaryButtonVariant.secondary:
        return AppColors.primary;
    }
  }

  Color get _borderColor {
    switch (variant) {
      case PrimaryButtonVariant.primary:
        return AppColors.primary;

      case PrimaryButtonVariant.secondary:
        return AppColors.primary;

      case PrimaryButtonVariant.destructive:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _backgroundColor,
          foregroundColor: _foregroundColor,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.disabledForeground,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            side: BorderSide(
              color: isDisabled ? AppColors.disabled : _borderColor,
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: AppSpacing.iconMedium,
                height: AppSpacing.iconMedium,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    variant == PrimaryButtonVariant.secondary
                        ? AppColors.primary
                        : AppColors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: AppSpacing.iconMedium),
                    const SizedBox(width: AppSpacing.xs),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.labelLarge.copyWith(
                        color: _foregroundColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
