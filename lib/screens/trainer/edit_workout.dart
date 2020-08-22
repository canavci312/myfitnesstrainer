import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/exercise_targets.dart';
import 'package:myfitnesstrainer/models/workout.dart';
import 'package:myfitnesstrainer/screens/trainer/exercise_selection.dart';
import 'package:myfitnesstrainer/screens/trainer/exercisetarget_tile.dart';
import 'package:myfitnesstrainer/viewmodel/create_workout_planviewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/create_workout_viewmodel.dart';
import 'package:provider/provider.dart';

class EditWorkout extends StatelessWidget {
  Workout selectedWorkout;
  CreateWorkoutPlanModel _createWorkoutPlanModel;
  EditWorkout(this.selectedWorkout, this._createWorkoutPlanModel);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _editingController;
  bool isExec = false;
  @override
  // ignore: must_call_super

  // ignore: must_call_super

  Widget _editTitleTextField(CreateWorkoutViewModel createWorkoutViewModel) {
    if (!isExec)
      _editingController = TextEditingController(text: selectedWorkout.name);
    isExec = true;
    if (createWorkoutViewModel.state == EditViewState.Idle)
      return Center(
        child: TextFormField(
          maxLength: 30,
          maxLengthEnforced: true,
          decoration: InputDecoration(
              labelText: "Antrenman adı", helperText: "Örn: Omuz Antrenmanı"),
          showCursor: true,
          onChanged: (newValue) {
            createWorkoutViewModel.updateName(newValue.toString());
            _createWorkoutPlanModel.update();
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Lütfen bir ad giriniz';
            }
            return null;
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          createWorkoutViewModel.editStarted();
        },
        child: Text(
          createWorkoutViewModel.workout.getName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CreateWorkoutViewModel(selectedWorkout),
        child: Consumer<CreateWorkoutViewModel>(
            builder: (context, createWorkoutViewModel, child) {
          return Form(
            key: _formKey,
            autovalidate: true,
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text("Antrenmanı Düzenle"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(child: _editTitleTextField(createWorkoutViewModel)),
                      ListView.builder(
                          itemCount: createWorkoutViewModel.exerciseCount,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final exerciseTargets = createWorkoutViewModel
                                .workout.exerciseTargetsList[index];
                            return GestureDetector(
                              onTap: () {},
                              child: Dismissible(
                                  key: UniqueKey(),
                                  background: Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.delete,
                                              color: Colors.white),
                                          Text('Sil',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  secondaryBackground: Container(
                                    color: Colors.red,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.delete,
                                              color: Colors.white),
                                          Text('Sil',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    createWorkoutViewModel
                                        .removeExercise(exerciseTargets);
                                  },
                                  child: ExerciseTargetTile(
                                      exerciseTargets, createWorkoutViewModel)),
                            );
                          }),
                      GestureDetector(
                        onTap: () async {
                          List<ExerciseTargets> list = [];
                          list = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ExerciseSelection()));
                          list.forEach((element) {
                            createWorkoutViewModel.addExercise(element);
                          });
                        },
                        child: Card(
                          child: ListTile(
                              leading: Icon(Icons.add),
                              title: Text("Egzersiz ekle")),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        }));
  }
}
