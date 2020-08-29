import 'package:myfitnesstrainer/models/workout.dart';
import 'package:myfitnesstrainer/models/workout_logs.dart';

class WorkoutLogsList {
  String workoutName;
  List<WorkoutLogs> workoutLogs;
  WorkoutLogsList() {
    workoutLogs = [];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['workoutName'] = workoutName;
    map['workoutLogs'] = firestoreExerciseLogs();

    return map;
  }

  WorkoutLogsList.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      this.workoutName = (map['workoutName']);

      var list = map['workoutLogs'] as List;
      if (list != null) {
        List<WorkoutLogs> workoutLogsList =
            list.map((i) => WorkoutLogs.fromMap(i)).toList();
        this.workoutLogs = workoutLogsList;
      }
    }
  }

  firestoreExerciseLogs() {
    List<Map<String, dynamic>> convertedWorkoutLogsList = [];
    if (workoutLogs != null)
      this.workoutLogs.forEach((element) {
        WorkoutLogs thisWorkoutLogs = element;
        convertedWorkoutLogsList.add(thisWorkoutLogs.toMap());
      });
    return convertedWorkoutLogsList;
  }
}
