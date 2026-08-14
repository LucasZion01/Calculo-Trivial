import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';

class MathCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String symbol;
  final String? status;
  final Color? statusColor;
  final VoidCallback? onTap;

  const MathCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.symbol,
    this.status,
    this.statusColor,
    this.onTap,
  });

  @override
  State<MathCard> createState() => _MathCardState();
}

class _MathCardState extends State<MathCard> {
  bool isPressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null) return;

    setState(() {
      isPressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isPressed ? 0.98 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: widget.onTap,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) => _setPressed(false),
          onTapCancel: () => _setPressed(false),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              minHeight: 96,
            ),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.border,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
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
                    color: AppColors.selectedBackground,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    widget.symbol,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.status != null) ...[
                  const SizedBox(width: 12),
                  Text(
                    widget.status!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: widget.statusColor ?? AppColors.textSecondary,
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
