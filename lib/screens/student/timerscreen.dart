import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:myfitnesstrainer/models/exercise_targets.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer _timer;
  int _value = 0;
  int _start = 5;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            startTimer2();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void startTimer2() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _value = _value + 1;
        },
      ),
    );
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _start != 0
        ? AlertDialog(
            title: Text(
              "Hazırlanın!",
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            content: Text(
              '$_start',
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Hazır değilim'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          )
        : AlertDialog(
            title: Text(
              "başladı!",
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            content: Text(
              '$_value',
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Tamamla'),
                onPressed: () {
                  Navigator.of(context).pop(_value);
                },
              )
            ],
          );
  }
}
