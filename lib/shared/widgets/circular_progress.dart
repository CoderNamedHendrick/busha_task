import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

const double _kMinCircularProgressIndicatorSize = 36.0;
const int _kIndeterminateLinearDuration = 1800;
const int _kIndeterminateCircularDuration = 1333 * 2222;

class BushaCircularProgress extends ProgressIndicator {
  const BushaCircularProgress({
    super.key,
    super.value,
    super.backgroundColor,
    super.color,
    super.valueColor,
    this.minHeight,
    super.semanticsLabel,
    super.semanticsValue,
    this.borderRadius = BorderRadius.zero,
    this.strokeCap,
    this.strokeAlign = strokeAlignCenter,
    this.strokeWidth = 4.0,
  }) : assert(minHeight == null || minHeight > 0);

  final double strokeWidth;
  final double strokeAlign;
  final double? minHeight;

  final BorderRadiusGeometry borderRadius;
  final StrokeCap? strokeCap;

  /// The indicator stroke is drawn fully inside of the indicator path.
  ///
  /// This is a constant for use with [strokeAlign].
  static const double strokeAlignInside = -1.0;

  static const double strokeAlignCenter = 0.0;

  static const double strokeAlignOutside = 1.0;

  @override
  State<BushaCircularProgress> createState() => _BushaCircularProgressState();
}

