import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

enum MathCardState { normal, selected, completed, locked }

class MathCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String symbol;
  final String? status;
  final Color? statusColor;
  final VoidCallback? onTap;
  final MathCardState state;

  const MathCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.symbol,
    this.status,
    this.statusColor,
    this.onTap,
    this.state = MathCardState.normal,
  });

  @override
  State<MathCard> createState() => _MathCardState();
}

class _MathCardState extends State<MathCard> {
  bool _isPressed = false;

  bool get _isLocked =>
      widget.state == MathCardState.locked || widget.onTap == null;

  void _setPressed(bool value) {
    if (_isLocked) return;

    setState(() {
      _isPressed = value;
    });
  }

  Color get _backgroundColor {
    switch (widget.state) {
      case MathCardState.selected:
        return AppColors.selectedBackground;

      case MathCardState.completed:
        return AppColors.successLight;

      case MathCardState.locked:
        return AppColors.lockedBackground;

      case MathCardState.normal:
        return AppColors.surface;
    }
  }

  Color get _borderColor {
    switch (widget.state) {
      case MathCardState.selected:
        return AppColors.primary;

      case MathCardState.completed:
        return AppColors.success;

      case MathCardState.locked:
        return AppColors.border;

      case MathCardState.normal:
        return AppColors.border;
    }
  }

  Color get _symbolBackgroundColor {
    switch (widget.state) {
      case MathCardState.completed:
        return AppColors.successLight;

      case MathCardState.locked:
        return AppColors.lockedBackground;

      case MathCardState.selected:
      case MathCardState.normal:
        return AppColors.selectedBackground;
    }
  }

  Color get _symbolColor {
    switch (widget.state) {
      case MathCardState.completed:
        return AppColors.success;

      case MathCardState.locked:
        return AppColors.locked;

      case MathCardState.selected:
      case MathCardState.normal:
        return AppColors.primary;
    }
  }

  Color get _titleColor {
    if (_isLocked) {
      return AppColors.textDisabled;
    }

    return AppColors.textPrimary;
  }

  Color get _subtitleColor {
    if (_isLocked) {
      return AppColors.textDisabled;
    }

    return AppColors.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _isPressed ? 0.985 : 1,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: InkWell(
          onTap: _isLocked ? null : widget.onTap,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) => _setPressed(false),
          onTapCancel: () => _setPressed(false),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 96),
            padding: const EdgeInsets.all(AppSpacing.cardPaddingLarge),
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
              border: Border.all(
                color: _borderColor,
                width: widget.state == MathCardState.selected ? 2 : 1,
              ),
              boxShadow: _isLocked
                  ? const []
                  : [
                      const BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _symbolBackgroundColor,
                    borderRadius: BorderRadius.circular(
                      AppSpacing.radiusMedium,
                    ),
                  ),
                  child: _isLocked
                      ? const Icon(
                          Icons.lock_outline_rounded,
                          size: AppSpacing.iconLarge,
                          color: AppColors.locked,
                        )
                      : Text(
                          widget.symbol,
                          textAlign: TextAlign.center,
                          style: AppTypography.headingSmall.copyWith(
                            color: _symbolColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.titleMedium.copyWith(
                          color: _titleColor,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        widget.subtitle,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodySmall.copyWith(
                          color: _subtitleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.status != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Flexible(
                    child: Text(
                      widget.status!,
                      maxLines: 2,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.labelSmall.copyWith(
                        color:
                            widget.statusColor ??
                            (_isLocked
                                ? AppColors.locked
                                : AppColors.textSecondary),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
