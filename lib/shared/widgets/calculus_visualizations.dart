import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class LimitApproachVisualization extends StatefulWidget {
  final bool isEnglish;

  const LimitApproachVisualization({
    super.key,
    required this.isEnglish,
  });

  @override
  State<LimitApproachVisualization> createState() =>
      _LimitApproachVisualizationState();
}

class _LimitApproachVisualizationState
    extends State<LimitApproachVisualization> {
  double _x = 1;

  double get _y => (2 * _x) + 1;

  @override
  Widget build(BuildContext context) {
    final xText = _x.toStringAsFixed(2);
    final yText = _y.toStringAsFixed(2);

    return _VisualizationCard(
      title: widget.isEnglish
          ? 'Approach x = 3 without needing to touch it'
          : 'Aproxime x de 3 sem precisar tocar no ponto',
      subtitle: widget.isEnglish
          ? 'For f(x) = 2x + 1, watch the output approach 7.'
          : 'Em f(x) = 2x + 1, observe a saída se aproximar de 7.',
      semanticLabel: widget.isEnglish
          ? 'Interactive limit visualization. x equals $xText and f of x equals $yText.'
          : 'Visualização interativa de limite. x igual a $xText e f de x igual a $yText.',
      graph: CustomPaint(
        painter: _LimitPainter(x: _x),
        child: const SizedBox.expand(),
      ),
      values: [
        _ValueChip(label: 'x', value: xText),
        _ValueChip(label: 'f(x)', value: yText),
        const _ValueChip(label: 'L', value: '7'),
      ],
      control: Slider(
        value: _x,
        min: 1,
        max: 2.99,
        divisions: 199,
        label: 'x = $xText',
        onChanged: (value) => setState(() => _x = value),
      ),
      footer: widget.isEnglish
          ? 'As x gets closer to 3, f(x) gets closer to 7. The limit describes this trend.'
          : 'Quanto mais x se aproxima de 3, mais f(x) se aproxima de 7. O limite descreve essa tendência.',
    );
  }
}

class ContinuityVisualization extends StatefulWidget {
  final bool isEnglish;

  const ContinuityVisualization({
    super.key,
    required this.isEnglish,
  });

  @override
  State<ContinuityVisualization> createState() =>
      _ContinuityVisualizationState();
}

class _ContinuityVisualizationState extends State<ContinuityVisualization> {
  bool _continuous = true;

  @override
  Widget build(BuildContext context) {
    return _VisualizationCard(
      title: widget.isEnglish
          ? 'Continuous point or removable hole?'
          : 'Ponto contínuo ou furo removível?',
      subtitle: widget.isEnglish
          ? 'Compare the limit with the actual value f(1).'
          : 'Compare o limite com o valor efetivo de f(1).',
      semanticLabel: widget.isEnglish
          ? 'Continuity visualization at x equals 1. Current state: ${_continuous ? 'continuous' : 'discontinuous'}.'
          : 'Visualização de continuidade em x igual a 1. Estado atual: ${_continuous ? 'contínua' : 'descontínua'}.',
      graph: CustomPaint(
        painter: _ContinuityPainter(continuous: _continuous),
        child: const SizedBox.expand(),
      ),
      values: [
        const _ValueChip(label: 'lim', value: '2'),
        _ValueChip(label: 'f(1)', value: _continuous ? '2' : '4'),
      ],
      control: SegmentedButton<bool>(
        segments: [
          ButtonSegment<bool>(
            value: true,
            label: Text(widget.isEnglish ? 'Continuous' : 'Contínua'),
          ),
          ButtonSegment<bool>(
            value: false,
            label: Text(widget.isEnglish ? 'With hole' : 'Com furo'),
          ),
        ],
        selected: {_continuous},
        onSelectionChanged: (selection) {
          setState(() => _continuous = selection.first);
        },
      ),
      footer: _continuous
          ? (widget.isEnglish
                ? 'The limit is 2 and f(1) = 2, so the function is continuous at x = 1.'
                : 'O limite é 2 e f(1) = 2, então a função é contínua em x = 1.')
          : (widget.isEnglish
                ? 'The graph approaches 2, but f(1) = 4. The limit exists, yet continuity fails.'
                : 'O gráfico se aproxima de 2, mas f(1) = 4. O limite existe, porém a continuidade falha.'),
    );
  }
}

class DerivativeTangentVisualization extends StatefulWidget {
  final bool isEnglish;

  const DerivativeTangentVisualization({
    super.key,
    required this.isEnglish,
  });

  @override
  State<DerivativeTangentVisualization> createState() =>
      _DerivativeTangentVisualizationState();
}

class _DerivativeTangentVisualizationState
    extends State<DerivativeTangentVisualization> {
  double _x = 1;
  double get _slope => 2 * _x;

  @override
  Widget build(BuildContext context) {
    final xText = _x.toStringAsFixed(1);
    final slopeText = _slope.toStringAsFixed(1);

    return _VisualizationCard(
      title: widget.isEnglish
          ? 'Move the point and watch the tangent rotate'
          : 'Mova o ponto e observe a tangente girar',
      subtitle: widget.isEnglish
          ? 'For f(x) = x², the derivative gives the local slope.'
          : 'Em f(x) = x², a derivada fornece a inclinação local.',
      semanticLabel: widget.isEnglish
          ? 'Derivative visualization for x squared. x equals $xText and slope equals $slopeText.'
          : 'Visualização de derivada para x ao quadrado. x igual a $xText e inclinação igual a $slopeText.',
      graph: CustomPaint(
        painter: _DerivativePainter(x: _x),
        child: const SizedBox.expand(),
      ),
      values: [
        _ValueChip(label: 'x', value: xText),
        _ValueChip(label: "f'(x)", value: slopeText),
      ],
      control: Slider(
        value: _x,
        min: -2,
        max: 2,
        divisions: 16,
        label: 'x = $xText',
        onChanged: (value) => setState(() => _x = value),
      ),
      footer: widget.isEnglish
          ? 'The tangent line represents the instantaneous rate of change at the selected point.'
          : 'A reta tangente representa a taxa de variação instantânea no ponto selecionado.',
    );
  }
}

