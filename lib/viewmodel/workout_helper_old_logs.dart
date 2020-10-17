import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/models/exercise_logs.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';

enum DataReady { Ready, Busy }

class WorkoutHelperOldLogsViewModel with ChangeNotifier {
  final Exercise _exercise;
  DataReady _state = DataReady.Busy;

  AllWorkoutLogsModel _allWorkoutLogsModel = locator<AllWorkoutLogsModel>();
  List<DateTime> dates = [];
  List<ExerciseLogs> exerciseLogsList = [];
  WorkoutHelperOldLogsViewModel(this._exercise) {
    prepareData();
  }
  DataReady get state => _state;

  set state(DataReady value) {
    _state = value;
    notifyListeners();
  }
  void selectedDate(){
    
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
            _exercise.name) {
          dates.add(_allWorkoutLogsModel.allWorkoutLogs.workoutLogs[i].date);
          exerciseLogsList.add(_allWorkoutLogsModel
              .allWorkoutLogs.workoutLogs[i].exerciseLogs[j]);
        }
      }
    }

    state = DataReady.Ready;
  }
}
