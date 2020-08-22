import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/services/sqflite_services.dart';

enum ViewState { Idle, Busy }

class ExerciseViewModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  DatabaseHelper _databaseHelper = locator<DatabaseHelper>();
  List<Exercise> checkedList = new List<Exercise>();
  List<Exercise> allExercises = new List<Exercise>();
  List<Exercise> filteredExercises = new List<Exercise>();

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  void filterEquipment(String equipment) {
    filteredExercises =    filteredExercises = filteredExercises
          .where((element) => element.equipment == "Body Only");
    if (equipment == "Vücut Ağırlığı")
      filteredExercises = filteredExercises
          .where((element) => element.equipment == "Body Only");

  }

  void filterMainMuscle(String mainMuscle) {}
  void filterType(String type) {}
  Future<List<Exercise>> loadExercises() async {
    if (allExercises.isEmpty) {
      print("burdayım");

      allExercises = await _databaseHelper.loadExercises();
    }
    filteredExercises = allExercises;
    return allExercises;
  }
}
