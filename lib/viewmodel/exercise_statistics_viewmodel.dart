import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/models/exerciselog_date.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';

class ExerciseStatisticsViewModel with ChangeNotifier {
  AllWorkoutLogsModel _allWorkoutLogsModel = locator<AllWorkoutLogsModel>();
  final Exercise exercise;
  List<ExerciseLogsWithDate> exerciseLogsWithDateList = [];
  int totalReps = 0;
  int totalDuration = 0;
  int totalSets = 0;
  ExerciseLogsWithDate personalBest;
  double totalWeight = 0;
  bool durationBased = true;
  ExerciseStatisticsViewModel(this.exercise) {
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
          var currentLog = ExerciseLogsWithDate(
              _allWorkoutLogsModel
                  .allWorkoutLogs.workoutLogs[i].exerciseLogs[j],
              _allWorkoutLogsModel.allWorkoutLogs.workoutLogs[i].date);
          exerciseLogsWithDateList.add(currentLog);
          totalSets = totalSets +
              _allWorkoutLogsModel
                  .allWorkoutLogs.workoutLogs[i].exerciseLogs[j].setLogs.length;
          if (_allWorkoutLogsModel.allWorkoutLogs.workoutLogs[i].exerciseLogs[j]
                  .setLogs.first.duration ==
              null) {
            durationBased = false;
            _allWorkoutLogsModel
                .allWorkoutLogs.workoutLogs[i].exerciseLogs[j].setLogs
                .forEach((element) {
              totalReps = totalReps + element.reps;
              totalWeight = totalWeight + element.weight;
            });
          } else {
            _allWorkoutLogsModel
                .allWorkoutLogs.workoutLogs[i].exerciseLogs[j].setLogs
                .forEach((element) {
              totalDuration = totalDuration + element.duration;
              totalWeight = totalWeight + element.weight;
            });
          }
        }
      }
    }
  }
}
