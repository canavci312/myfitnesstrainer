import 'package:myfitnesstrainer/models/workout_logslist.dart';

class AllWorkoutLogs {
  List<WorkoutLogsList> workoutLogsList;

  AllWorkoutLogs() {
    workoutLogsList = [];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['workoutLogsList'] = firestorWorkoutLogs();

    return map;
  }

  AllWorkoutLogs.fromMap(Map<String, dynamic> map) {
    var list = map['workoutLogsList'] as List;
    List<WorkoutLogsList> workoutLogsList1 =
        list.map((i) => WorkoutLogsList.fromMap(i)).toList();
    this.workoutLogsList = workoutLogsList1;
  }

  firestorWorkoutLogs() {
    List<Map<String, dynamic>> convertedWorkoutLogsList = [];
    if (workoutLogsList != null)
      this.workoutLogsList.forEach((element) {
        WorkoutLogsList thisWorkoutLogs = element;
        convertedWorkoutLogsList.add(thisWorkoutLogs.toMap());
      });
    return convertedWorkoutLogsList;
  }
}
