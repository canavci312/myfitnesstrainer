import 'package:myfitnesstrainer/models/exercise_logs.dart';

class WorkoutLogs {
  String workoutName;

  DateTime date;
  List<ExerciseLogs> exerciseLogs;
  WorkoutLogs();
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['date'] = date;
    map['workoutName'] = workoutName;
    map['exerciseLogs'] = firestoreExerciseLogs();

    return map;
  }

  WorkoutLogs.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      this.date = (map['date'].toDate());
      this.workoutName = map['workoutName'];
      var list = map['exerciseLogs'] as List;
      List<ExerciseLogs> exerciseLogsList =
          list.map((i) => ExerciseLogs.fromMap(i)).toList();
      this.exerciseLogs = exerciseLogsList;
    }
  }

  firestoreExerciseLogs() {
    List<Map<String, dynamic>> convertedExerciseLogsList = [];
    if (exerciseLogs != null)
      this.exerciseLogs.forEach((element) {
        ExerciseLogs thisExerciseLogs = element;
        convertedExerciseLogsList.add(thisExerciseLogs.toMap());
      });
    return convertedExerciseLogsList;
  }
}
