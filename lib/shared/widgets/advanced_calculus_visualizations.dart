import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:calcquest/shared/theme/app_colors.dart';
import 'package:calcquest/shared/theme/app_spacing.dart';
import 'package:calcquest/shared/theme/app_typography.dart';

class FunctionDomainTransformVisualization extends StatefulWidget {
  final bool isEnglish;

  const FunctionDomainTransformVisualization({
    super.key,
    required this.isEnglish,
  });

  @override
  State<FunctionDomainTransformVisualization> createState() =>
      _FunctionDomainTransformVisualizationState();
}

class _FunctionDomainTransformVisualizationState
    extends State<FunctionDomainTransformVisualization> {
  int _mode = 0;

  String get _formula => switch (_mode) {
        0 => 'f(x) = x²',
        1 => 'f(x) = x² + 2',
        _ => 'f(x) = -x²',
      };

  @override
  Widget build(BuildContext context) {
    final domain = 'ℝ';
    final range = switch (_mode) {
      0 => '[0, +∞)',
      1 => '[2, +∞)',
      _ => '(-∞, 0]',
    };

    return _MathVizCard(
      title: widget.isEnglish
          ? 'Domain, range, and transformations'
          : 'Domínio, imagem e transformações',
      subtitle: widget.isEnglish
          ? 'Compare how vertical shifts and reflections change the range without changing the domain.'
          : 'Compare como deslocamentos verticais e reflexões mudam a imagem sem alterar o domínio.',
      semanticLabel: widget.isEnglish
          ? 'Function transformation visualization. $_formula. Domain all real numbers. Range $range.'
          : 'Visualização de transformação de função. $_formula. Domínio todos os reais. Imagem $range.',
      graph: CustomPaint(
        painter: _FunctionTransformPainter(mode: _mode),
        child: const SizedBox.expand(),
      ),
      values: [
        _ValueChip(label: 'Dom', value: domain),
        _ValueChip(label: widget.isEnglish ? 'Range' : 'Im', value: range),
      ],
      control: SegmentedButton<int>(
        segments: const [
          ButtonSegment(value: 0, label: Text('x²')),
          ButtonSegment(value: 1, label: Text('x² + 2')),
          ButtonSegment(value: 2, label: Text('-x²')),
        ],
        selected: {_mode},
        onSelectionChanged: (selection) {
          setState(() => _mode = selection.first);
        },
      ),
      footer: widget.isEnglish
          ? 'A vertical shift changes the range. A reflection over the x-axis reverses its direction.'
          : 'Um deslocamento vertical altera a imagem. A reflexão no eixo x inverte a direção da parábola.',
    );
  }
}

class OneSidedLimitVisualization extends StatefulWidget {
  final bool isEnglish;

  const OneSidedLimitVisualization({
    super.key,
    required this.isEnglish,
  });

  @override
  State<OneSidedLimitVisualization> createState() =>
      _OneSidedLimitVisualizationState();
}

class _OneSidedLimitVisualizationState
    extends State<OneSidedLimitVisualization> {
  double _distance = 1.5;

  @override
  Widget build(BuildContext context) {
    final leftX = -_distance;
    final rightX = _distance;
    final leftY = leftX < 0 ? 1 + leftX.abs() * 0.15 : 3;
    final rightY = rightX > 0 ? 3 - rightX.abs() * 0.15 : 1;

    return _MathVizCard(
      title: widget.isEnglish
          ? 'Approach the same point from both sides'
          : 'Aproxime o mesmo ponto pelos dois lados',
      subtitle: widget.isEnglish
          ? 'The left-hand limit tends to 1 while the right-hand limit tends to 3.'
          : 'O limite pela esquerda tende a 1, enquanto o limite pela direita tende a 3.',
      semanticLabel: widget.isEnglish
          ? 'One sided limits at x equals zero. Left limit 1 and right limit 3.'
          : 'Limites laterais em x igual a zero. Limite esquerdo 1 e limite direito 3.',
      graph: CustomPaint(
        painter: _OneSidedLimitPainter(distance: _distance),
        child: const SizedBox.expand(),
      ),
      values: const [
        _ValueChip(label: 'lim x→0⁻', value: '1'),
        _ValueChip(label: 'lim x→0⁺', value: '3'),
      ],
      control: Slider(
        value: _distance,
        min: 0.05,
        max: 1.5,
        divisions: 29,
        label: _distance.toStringAsFixed(2),
        onChanged: (value) => setState(() => _distance = value),
      ),
      footer: widget.isEnglish
          ? 'Because the two one-sided limits are different, the two-sided limit does not exist.'
          : 'Como os limites laterais são diferentes, o limite bilateral não existe.',
    );
  }
}

