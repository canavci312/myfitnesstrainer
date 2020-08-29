import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/models/rest_timer.dart';

class RestTimerViewModel extends ChangeNotifier {
  Duration duration;
  RestTimerViewModel(this.duration) {
    RestTimer _restTimer = RestTimer(duration);
  }
}
