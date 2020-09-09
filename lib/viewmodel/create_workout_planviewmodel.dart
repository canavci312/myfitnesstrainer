import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/models/exercise_targets.dart';
import 'package:myfitnesstrainer/models/workout.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';

import '../models/workout_plan.dart';

enum EditState { Idle, Editing }
enum LoadState { Idle, Loading }

class CreateWorkoutPlanModel with ChangeNotifier {
  List<Workout> workouts;
  WorkoutPlan workoutPlan;
  CreateWorkoutPlanModel({this.workoutPlan}) {
    if (workoutPlan == null) {
      workoutPlan = WorkoutPlan(name: "Programı isimlendirin");
      workouts = [];
    } else {
      workouts = workoutPlan.workouts;
      this.workoutPlan = workoutPlan;
    }
  }

  EditState _state = EditState.Idle;
  LoadState _loadState = LoadState.Idle;

  EditState get state => _state;

  void updateName(String name) {
    workoutPlan.setName = name;
    state = EditState.Idle;
    notifyListeners();
  }

  void editStarted() {
    state = EditState.Editing;
    notifyListeners();
  }

  LoadState get loadState => _loadState;

  set loadState(LoadState value) {
    _loadState = value;
    notifyListeners();
  }

  set state(EditState value) {
    _state = value;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  /*Future<void> saveWorkoutPlan() async {
    await _firestoreDBService.saveWorkout(_workoutPlan);
  }
*/
  void addWorkoutIndex(Workout workout, int index) {
    try {
      workouts.insert(index, workout);
    } catch (e) {
      workouts.add(workout);
    } finally {
      workoutPlan.setWorkout = workouts;

      notifyListeners();
    }
  }

  void addWorkout() {
    workouts.add(new Workout(
        id: (workouts.length - 1).toString(),
        exerciseTargetsList: <ExerciseTargets>[],
        rest: false,
        name: "Boş Antrenman Günü"));
    workoutPlan.setWorkout = workouts;

    notifyListeners();
  }

  List<Workout> get _workouts {
    return workouts;
  }

  WorkoutPlan get _workoutPlan {
    return workoutPlan;
  }

  void addRest() {
    _workouts.add(new Workout(
        id: (_workouts.length - 1).toString(),
        exerciseTargetsList: null,
        rest: true,
        name: "Dinlenme Günü"));
    _workoutPlan.setWorkout = _workouts;

    notifyListeners();
  }

  void removeWorkout(Workout workout) {
    _workouts.remove(workout);
    _workoutPlan.setWorkout = _workouts;

    notifyListeners();
  }

  int get dayCount {
    return _workouts.length;
  }

  String get name {
    return _workoutPlan.name;
  }

  void saveDescription(String value) {
    workoutPlan.description = value;
    print(workoutPlan.description);
    notifyListeners();
  }
}
