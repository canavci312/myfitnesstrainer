import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/models/exercise_logs.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';

class StudentExerciseSessionsViewModel with ChangeNotifier {
  AllWorkoutLogsModel _allWorkoutLogsModel = locator<AllWorkoutLogsModel>();
  final Exercise exercise;
  List<DateTime> dates = [];
  List<ExerciseLogs> exerciseLogsList = [];
  StudentExerciseSessionsViewModel(this.exercise) {
    prepareData();
  }
  void prepareData() {
    //add exercises to _workoutExerciseList
    for (int i = 0;
        i < _allWorkoutLogsModel.allWorkoutLogs.workoutLogs.length;
        i++) {
      for (int j = 0;
          j <
              _allWorkoutLogsModel
                  .allWorkoutLogs.workoutLogs[i].exerciseLogs.length;
          j++) {
        if (_allWorkoutLogsModel
                .allWorkoutLogs.workoutLogs[i].exerciseLogs[j].exerciseName ==
            exercise.name) {
          dates.add(_allWorkoutLogsModel.allWorkoutLogs.workoutLogs[i].date);
          exerciseLogsList.add(_allWorkoutLogsModel
              .allWorkoutLogs.workoutLogs[i].exerciseLogs[j]);
        }
      }
    }
  }
}
