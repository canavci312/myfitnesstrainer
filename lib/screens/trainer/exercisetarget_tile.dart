import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnesstrainer/models/exercise_targets.dart';
import 'package:myfitnesstrainer/viewmodel/create_workout_viewmodel.dart';

enum ViewState { Idle, Busy }

class ExerciseTargetTile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  List<String> exerciseBase = ["Tekrar bazlı", "Süre bazlı"];
  CreateWorkoutViewModel _createWorkoutViewModel;
  ExerciseTargets _exerciseTargets;
  ExerciseTargetTile(this._exerciseTargets, this._createWorkoutViewModel);

  TextEditingController _setController;
  TextEditingController _restController;

  TextEditingController _minRepController;
  TextEditingController _maxRepController;
  TextEditingController _durationController;

  @override
  Widget build(BuildContext context) {
    _setController =
        TextEditingController(text: _exerciseTargets.setCount.toString());
    _restController =
        TextEditingController(text: _exerciseTargets.rest.toString());
    _minRepController =
        TextEditingController(text: _exerciseTargets.minRep.toString());
    _maxRepController =
        TextEditingController(text: _exerciseTargets.maxRep.toString());
    _durationController =
        TextEditingController(text: _exerciseTargets.duration.toString());
    return Form(
      key: _formKey,
      child: Card(
          child: ListTile(
        leading: Icon(Icons.fitness_center),
        title: Text(_exerciseTargets.exercise.name),
        subtitle: _exerciseTargets.repBased == true
            ? Row(
                children: [
                  Container(
                    width: 55,
                    child: Column(children: [
                      Text("Sets"),
                      TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _setController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(),
                        onChanged: (value) {
                          _createWorkoutViewModel.changeExerciseSet(
                              _exerciseTargets, num.tryParse(value));
                        },
                      )
                    ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 55,
                    child: Column(children: [
                      Text("Min Rep"),
                      TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _minRepController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(),
                        onChanged: (value) {
                          _createWorkoutViewModel.changeExerciseMinRep(
                              _exerciseTargets, num.tryParse(value));
                        },
                      )
                    ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 55,
                    child: Column(children: [
                      Text("Max Rep"),
                      TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _maxRepController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(),
                        onChanged: (value) {
                          _createWorkoutViewModel.changeExerciseMaxRep(
                              _exerciseTargets, num.tryParse(value));
                        },
                      )
                    ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 55,
                    child: Column(children: [
                      Text("Ara(sn)"),
                      TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _restController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(),
                        onChanged: (value) {
                          _createWorkoutViewModel.changeExerciseRest(
                              _exerciseTargets, num.tryParse(value));
                        },
                      )
                    ]),
                  ),
                ],
              )
            : Row(
                children: [
                  Container(
                    width: 55,
                    child: Column(children: [
                      Text("Sets"),
                      TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _setController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(),
                        onChanged: (value) {
                          _createWorkoutViewModel.changeExerciseSet(
                              _exerciseTargets, num.tryParse(value));
                        },
                      )
                    ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 55,
                    child: Column(children: [
                      Text("Süre(sn)"),
                      TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _durationController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(),
                        onChanged: (value) {
                          _createWorkoutViewModel.changeExerciseDuration(
                              _exerciseTargets, num.tryParse(value));
                        },
                      )
                    ]),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 55,
                    child: Column(children: [
                      Text("Ara(sn)"),
                      TextFormField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        controller: _restController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(),
                        onChanged: (value) {
                          _createWorkoutViewModel.changeExerciseRest(
                              _exerciseTargets, num.tryParse(value));
                        },
                      )
                    ]),
                  ),
                ],
              ),
        trailing: IconButton(
          icon: Icon(
            Icons.loop,
            color: Colors.blue,
          ),
          onPressed: () {
            _createWorkoutViewModel.toogleRepBased(_exerciseTargets);
          },
        ),
      )),
    );
  }
}
