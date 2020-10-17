import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/models/set_logs.dart';

class ExerciseLogs {
  String exerciseName;
  List<SetLogs> setLogs;
  ExerciseLogs({this.exerciseName, this.setLogs});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['exerciseName'] = exerciseName;
    map['setLogs'] = firestoreSetLogs();

    return map;
  }

  ExerciseLogs.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      this.exerciseName = map['exerciseName'];
      var list = map['setLogs'] as List;
      List<SetLogs> setLogsList = list.map((i) => SetLogs.fromMap(i)).toList();
      this.setLogs = setLogsList;
    }
  }

  firestoreSetLogs() {
    List<Map<String, dynamic>> convertedSetLogsList = [];
    if (setLogs != null)
      this.setLogs.forEach((element) {
        SetLogs thisSetLogs = element;
        convertedSetLogsList.add(thisSetLogs.toMap());
      });
    return convertedSetLogsList;
  }
}
