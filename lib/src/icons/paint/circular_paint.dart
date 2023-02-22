import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularPaint extends CustomPainter {
  CircularPaint({
    this.rate = 50,
    this.strokeWidth = 3.0,
    this.color = const Color(0xFF9E9E9E),
    this.fillColor = const Color(0xFF4CAF50),
  });
  final double rate;
  final double strokeWidth;
  final Color color;
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..color = this.fillColor
      ..strokeWidth = this.strokeWidth
      ..style = PaintingStyle.stroke;

    Paint arc = Paint()
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..color = this.color
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius =
        math.min(size.width / 2, size.height / 2) - this.strokeWidth;

    canvas.drawCircle(center, radius, circle);

    double angle = 2 * math.pi * ((100 - this.rate) / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      radius,
      angle,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) {
    return true;
  }
}
