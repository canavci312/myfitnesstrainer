import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/viewmodel/exercice_checkbox_viewmodel.dart';

class CurrentlyAddedExercises extends StatelessWidget {
  ExerciseCheckboxViewModel _exerciseCheckboxViewModel;
  CurrentlyAddedExercises(this._exerciseCheckboxViewModel);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _exerciseCheckboxViewModel.checkedList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              
              title: Text(_exerciseCheckboxViewModel.checkedList[index].name),
            );
          },
        ),
      ),
    );
  }
}
