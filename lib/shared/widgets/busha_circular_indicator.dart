import 'package:flutter/material.dart';
import 'dart:math' as math;

class GradientCircularProgressIndicator extends StatefulWidget {
  final double strokeWidth;
  final List<Color> colors;
  final double? value;

  const GradientCircularProgressIndicator({
    super.key,
    required this.strokeWidth,
    required this.colors,
    this.value,
  });

  @override
  State<GradientCircularProgressIndicator> createState() =>
      _ContinuousGradientCircularProgressIndicatorState();
}

class _ContinuousGradientCircularProgressIndicatorState
    extends State<GradientCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildIndicator(double value, double startAngle) {
    return CustomPaint(
      size: Size.square(widget.strokeWidth * 8),
      painter: _GradientCircularProgressPainter(
        strokeWidth: widget.strokeWidth,
        value: value,
        colors: widget.colors,
        startAngle: startAngle,
      ),
    );
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _buildIndicator(
          _controller.value,
          _controller.value * 2 * math.pi,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      return _buildIndicator(widget.value!, -math.pi / 2);
    }
    return _buildAnimation();
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  final double strokeWidth;
  final double? value;
  final List<Color> colors;
  final double startAngle;

  _GradientCircularProgressPainter({
    required this.strokeWidth,
    required this.value,
    required this.colors,
    required this.startAngle,
  });

  double get _startAngle => startAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = SweepGradient(
      startAngle: _startAngle,
      endAngle: (math.pi * 2),
      colors: colors,
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = size.width / 2;
    final radius = center - strokeWidth / 2;

    final sweepAngle = value != null ? value! * 2 * math.pi : math.pi * 2;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(center, center), radius: radius),
      _startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.value != value ||
        oldDelegate.colors != colors ||
        oldDelegate.startAngle != startAngle;
  }
}