class AsymptoteVisualization extends StatefulWidget {
  final bool isEnglish;

  const AsymptoteVisualization({
    super.key,
    required this.isEnglish,
  });

  @override
  State<AsymptoteVisualization> createState() => _AsymptoteVisualizationState();
}

class _AsymptoteVisualizationState extends State<AsymptoteVisualization> {
  double _x = 1.5;

  @override
  Widget build(BuildContext context) {
    final y = 1 / _x;
    return _MathVizCard(
      title: widget.isEnglish
          ? 'See a vertical asymptote emerge'
          : 'Observe uma assíntota vertical surgir',
      subtitle: widget.isEnglish
          ? 'For f(x) = 1/x, moving x toward 0 makes |f(x)| grow without bound.'
          : 'Em f(x) = 1/x, aproximar x de 0 faz |f(x)| crescer sem limite.',
      semanticLabel: widget.isEnglish
          ? 'Asymptote visualization for one over x. Current x ${_x.toStringAsFixed(2)} and f of x ${y.toStringAsFixed(2)}.'
          : 'Visualização de assíntota para um sobre x. x atual ${_x.toStringAsFixed(2)} e f de x ${y.toStringAsFixed(2)}.',
      graph: CustomPaint(
        painter: _AsymptotePainter(x: _x),
        child: const SizedBox.expand(),
      ),
      values: [
        _ValueChip(label: 'x', value: _x.toStringAsFixed(2)),
        _ValueChip(label: 'f(x)', value: y.toStringAsFixed(2)),
        const _ValueChip(label: 'assíntota', value: 'x = 0'),
      ],
      control: Slider(
        value: _x,
        min: 0.15,
        max: 2.5,
        divisions: 47,
        label: 'x = ${_x.toStringAsFixed(2)}',
        onChanged: (value) => setState(() => _x = value),
      ),
      footer: widget.isEnglish
          ? 'The graph never needs to touch x = 0 for that line to control the limiting behavior.'
          : 'O gráfico não precisa tocar x = 0 para que essa reta controle o comportamento limite.',
    );
  }
}

class DiscontinuityTypesVisualization extends StatefulWidget {
  final bool isEnglish;

  const DiscontinuityTypesVisualization({
    super.key,
    required this.isEnglish,
  });

  @override
  State<DiscontinuityTypesVisualization> createState() =>
      _DiscontinuityTypesVisualizationState();
}

class _DiscontinuityTypesVisualizationState
    extends State<DiscontinuityTypesVisualization> {
  int _type = 0;

  @override
  Widget build(BuildContext context) {
    final label = switch (_type) {
      0 => widget.isEnglish ? 'Removable' : 'Removível',
      1 => widget.isEnglish ? 'Jump' : 'Salto',
      _ => widget.isEnglish ? 'Infinite' : 'Infinita',
    };

    return _MathVizCard(
      title: widget.isEnglish
          ? 'Compare types of discontinuity'
          : 'Compare tipos de descontinuidade',
      subtitle: widget.isEnglish
          ? 'A hole, a jump, and an infinite discontinuity fail continuity for different reasons.'
          : 'Um furo, um salto e uma descontinuidade infinita quebram a continuidade por motivos diferentes.',
      semanticLabel: widget.isEnglish
          ? 'Discontinuity type visualization. Current type $label.'
          : 'Visualização de tipo de descontinuidade. Tipo atual $label.',
      graph: CustomPaint(
        painter: _DiscontinuityPainter(type: _type),
        child: const SizedBox.expand(),
      ),
      values: [_ValueChip(label: widget.isEnglish ? 'Type' : 'Tipo', value: label)],
      control: SegmentedButton<int>(
        segments: [
          ButtonSegment(value: 0, label: Text(widget.isEnglish ? 'Hole' : 'Furo')),
          ButtonSegment(value: 1, label: Text(widget.isEnglish ? 'Jump' : 'Salto')),
          ButtonSegment(value: 2, label: Text(widget.isEnglish ? 'Infinite' : 'Infinita')),
        ],
        selected: {_type},
        onSelectionChanged: (selection) => setState(() => _type = selection.first),
      ),
      footer: switch (_type) {
        0 => widget.isEnglish
            ? 'The limit exists, but the function value is missing or different.'
            : 'O limite existe, mas o valor da função está ausente ou é diferente.',
        1 => widget.isEnglish
            ? 'The left and right limits are finite but different.'
            : 'Os limites laterais são finitos, porém diferentes.',
        _ => widget.isEnglish
            ? 'The function grows without bound near the critical x-value.'
            : 'A função cresce sem limite perto do valor crítico de x.',
      },
    );
  }
}

