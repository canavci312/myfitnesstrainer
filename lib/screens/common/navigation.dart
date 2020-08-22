import 'package:flutter/material.dart';

class NavigationFromLeft extends PageRouteBuilder {
  Widget widget;
  NavigationFromLeft(this.widget)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
