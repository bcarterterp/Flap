import 'package:flutter/material.dart';

class CreditScoreBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 5
      ..color = const Color.fromARGB(255, 250, 250, 250)
      ..style = PaintingStyle.fill;

    const leftEdge = 10.0;
    final rightEdge = size.width - leftEdge;
    const top = 100.0;
    const bottom = 415.0;
    const cornerRadius = 22;
    const radiusWeight = 1.0;

    double arcFrom = size.width - 60;
    double arcTo = 60;

    if (size.width > 500) {
      arcFrom = size.width * 0.65;
      arcTo = size.width * 0.35;
    }

    final path = Path()
      ..moveTo(leftEdge, bottom)
      ..lineTo(rightEdge - cornerRadius, bottom)
      ..conicTo(
          rightEdge, bottom, rightEdge, bottom - cornerRadius, radiusWeight)
      ..lineTo(rightEdge, top + cornerRadius)
      ..conicTo(rightEdge, top, rightEdge - cornerRadius, top, radiusWeight)
      ..lineTo(arcFrom, top)
      ..arcToPoint(Offset(arcTo, top + (bottom * 0.3)),
          radius: const Radius.circular(2), largeArc: true, clockwise: false)
      ..lineTo(arcTo, top)
      ..lineTo(leftEdge + cornerRadius, top)
      ..conicTo(leftEdge, top, leftEdge, top + cornerRadius, radiusWeight)
      ..lineTo(leftEdge, bottom - cornerRadius)
      ..conicTo(leftEdge, bottom, leftEdge + cornerRadius, bottom, radiusWeight)
      ..close;

    canvas.drawShadow(path, const Color.fromARGB(96, 109, 109, 109), 8, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
