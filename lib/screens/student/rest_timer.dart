import 'package:flutter/material.dart';
import 'dart:math' as math;

class RestTimerUI extends StatefulWidget {
  @override
  RestTimerUIState createState() => RestTimerUIState();
}

class RestTimerUIState extends State<RestTimerUI>
    with TickerProviderStateMixin {
  AnimationController controller;

  // bool isPlaying = false;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    // ..addStatusListener((status) {
    //     if (controller.status == AnimationStatus.dismissed) {
    //       setState(() => isPlaying = false);
    //     }

    //     print(status);
    //   })
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: FractionalOffset.center,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget child) {
                          return CustomPaint(
                              painter: TimerPainter(
                            animation: controller,
                            backgroundColor: Colors.white,
                            color: themeData.indicatorColor,
                          ));
                        },
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Count Down",
                            style: themeData.textTheme.subtitle1,
                          ),
                          AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget child) {
                                return Text(
                                  timerString,
                                  style: themeData.textTheme.headline1,
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget child) {
                      return Icon(controller.isAnimating
                          ? Icons.pause
                          : Icons.play_arrow);

                      // Icon(isPlaying
                      // ? Icons.pause
                      // : Icons.play_arrow);
                    },
                  ),
                  onPressed: () {
                    // setState(() => isPlaying = !isPlaying);

                    if (controller.isAnimating) {
                      controller.stop(canceled: true);
                    } else {
                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
