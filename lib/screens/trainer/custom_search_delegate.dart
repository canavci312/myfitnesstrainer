import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/screens/trainer/exercise_listtile.dart';
import 'package:myfitnesstrainer/viewmodel/exercice_checkbox_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/exercises_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate<Exercise> {
  ExerciseViewModel _exerciseViewModel;

  GlobalKey<ScaffoldState> _scaffoldKey;
  var newList;
  CustomSearchDelegate(this._exerciseViewModel, this._scaffoldKey);

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: newList.length,
      itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider(
          create: (context) => ExerciseCheckboxViewModel(
              newList, _exerciseViewModel.checkedList),
          child: Consumer<ExerciseCheckboxViewModel>(
              builder: (context, exerciseCheckboxViewModel, child) {
            return ExerciseListTile(
              name: newList[index].name,
              isChecked: exerciseCheckboxViewModel.checkedList
                  .contains(newList[index]),
              checkboxCallback: (checkboxState) {
                exerciseCheckboxViewModel.toogleCheckList(
                    newList[index], _scaffoldKey, context);
              },
            );
          }),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    newList = query.isEmpty
        ? _exerciseViewModel.allExercises
        : _exerciseViewModel.allExercises
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: newList.length,
      itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider(
          create: (context) => ExerciseCheckboxViewModel(
              newList, _exerciseViewModel.checkedList),
          child: Consumer<ExerciseCheckboxViewModel>(
              builder: (context, exerciseCheckboxViewModel, child) {
            return ExerciseListTile(
              name: newList[index].name,
              isChecked: exerciseCheckboxViewModel.checkedList
                  .contains(newList[index]),
              checkboxCallback: (checkboxState) {
                exerciseCheckboxViewModel.toogleCheckList(
                    newList[index], _scaffoldKey, context);
              },
            );
          }),
        );
      },
    );
  }
}
