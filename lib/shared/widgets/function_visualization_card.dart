import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class FunctionVisualizationCard extends StatefulWidget {
  final bool isEnglish;

  const FunctionVisualizationCard({
    super.key,
    required this.isEnglish,
  });

  @override
  State<FunctionVisualizationCard> createState() =>
      _FunctionVisualizationCardState();
}

class _FunctionVisualizationCardState extends State<FunctionVisualizationCard> {
  double _x = 1;

  double get _y => (2 * _x) + 1;

  String _format(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final xLabel = _format(_x);
    final yLabel = _format(_y);

    return Semantics(
      container: true,
      label: widget.isEnglish
          ? 'Interactive graph of f of x equals 2x plus 1. Current point: x equals $xLabel and f of x equals $yLabel.'
          : 'Gráfico interativo de f de x igual a 2x mais 1. Ponto atual: x igual a $xLabel e f de x igual a $yLabel.',
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.auto_graph_rounded,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'f(x) = 2x + 1',
                        style: AppTypography.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.isEnglish
                            ? 'Move x and watch the point change on the graph.'
                            : 'Mova x e observe o ponto mudar no gráfico.',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            AspectRatio(
              aspectRatio: 1.35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: ColoredBox(
                  color: AppColors.surfaceSecondary,
                  child: CustomPaint(
                    painter: _FunctionGraphPainter(x: _x, y: _y),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(child: _ValueChip(label: 'x', value: xLabel)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: _ValueChip(label: 'f(x)', value: yLabel)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Slider(
              value: _x,
              min: -3,
              max: 3,
              divisions: 12,
              label: 'x = $xLabel',
              onChanged: (value) => setState(() => _x = value),
            ),
            Text(
              widget.isEnglish
                  ? 'The highlighted point is ($xLabel, $yLabel). Every chosen x produces exactly one y-value.'
                  : 'O ponto destacado é ($xLabel, $yLabel). Cada x escolhido produz exatamente um valor de y.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ValueChip extends StatelessWidget {
  final String label;
  final String value;

  const _ValueChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.selectedBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        '$label = $value',
        textAlign: TextAlign.center,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _FunctionGraphPainter extends CustomPainter {
  final double x;
  final double y;

  const _FunctionGraphPainter({required this.x, required this.y});

  static const double minX = -4;
  static const double maxX = 4;
  static const double minY = -7;
  static const double maxY = 9;

  Offset _toCanvas(Size size, double graphX, double graphY) {
    final dx = ((graphX - minX) / (maxX - minX)) * size.width;
    final dy = size.height -
        (((graphY - minY) / (maxY - minY)) * size.height);
    return Offset(dx, dy);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    final axisPaint = Paint()
      ..color = AppColors.textSecondary
      ..strokeWidth = 1.5;
    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final guidePaint = Paint()
      ..color = AppColors.secondaryDark.withValues(alpha: 0.55)
      ..strokeWidth = 1.5;
    final pointPaint = Paint()
      ..color = AppColors.secondaryDark
      ..style = PaintingStyle.fill;

    for (var graphX = minX; graphX <= maxX; graphX += 1) {
      canvas.drawLine(
        _toCanvas(size, graphX, minY),
        _toCanvas(size, graphX, maxY),
        gridPaint,
      );
    }

    for (var graphY = minY; graphY <= maxY; graphY += 2) {
      canvas.drawLine(
        _toCanvas(size, minX, graphY),
        _toCanvas(size, maxX, graphY),
        gridPaint,
      );
    }

    canvas.drawLine(
      _toCanvas(size, minX, 0),
      _toCanvas(size, maxX, 0),
      axisPaint,
    );
    canvas.drawLine(
      _toCanvas(size, 0, minY),
      _toCanvas(size, 0, maxY),
      axisPaint,
    );

    final path = Path();
    var firstPoint = true;
    for (var graphX = minX; graphX <= maxX; graphX += 0.05) {
      final graphY = (2 * graphX) + 1;
      final point = _toCanvas(size, graphX, graphY);
      if (firstPoint) {
        path.moveTo(point.dx, point.dy);
        firstPoint = false;
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(path, linePaint);

    final selectedPoint = _toCanvas(size, x, y);
    canvas.drawLine(
      _toCanvas(size, x, 0),
      selectedPoint,
      guidePaint,
    );
    canvas.drawLine(
      _toCanvas(size, 0, y),
      selectedPoint,
      guidePaint,
    );
    canvas.drawCircle(selectedPoint, 7, pointPaint);
    canvas.drawCircle(
      selectedPoint,
      11,
      Paint()
        ..color = AppColors.secondary.withValues(alpha: 0.18)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant _FunctionGraphPainter oldDelegate) {
    return oldDelegate.x != x || oldDelegate.y != y;
  }
}