class SecantToTangentVisualization extends StatefulWidget {
  final bool isEnglish;

  const SecantToTangentVisualization({
    super.key,
    required this.isEnglish,
  });

  @override
  State<SecantToTangentVisualization> createState() =>
      _SecantToTangentVisualizationState();
}

class _SecantToTangentVisualizationState
    extends State<SecantToTangentVisualization> {
  double _h = 1.5;

  @override
  Widget build(BuildContext context) {
    const x0 = 1.0;
    final secantSlope = (((x0 + _h) * (x0 + _h)) - (x0 * x0)) / _h;

    return _MathVizCard(
      title: widget.isEnglish
          ? 'Shrink the secant into the tangent'
          : 'Faça a secante se aproximar da tangente',
      subtitle: widget.isEnglish
          ? 'For f(x) = x² at x = 1, reduce h and watch the secant slope approach 2.'
          : 'Em f(x) = x² no ponto x = 1, reduza h e observe a inclinação da secante se aproximar de 2.',
      semanticLabel: widget.isEnglish
          ? 'Secant to tangent visualization. h ${_h.toStringAsFixed(2)}, secant slope ${secantSlope.toStringAsFixed(2)}, tangent slope 2.'
          : 'Visualização de secante para tangente. h ${_h.toStringAsFixed(2)}, inclinação da secante ${secantSlope.toStringAsFixed(2)}, inclinação da tangente 2.',
      graph: CustomPaint(
        painter: _SecantPainter(h: _h),
        child: const SizedBox.expand(),
      ),
      values: [
        _ValueChip(label: 'h', value: _h.toStringAsFixed(2)),
        _ValueChip(label: 'm sec', value: secantSlope.toStringAsFixed(2)),
        const _ValueChip(label: 'f′(1)', value: '2'),
      ],
      control: Slider(
        value: _h,
        min: 0.05,
        max: 1.5,
        divisions: 29,
        label: 'h = ${_h.toStringAsFixed(2)}',
        onChanged: (value) => setState(() => _h = value),
      ),
      footer: widget.isEnglish
          ? 'The derivative is the limiting value of these secant slopes as h approaches zero.'
          : 'A derivada é o valor limite dessas inclinações de secantes quando h tende a zero.',
    );
  }
}

