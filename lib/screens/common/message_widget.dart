import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/common/baloon_painter.dart';

enum MessageOwner {me, other}

class MessageWidget extends StatelessWidget {
  final Widget content;
  final MessageOwner owner;
  /// Consecutive messages from the same person form a message group. One
  /// message from a message group is chosen as the holder of that group and
  /// represented differently. The holder is typically the first or last
  /// message and painted as a speech balloon, while the other messages are
  /// painted as rounded rectangles.
  final bool holder;
  final Animation<double> animation;
  MessageWidget(this.content, this.owner, this.holder, this.animation);

  static final Paint
    meStroke = Paint()..color = Colors.green,
    meFill = Paint()..color = Colors.lightGreen,
    otherStroke = Paint()..color = Colors.grey,
    otherFill = Paint()..color = Colors.white;

  static final double radius = 10;
  static final Size tipSize = Size(10, 10);

  @override
  Widget build(BuildContext context) {
    bool mine = owner == MessageOwner.me;
    return FadeTransition(
      opacity: animation,
      child: CustomPaint(
        painter: BalloonPainter(
          mine ? BalloonDirection.right : BalloonDirection.left,
          radius, tipSize, holder,
          mine ? meStroke : otherStroke,
          mine ? meFill : otherFill
        ),
        child: Padding(
          padding: EdgeInsets.all(radius) + (mine
            ? EdgeInsets.only(right: tipSize.width)
            : EdgeInsets.only(left: tipSize.width)),
          child: content
        ),
        isComplex: false,
        willChange: false
      ));
  }
}