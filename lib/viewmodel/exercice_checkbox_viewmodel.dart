import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/screens/trainer/currently%20_added_exercises.dart';
import 'package:myfitnesstrainer/services/sqflite_services.dart';

class ExerciseCheckboxViewModel with ChangeNotifier {
  DatabaseHelper _databaseHelper = locator<DatabaseHelper>();
  List<Exercise> checkedList;
  List<Exercise> allExercises;
  ExerciseCheckboxViewModel(this.allExercises, this.checkedList);
  void removeFromCheckedList(Exercise exercise) {
    if (checkedList.contains(exercise)) checkedList.remove(exercise);
    notifyListeners();
  }

  void toogleCheckList(Exercise exercise, GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context) {
    if (checkedList.contains(exercise))
      checkedList.remove(exercise);
    else
      checkedList.add(exercise);

    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Antrenmanınıza " +
            checkedList.length.toString() +
            " egzersiz eklediniz görmek için"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
            label: "tıklayın",
            textColor: Colors.yellow,
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: CurrentlyAddedExercises(this),
                      )));
            }),
      ),
    );
    notifyListeners();
  }

  void emptyCheckList() {
    checkedList = [];
    notifyListeners();
  }
}