class _MathVizCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String semanticLabel;
  final Widget graph;
  final List<Widget> values;
  final Widget control;
  final String footer;

  const _MathVizCard({
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
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
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
            Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: values),
            const SizedBox(height: AppSpacing.sm),
            control,
            const SizedBox(height: AppSpacing.xs),
            Text(
              footer,
              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
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

abstract class _BasePainter extends CustomPainter {
  const _BasePainter();

  Offset map(Size size, double x, double y, {double minX = -3, double maxX = 3, double minY = -3, double maxY = 6}) {
    return Offset(
      ((x - minX) / (maxX - minX)) * size.width,
      size.height - (((y - minY) / (maxY - minY)) * size.height),
    );
  }

  void grid(Canvas canvas, Size size, {double minY = -3, double maxY = 6}) {
    final gridPaint = Paint()..color = AppColors.border..strokeWidth = 1;
    final axisPaint = Paint()..color = AppColors.textSecondary..strokeWidth = 1.5;
    for (var x = -3; x <= 3; x++) {
      canvas.drawLine(map(size, x.toDouble(), minY, minY: minY, maxY: maxY), map(size, x.toDouble(), maxY, minY: minY, maxY: maxY), gridPaint);
    }
    for (var y = minY.ceil(); y <= maxY.floor(); y++) {
      canvas.drawLine(map(size, -3, y.toDouble(), minY: minY, maxY: maxY), map(size, 3, y.toDouble(), minY: minY, maxY: maxY), gridPaint);
    }
    if (minY <= 0 && maxY >= 0) {
      canvas.drawLine(map(size, -3, 0, minY: minY, maxY: maxY), map(size, 3, 0, minY: minY, maxY: maxY), axisPaint);
    }
    canvas.drawLine(map(size, 0, minY, minY: minY, maxY: maxY), map(size, 0, maxY, minY: minY, maxY: maxY), axisPaint);
  }
}

class _FunctionTransformPainter extends _BasePainter {
  final int mode;
  const _FunctionTransformPainter({required this.mode});

  double value(double x) => switch (mode) {0 => x * x, 1 => x * x + 2, _ => -(x * x)};

  @override
  void paint(Canvas canvas, Size size) {
    grid(canvas, size, minY: -5, maxY: 7);
    final paint = Paint()..color = AppColors.primary..strokeWidth = 3..style = PaintingStyle.stroke;
    final path = Path();
    var first = true;
    for (var x = -2.4; x <= 2.4; x += 0.04) {
      final p = map(size, x, value(x), minY: -5, maxY: 7);
      if (first) { path.moveTo(p.dx, p.dy); first = false; } else { path.lineTo(p.dx, p.dy); }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _FunctionTransformPainter oldDelegate) => oldDelegate.mode != mode;
}

class _OneSidedLimitPainter extends _BasePainter {
  final double distance;
  const _OneSidedLimitPainter({required this.distance});

  @override
  void paint(Canvas canvas, Size size) {
    grid(canvas, size, minY: 0, maxY: 4);
    final leftPaint = Paint()..color = AppColors.primary..strokeWidth = 3;
    final rightPaint = Paint()..color = AppColors.secondaryDark..strokeWidth = 3;
    canvas.drawLine(map(size, -3, 1.45, minY: 0, maxY: 4), map(size, 0, 1, minY: 0, maxY: 4), leftPaint);
    canvas.drawLine(map(size, 0, 3, minY: 0, maxY: 4), map(size, 3, 2.55, minY: 0, maxY: 4), rightPaint);
    final lx = -distance;
    final rx = distance;
    canvas.drawCircle(map(size, lx, 1 + lx.abs() * 0.15, minY: 0, maxY: 4), 7, Paint()..color = AppColors.primaryDark);
    canvas.drawCircle(map(size, rx, 3 - rx.abs() * 0.15, minY: 0, maxY: 4), 7, Paint()..color = AppColors.secondaryDark);
    for (final y in [1.0, 3.0]) {
      canvas.drawCircle(map(size, 0, y, minY: 0, maxY: 4), 7, Paint()..color = AppColors.surface);
      canvas.drawCircle(map(size, 0, y, minY: 0, maxY: 4), 7, Paint()..color = AppColors.textSecondary..style = PaintingStyle.stroke..strokeWidth = 2);
    }
  }

  @override
  bool shouldRepaint(covariant _OneSidedLimitPainter oldDelegate) => oldDelegate.distance != distance;
}

class _AsymptotePainter extends _BasePainter {
  final double x;
  const _AsymptotePainter({required this.x});

  @override
  void paint(Canvas canvas, Size size) {
    grid(canvas, size, minY: -5, maxY: 5);
    final curvePaint = Paint()..color = AppColors.primary..strokeWidth = 3..style = PaintingStyle.stroke;
    final asymptotePaint = Paint()..color = AppColors.error..strokeWidth = 2;
    const dash = 8.0;
    for (var y = 0.0; y < size.height; y += dash * 2) {
      final xCanvas = map(size, 0, 0, minY: -5, maxY: 5).dx;
      canvas.drawLine(Offset(xCanvas, y), Offset(xCanvas, math.min(y + dash, size.height)), asymptotePaint);
    }
    for (final sign in [-1.0, 1.0]) {
      final path = Path();
      var first = true;
      for (var ax = 0.22; ax <= 3; ax += 0.03) {
        final gx = sign * ax;
        final gy = 1 / gx;
        final p = map(size, gx, gy.clamp(-5.0, 5.0), minY: -5, maxY: 5);
        if (first) { path.moveTo(p.dx, p.dy); first = false; } else { path.lineTo(p.dx, p.dy); }
      }
      canvas.drawPath(path, curvePaint);
    }
    canvas.drawCircle(map(size, x, 1 / x, minY: -5, maxY: 5), 7, Paint()..color = AppColors.secondaryDark);
  }

  @override
  bool shouldRepaint(covariant _AsymptotePainter oldDelegate) => oldDelegate.x != x;
}

class _DiscontinuityPainter extends _BasePainter {
  final int type;
  const _DiscontinuityPainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    grid(canvas, size, minY: -2, maxY: 5);
    final p = Paint()..color = AppColors.primary..strokeWidth = 3..style = PaintingStyle.stroke;
    if (type == 0) {
      canvas.drawLine(map(size, -3, -1, minY: -2, maxY: 5), map(size, 3, 5, minY: -2, maxY: 5), p);
      final hole = map(size, 0, 2, minY: -2, maxY: 5);
      canvas.drawCircle(hole, 8, Paint()..color = AppColors.surface);
      canvas.drawCircle(hole, 8, Paint()..color = AppColors.primary..style = PaintingStyle.stroke..strokeWidth = 2.5);
    } else if (type == 1) {
      canvas.drawLine(map(size, -3, 1, minY: -2, maxY: 5), map(size, 0, 1, minY: -2, maxY: 5), p);
      canvas.drawLine(map(size, 0, 3, minY: -2, maxY: 5), map(size, 3, 3, minY: -2, maxY: 5), p);
      canvas.drawCircle(map(size, 0, 1, minY: -2, maxY: 5), 7, Paint()..color = AppColors.surface);
      canvas.drawCircle(map(size, 0, 1, minY: -2, maxY: 5), 7, Paint()..color = AppColors.primary..style = PaintingStyle.stroke..strokeWidth = 2);
      canvas.drawCircle(map(size, 0, 3, minY: -2, maxY: 5), 7, Paint()..color = AppColors.secondaryDark);
    } else {
      final asym = map(size, 0, 0, minY: -2, maxY: 5).dx;
      canvas.drawLine(Offset(asym, 0), Offset(asym, size.height), Paint()..color = AppColors.error..strokeWidth = 2);
      for (final sign in [-1.0, 1.0]) {
        final path = Path();
        var first = true;
        for (var ax = 0.25; ax <= 3; ax += 0.04) {
          final gx = sign * ax;
          final gy = math.min(5.0, 1 / (gx * gx));
          final pt = map(size, gx, gy, minY: -2, maxY: 5);
          if (first) { path.moveTo(pt.dx, pt.dy); first = false; } else { path.lineTo(pt.dx, pt.dy); }
        }
        canvas.drawPath(path, p);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DiscontinuityPainter oldDelegate) => oldDelegate.type != type;
}

class _SecantPainter extends _BasePainter {
  final double h;
  const _SecantPainter({required this.h});

  @override
  void paint(Canvas canvas, Size size) {
    grid(canvas, size, minY: -1, maxY: 7);
    final curvePaint = Paint()..color = AppColors.primary..strokeWidth = 3..style = PaintingStyle.stroke;
    final secantPaint = Paint()..color = AppColors.secondaryDark..strokeWidth = 2.5;
    final tangentPaint = Paint()..color = AppColors.successDark..strokeWidth = 2;
    final path = Path();
    var first = true;
    for (var x = -2.4; x <= 2.4; x += 0.04) {
      final pt = map(size, x, x * x, minY: -1, maxY: 7);
      if (first) { path.moveTo(pt.dx, pt.dy); first = false; } else { path.lineTo(pt.dx, pt.dy); }
    }
    canvas.drawPath(path, curvePaint);
    const x0 = 1.0;
    final x1 = x0 + h;
    final y0 = x0 * x0;
    final y1 = x1 * x1;
    final slope = (y1 - y0) / h;
    final intercept = y0 - slope * x0;
    canvas.drawLine(map(size, -0.5, slope * -0.5 + intercept, minY: -1, maxY: 7), map(size, 2.7, slope * 2.7 + intercept, minY: -1, maxY: 7), secantPaint);
    canvas.drawLine(map(size, -0.5, 2 * -0.5 - 1, minY: -1, maxY: 7), map(size, 2.7, 2 * 2.7 - 1, minY: -1, maxY: 7), tangentPaint);
    canvas.drawCircle(map(size, x0, y0, minY: -1, maxY: 7), 7, Paint()..color = AppColors.primaryDark);
    canvas.drawCircle(map(size, x1, y1, minY: -1, maxY: 7), 7, Paint()..color = AppColors.secondaryDark);
  }

  @override
  bool shouldRepaint(covariant _SecantPainter oldDelegate) => oldDelegate.h != h;
}
