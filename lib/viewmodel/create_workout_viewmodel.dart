import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/models/exercise_targets.dart';
import 'package:myfitnesstrainer/models/workout.dart';
import 'package:myfitnesstrainer/services/sqflite_services.dart';

enum EditViewState { Idle, Editing }

class CreateWorkoutViewModel with ChangeNotifier {
  Workout workout;
  CreateWorkoutViewModel(this.workout);
  EditViewState _state = EditViewState.Idle;
  EditViewState get state => _state;
  DatabaseHelper _databaseHelper = locator<DatabaseHelper>();

  int get exerciseCount {
    return workout.exerciseTargetsList.length;
  }

  Future<Exercise> getExercise(int id) async {
    Exercise exercise;
    exercise = await _databaseHelper.getExercise(id);
    return exercise;
  }

  void updateName(String name) {
    workout.setName = name;
    state = EditViewState.Idle;
    notifyListeners();
  }

  void editStarted() {
    state = EditViewState.Editing;
    notifyListeners();
  }

  void addExercise(ExerciseTargets exerciseTargets) {
    workout.exerciseTargetsList.add(exerciseTargets);
    notifyListeners();
  }

  void toogleRepBased(ExerciseTargets exerciseTargets) {
    exerciseTargets.repBased = !exerciseTargets.repBased;
    notifyListeners();
  }

  void changeExerciseSet(ExerciseTargets exerciseTargets, int value) {
    exerciseTargets.setCount = value;
  }

  void changeExerciseDuration(ExerciseTargets exerciseTargets, int value) {
    exerciseTargets.duration = value;
  }

  void changeExerciseRest(ExerciseTargets exerciseTargets, int value) {
    exerciseTargets.rest = value;
  }

  void changeExerciseMinRep(ExerciseTargets exerciseTargets, int value) {
    exerciseTargets.minRep = value;
  }

  void changeExerciseMaxRep(ExerciseTargets exerciseTargets, int value) {
    exerciseTargets.maxRep = value;
  }

  void updateExercise(
      ExerciseTargets exerciseTargets, ExerciseTargets newExerciseTargets) {
    if (workout.exerciseTargetsList.contains(exerciseTargets))
      exerciseTargets = newExerciseTargets;
    else
      print("öyle bir exercise target yok");
    notifyListeners();
  }

  void removeExercise(ExerciseTargets exerciseTargets) {
    workout.exerciseTargetsList.remove(exerciseTargets);
    notifyListeners();
  }

  set state(EditViewState value) {
    _state = value;
    notifyListeners();
  }
}
