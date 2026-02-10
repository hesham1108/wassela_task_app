library;

import 'package:flutter/material.dart';

/// =========================
/// 🔹 Base Dashed Painter
/// =========================
class _DashedLinePainter extends CustomPainter {
  final Path path;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  _DashedLinePainter({
    required this.path,
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        final extractedPath = metric.extractPath(
          distance,
          next.clamp(0, metric.length),
        );
        canvas.drawPath(extractedPath, paint);
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.path != path;
  }
}

/// =========================
/// 🔹 Custom Dashed Path
/// =========================
class DashedLine extends StatelessWidget {
  final Path path;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  const DashedLine({
    super.key,
    required this.path,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.dashWidth = 5,
    this.dashGap = 3,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(
        path: path,
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashGap: dashGap,
      ),
      size: Size.infinite,
    );
  }
}

/// =========================
/// 🔹 Simple Horizontal/Vertical Line
/// =========================
class SimpleDashedLine extends StatelessWidget {
  final Axis axis;
  final double length;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final double start;
  const SimpleDashedLine({
    super.key,
    this.axis = Axis.horizontal,
    required this.length,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.dashWidth = 5,
    this.dashGap = 3,
    this.start = 0,
  });

  @override
  Widget build(BuildContext context) {
    final path = Path();
    if (axis == Axis.horizontal) {
      path.moveTo(start, 0);
      path.lineTo(length, 0);
    } else {
      path.moveTo(0, 0);
      path.lineTo(0, length);
    }

    return SizedBox(
      width: axis == Axis.horizontal ? length : strokeWidth,
      height: axis == Axis.vertical ? length : strokeWidth,
      child: CustomPaint(
        painter: _DashedLinePainter(
          path: path,
          color: color,
          strokeWidth: strokeWidth,
          dashWidth: dashWidth,
          dashGap: dashGap,
        ),
      ),
    );
  }
}

/// =========================
/// 🔹 Dashed Circle
/// =========================
class DashedCircle extends StatelessWidget {
  final double radius;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  const DashedCircle({
    super.key,
    required this.radius,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.dashWidth = 5,
    this.dashGap = 3,
  });

  @override
  Widget build(BuildContext context) {
    final path = Path()
      ..addOval(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      );

    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: CustomPaint(
        painter: _DashedLinePainter(
          path: path,
          color: color,
          strokeWidth: strokeWidth,
          dashWidth: dashWidth,
          dashGap: dashGap,
        ),
      ),
    );
  }
}

/// =========================
/// 🔹 Dashed Arc
/// =========================
class DashedArc extends StatelessWidget {
  final double radius;
  final double startAngle; // in radians
  final double sweepAngle; // in radians
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;

  const DashedArc({
    super.key,
    required this.radius,
    required this.startAngle,
    required this.sweepAngle,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.dashWidth = 5,
    this.dashGap = 3,
  });

  @override
  Widget build(BuildContext context) {
    final rect = Rect.fromCircle(
      center: Offset(radius, radius),
      radius: radius,
    );
    final path = Path()..addArc(rect, startAngle, sweepAngle);

    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: CustomPaint(
        painter: _DashedLinePainter(
          path: path,
          color: color,
          strokeWidth: strokeWidth,
          dashWidth: dashWidth,
          dashGap: dashGap,
        ),
      ),
    );
  }
}

/// =========================
/// 🔹 Dashed Border
/// =========================
enum DashedBorderShape { rectangle, circle, roundedRect }

class DashedBorder extends StatelessWidget {
  final Widget child;
  final DashedBorderShape shape;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final double borderRadius; // for roundedRect
  final EdgeInsets padding;

  const DashedBorder({
    super.key,
    required this.child,
    this.shape = DashedBorderShape.rectangle,
    this.color = Colors.black,
    this.strokeWidth = 2,
    this.dashWidth = 6,
    this.dashGap = 3,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        shape: shape,
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashGap: dashGap,
        borderRadius: borderRadius,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final DashedBorderShape shape;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashGap;
  final double borderRadius;

  _DashedBorderPainter({
    required this.shape,
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashGap,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Path path;
    switch (shape) {
      case DashedBorderShape.rectangle:
        path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
        break;
      case DashedBorderShape.circle:
        final radius = size.shortestSide / 2;
        path = Path()
          ..addOval(
            Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
          );
        break;
      case DashedBorderShape.roundedRect:
        path = Path()
          ..addRRect(

            RRect.fromRectAndRadius(
              Rect.fromLTWH(0, 0, size.width, size.height),
              Radius.circular(borderRadius),
            ),
          );
        break;
    }

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        final extractedPath = metric.extractPath(
          distance,
          next.clamp(0, metric.length),
        );
        canvas.drawPath(extractedPath, paint);
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.shape != shape ||
        oldDelegate.borderRadius != borderRadius;
  }
}
