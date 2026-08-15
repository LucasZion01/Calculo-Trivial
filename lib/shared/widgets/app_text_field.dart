import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final String? errorText;

  final bool obscureText;
  final bool enabled;

  final TextEditingController? controller;
  final TextInputType? keyboardType;

  final IconData? prefixIcon;
  final Widget? suffixIcon;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const AppTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.errorText,
    this.obscureText = false,
    this.enabled = true,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;

    return TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      style: AppTypography.bodyMedium.copyWith(
        color: enabled
            ? AppColors.textPrimary
            : AppColors.textDisabled,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,

        labelStyle: AppTypography.bodyMedium.copyWith(
          color: hasError
              ? AppColors.error
              : AppColors.textSecondary,
        ),

        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textMuted,
        ),

        errorStyle: AppTypography.caption.copyWith(
          color: AppColors.error,
        ),

        filled: true,
        fillColor: enabled
            ? AppColors.inputBackground
            : AppColors.surfaceSecondary,

        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: AppSpacing.iconMedium,
                color: hasError
                    ? AppColors.error
                    : AppColors.textMuted,
              )
            : null,

        suffixIcon: suffixIcon,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.inputPaddingHorizontal,
          vertical: AppSpacing.inputPaddingVertical,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMedium,
          ),
          borderSide: BorderSide(
            color: hasError
                ? AppColors.inputErrorBorder
                : AppColors.inputBorder,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMedium,
          ),
          borderSide: BorderSide(
            color: hasError
                ? AppColors.inputErrorBorder
                : AppColors.inputFocusedBorder,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMedium,
          ),
          borderSide: const BorderSide(
            color: AppColors.inputErrorBorder,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMedium,
          ),
          borderSide: const BorderSide(
            color: AppColors.inputErrorBorder,
            width: 2,
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMedium,
          ),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
    );
  }
}