class _VisualizationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String semanticLabel;
  final Widget graph;
  final List<Widget> values;
  final Widget control;
  final String footer;

  const _VisualizationCard({
    required this.title,
    required this.subtitle,
    required this.semanticLabel,
    required this.graph,
    required this.values,
    required this.control,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticLabel,
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
            Text(title, style: AppTypography.titleMedium),
            const SizedBox(height: AppSpacing.xs),
            Text(
              subtitle,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AspectRatio(
              aspectRatio: 1.55,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: ColoredBox(
                  color: AppColors.surfaceSecondary,
                  child: graph,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: values,
            ),
            const SizedBox(height: AppSpacing.sm),
            control,
            const SizedBox(height: AppSpacing.xs),
            Text(
              footer,
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
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.primaryDark,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

abstract class _GraphPainter extends CustomPainter {
  const _GraphPainter();

  Offset point(Size size, double x, double y) {
    const minX = -3.0;
    const maxX = 3.0;
    const minY = -1.0;
    const maxY = 6.0;
    final dx = ((x - minX) / (maxX - minX)) * size.width;
    final dy = size.height - (((y - minY) / (maxY - minY)) * size.height);
    return Offset(dx, dy);
  }

  void drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.border
      ..strokeWidth = 1;
    final axisPaint = Paint()
      ..color = AppColors.textSecondary
      ..strokeWidth = 1.5;

    for (var x = -3; x <= 3; x++) {
      canvas.drawLine(
        point(size, x.toDouble(), -1),
        point(size, x.toDouble(), 6),
        gridPaint,
      );
    }
    for (var y = 0; y <= 6; y++) {
      canvas.drawLine(
        point(size, -3, y.toDouble()),
        point(size, 3, y.toDouble()),
        gridPaint,
      );
    }
    canvas.drawLine(point(size, -3, 0), point(size, 3, 0), axisPaint);
    canvas.drawLine(point(size, 0, -1), point(size, 0, 6), axisPaint);
  }
}

class _LimitPainter extends _GraphPainter {
  final double x;

  const _LimitPainter({required this.x});

  @override
  void paint(Canvas canvas, Size size) {
    drawGrid(canvas, size);
    final linePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final selected = Paint()..color = AppColors.secondaryDark;

    final path = Path();
    for (var px = -3.0; px <= 3; px += 0.05) {
      final p = point(size, px, (2 * px) + 1);
      if (px == -3.0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(path, linePaint);

    final current = point(size, x, (2 * x) + 1);
    canvas.drawCircle(current, 7, selected);
    canvas.drawCircle(
      point(size, 3, 7),
      7,
      Paint()
        ..color = AppColors.surface
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      point(size, 3, 7),
      7,
      Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
  }

  @override
  bool shouldRepaint(covariant _LimitPainter oldDelegate) => oldDelegate.x != x;
}

class _ContinuityPainter extends _GraphPainter {
  final bool continuous;

  const _ContinuityPainter({required this.continuous});

  @override
  void paint(Canvas canvas, Size size) {
    drawGrid(canvas, size);
    final curvePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final path = Path();
    for (var px = -3.0; px <= 3; px += 0.05) {
      final p = point(size, px, px + 1);
      if (px == -3.0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(path, curvePaint);

    final target = point(size, 1, 2);
    if (continuous) {
      canvas.drawCircle(target, 7, Paint()..color = AppColors.secondaryDark);
    } else {
      canvas.drawCircle(target, 8, Paint()..color = AppColors.surface);
      canvas.drawCircle(
        target,
        8,
        Paint()
          ..color = AppColors.primary
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
      canvas.drawCircle(
        point(size, 1, 4),
        7,
        Paint()..color = AppColors.error,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ContinuityPainter oldDelegate) =>
      oldDelegate.continuous != continuous;
}

class _DerivativePainter extends _GraphPainter {
  final double x;

  const _DerivativePainter({required this.x});

  @override
  void paint(Canvas canvas, Size size) {
    drawGrid(canvas, size);
    final curvePaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    final tangentPaint = Paint()
      ..color = AppColors.secondaryDark
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final curve = Path();
    for (var px = -2.4; px <= 2.4; px += 0.04) {
      final p = point(size, px, px * px);
      if ((px + 2.4).abs() < 0.01) {
        curve.moveTo(p.dx, p.dy);
      } else {
        curve.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(curve, curvePaint);

    final slope = 2 * x;
    final intercept = (x * x) - (slope * x);
    final leftX = math.max(-3.0, x - 1.5);
    final rightX = math.min(3.0, x + 1.5);
    canvas.drawLine(
      point(size, leftX, (slope * leftX) + intercept),
      point(size, rightX, (slope * rightX) + intercept),
      tangentPaint,
    );
    canvas.drawCircle(
      point(size, x, x * x),
      7,
      Paint()..color = AppColors.secondaryDark,
    );
  }

  @override
  bool shouldRepaint(covariant _DerivativePainter oldDelegate) =>
      oldDelegate.x != x;
}