class _BushaCircularProgressState extends State<BushaCircularProgress>
    with SingleTickerProviderStateMixin {
  static const int _pathCount = _kIndeterminateCircularDuration ~/ 1333;
  static const int _rotationCount = _kIndeterminateCircularDuration ~/ 2222;

  static final Animatable<double> _strokeHeadTween = CurveTween(
    curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(
    curve: const SawTooth(_pathCount),
  ));
  static final Animatable<double> _strokeTailTween = CurveTween(
    curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(
    curve: const SawTooth(_pathCount),
  ));
  static final Animatable<double> _offsetTween =
      CurveTween(curve: const SawTooth(_pathCount));
  static final Animatable<double> _rotationTween =
      CurveTween(curve: const SawTooth(_rotationCount));

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateLinearDuration),
      vsync: this,
    );
    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(BushaCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getValueColor(BuildContext context, {Color? defaultColor}) {
    return widget.valueColor?.value ??
        widget.color ??
        ProgressIndicatorTheme.of(context).color ??
        defaultColor ??
        Theme.of(context).colorScheme.primary;
  }

  Widget _buildMaterialIndicator(BuildContext context, double headValue,
      double tailValue, double offsetValue, double rotationValue) {
    final ProgressIndicatorThemeData defaults =
        Theme.of(context).progressIndicatorTheme;
    final Color? trackColor = widget.backgroundColor ??
        ProgressIndicatorTheme.of(context).circularTrackColor;

    return Container(
      constraints: const BoxConstraints(
        minWidth: _kMinCircularProgressIndicatorSize,
        minHeight: _kMinCircularProgressIndicatorSize,
      ),
      child: CustomPaint(
        painter: _CircularProgressIndicatorPainter(
          backgroundColor: trackColor,
          valueColor: _getValueColor(context, defaultColor: defaults.color),
          value: widget.value,
          // may be null
          headValue: headValue,
          // remaining arguments are ignored if widget.value is not null
          tailValue: tailValue,
          offsetValue: offsetValue,
          rotationValue: rotationValue,
          strokeWidth: widget.strokeWidth,
          strokeAlign: widget.strokeAlign,
          strokeCap: widget.strokeCap,
        ),
      ),
    );
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return _buildMaterialIndicator(
          context,
          _strokeHeadTween.evaluate(_controller),
          _strokeTailTween.evaluate(_controller),
          _offsetTween.evaluate(_controller),
          _rotationTween.evaluate(_controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      return _buildMaterialIndicator(context, 0, 0.0, 0.0, 0.0);
    }
    return _buildAnimation();
  }
}

class _CircularProgressIndicatorPainter extends CustomPainter {
  _CircularProgressIndicatorPainter({
    this.backgroundColor,
    required this.valueColor,
    required this.value,
    required this.headValue,
    required this.tailValue,
    required this.offsetValue,
    required this.rotationValue,
    required this.strokeWidth,
    required this.strokeAlign,
    this.strokeCap,
  })  : arcStart = value != null
            ? _startAngle
            : _startAngle +
                tailValue * 3 / 2 * math.pi +
                rotationValue * math.pi * 2.0 +
                offsetValue * 0.5 * math.pi,
        arcSweep = value != null
            ? clampDouble(value, 0.0, 1.0) * _sweep
            : math.max(
                headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi,
                _epsilon);

  final Color? backgroundColor;
  final Color valueColor;
  final double? value;
  final double headValue;
  final double tailValue;
  final double offsetValue;
  final double rotationValue;
  final double strokeWidth;
  final double strokeAlign;
  final double arcStart;
  final double arcSweep;
  final StrokeCap? strokeCap;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;

  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Use the negative operator as intended to keep the exposed constant value
    // as users are already familiar with.
    final double strokeOffset = strokeWidth / 2 * -strokeAlign;
    final Offset arcBaseOffset = Offset(strokeOffset, strokeOffset);
    final Size arcActualSize = Size(
      size.width - strokeOffset * 2,
      size.height - strokeOffset * 2,
    );

    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
        arcBaseOffset & arcActualSize,
        0,
        _sweep,
        false,
        backgroundPaint,
      );
    }

    if (value == null && strokeCap == null) {
      // Indeterminate
      paint.strokeCap = StrokeCap.square;
    } else {
      // Butt when determinate (value != null) && strokeCap == null;
      paint.strokeCap = strokeCap ?? StrokeCap.butt;
    }

    canvas.drawArc(
      arcBaseOffset & arcActualSize,
      arcStart,
      arcSweep,
      false,
      paint,
    );

    // final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    // final gradient = SweepGradient(
    //   center: Alignment(0, -1.2),
    //   startAngle: arcStart,
    //   endAngle: _sweep,
    //   colors: [
    //     valueColor,
    //     backgroundColor ?? Colors.white,
    //   ],
    //   stops: [0.4, 0.5],
    //   transform: GradientRotation(arcSweep),
    // );
    // final Paint paint = Paint()
    //   ..shader = gradient.createShader(rect)
    //   ..strokeWidth = strokeWidth
    //   ..style = PaintingStyle.stroke;
    //
    // // Use the negative operator as intended to keep the exposed constant value
    // // as users are already familiar with.
    // final double strokeOffset = strokeWidth / 2 * -strokeAlign;
    // final Offset arcBaseOffset = Offset(strokeOffset, strokeOffset);
    // final Size arcActualSize = Size(
    //   size.width - strokeOffset * 2,
    //   size.height - strokeOffset * 2,
    // );
    //
    // if (backgroundColor != null) {
    //   final Paint backgroundPaint = Paint()
    //     ..color = backgroundColor!
    //     ..strokeWidth = strokeWidth
    //     ..style = PaintingStyle.stroke;
    //   canvas.drawArc(
    //     arcBaseOffset & arcActualSize,
    //     0,
    //     _sweep,
    //     false,
    //     backgroundPaint,
    //   );
    // }
    //
    // if (value == null && strokeCap == null) {
    //   // Indeterminate
    //   paint.strokeCap = StrokeCap.butt;
    // } else {
    //   // Butt when determinate (value != null) && strokeCap == null;
    //   paint.strokeCap = strokeCap ?? StrokeCap.butt;
    // }
    //
    // canvas.drawArc(
    //   arcBaseOffset & arcActualSize,
    //   arcStart,
    //   arcSweep,
    //   false,
    //   paint,
    // );
  }

  @override
  bool shouldRepaint(_CircularProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor
        || oldPainter.valueColor != valueColor
        || oldPainter.value != value
        || oldPainter.headValue != headValue
        || oldPainter.tailValue != tailValue
        || oldPainter.offsetValue != offsetValue
        || oldPainter.rotationValue != rotationValue
        || oldPainter.strokeWidth != strokeWidth
        || oldPainter.strokeAlign != strokeAlign
        || oldPainter.strokeCap != strokeCap;
  }
}
