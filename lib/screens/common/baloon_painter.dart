import 'package:flutter/material.dart';
import 'dart:math';
enum BalloonDirection {left, right}

class BalloonPainter extends CustomPainter {
  final double radius;
  final Size tipSize;
  final bool tipVisible;
  final Paint stroke, fill;
  final BalloonDirection direction;

  // Default values
  // BalloonPainter(this.direction, {
  //   this.radius: 10,
  //   this.tipSize: const Size(10, 10),
  //   stroke, fill
  // }) : stroke = stroke ?? Paint()..color = Colors.grey,
  //      fill = fill ?? Paint()..color = Colors.white;

  BalloonPainter(
    this.direction,
    this.radius, this.tipSize, this.tipVisible,
    this.stroke, this.fill);
  //: assert(direction != null), ...;

  @override
  void paint(Canvas canvas, Size size) {
    if (tipVisible) {
      var oval = Size.fromRadius(radius);
      var path = Path();
      if (direction == BalloonDirection.left) path
        ..addArc(((size - oval) as Offset) & oval, 0.0, pi/2)
        ..arcTo(Offset(tipSize.width, size.height - oval.height) & oval, pi/2, pi/2, false)
        ..lineTo(0.0, size.height - oval.height - tipSize.height/2)
        ..lineTo(tipSize.width, size.height - oval.height - tipSize.height)
        ..arcTo(Offset(tipSize.width, 0) & oval, pi, pi/2, false)
        ..arcTo(Offset(size.width - oval.width, 0) & oval, 3*pi/2, pi/2, false)
        ..close();
      else path
        ..addArc(((size - (oval + Offset(tipSize.width, 0))) as Offset) & oval, 0, pi/2)
        ..arcTo(Offset(0, size.height - oval.height) & oval, pi/2, pi/2, false)
        ..arcTo(Offset.zero & oval, pi, pi/2, false)
        ..arcTo(Offset(size.width - oval.width - tipSize.width, 0) & oval, 3*pi/2, pi/2, false)
        ..lineTo(size.width - tipSize.width, size.height - oval.height - tipSize.height)
        ..lineTo(size.width, size.height - oval.height - tipSize.height/2)
        ..close();
      canvas.drawPath(path, fill..style = PaintingStyle.fill);
      canvas.drawPath(path, stroke..style = PaintingStyle.stroke);
    } else {
      var r = Radius.circular(radius);
      var rect = direction == BalloonDirection.left
        ? RRect.fromLTRBR(tipSize.width, 0, size.width, size.height, r)
        : RRect.fromLTRBR(0, 0, size.width - tipSize.width, size.height, r);
      canvas.drawRRect(rect, fill..style = PaintingStyle.fill);
      canvas.drawRRect(rect, stroke..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}