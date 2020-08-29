import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/models/exercise_logs.dart';
import 'package:myfitnesstrainer/models/set_logs.dart';

class ExerciseLogsViewModel with ChangeNotifier {
  ExerciseLogsViewModel();
  ExerciseLogs exerciseLogs =ExerciseLogs();
  List<SetLogs> setLogs;
}
