import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/models/workout.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/screens/trainer/add_workoutplan_description.dart';
import 'package:myfitnesstrainer/screens/trainer/edit_workout.dart';
import 'package:myfitnesstrainer/screens/trainer/workoutday_tile.dart';
import 'package:myfitnesstrainer/viewmodel/create_workout_planviewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';

enum Mode { EDITING, NEW, ASSIGNING }

class CreateWorkoutPlanPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Mode _state;

  WorkoutPlan workoutPlan;
  StudentData studentData;
  CreateWorkoutPlanPage({this.workoutPlan, this.studentData}) {
    if (workoutPlan == null)
      _state = Mode.NEW;
    else {
      if (studentData == null)
        _state = Mode.EDITING;
      else
        _state = Mode.ASSIGNING;
    }
  }
  bool isExec = false;
  TextEditingController _editingController;

  @override
  // ignore: must_call_super

  // ignore: must_call_super

  Widget _editTitleTextField(CreateWorkoutPlanModel createWorkoutPlanModel) {
    if (!isExec) {
      _editingController =
          TextEditingController(text: createWorkoutPlanModel.name);
    }
    isExec = true;
    if (createWorkoutPlanModel.state == EditState.Idle)
      return Center(
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          showCursor: true,
          cursorColor: Colors.black,
          decoration: InputDecoration(hintText: "Program ismi"),
          onChanged: (newValue) {
            createWorkoutPlanModel.updateName(newValue.toString());
          },
          validator: (value) {
            if (value.length < 1) return "Antrenman adı giriniz";
            if (value.length > 30)
              return "Antrenman adı çok uzun";
            else
              return null;
          },
          autofocus: false,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          createWorkoutPlanModel.editStarted();
        },
        child: Text(
          createWorkoutPlanModel.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }

  handleDismiss(CreateWorkoutPlanModel createWorkoutPlanModel, Workout workout,
      int index) {
    // Get a reference to the swiped item
    Workout copy = workout;
    // Remove it from the list
    createWorkoutPlanModel.removeWorkout(workout);

    _scaffoldKey.currentState
        .showSnackBar(
          SnackBar(
            content: Text("Silindi. Geri almak ister misiniz?"),
            duration: Duration(seconds: 5),
            action: SnackBarAction(
                label: "Geri Al",
                textColor: Colors.yellow,
                onPressed: () {
                  // Deep copy the email

                  // Insert it at swiped position and set state
                  createWorkoutPlanModel.addWorkoutIndex(copy, index);
                }),
          ),
        )
        .closed
        .then((reason) {
      if (reason != SnackBarClosedReason.action) {
        // The SnackBar was dismissed by some other means
        // that's not clicking of action button
        // Make API call to backend

      }
    });
  }

  Widget build(BuildContext context) {
    TrainerDataModel trainerDataModel = locator<TrainerDataModel>();
    return ChangeNotifierProvider(
        create: (context) => CreateWorkoutPlanModel(workoutPlan: workoutPlan),
        child: Consumer<CreateWorkoutPlanModel>(
            builder: (context, createWorkoutPlanModel, child) {
          if (createWorkoutPlanModel.loadState == LoadState.Idle)
            return Form(
              key: _formKey,
              autovalidate: false,
              child: Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    title: _editTitleTextField(createWorkoutPlanModel),
                    actions: <Widget>[
                      createWorkoutPlanModel.state == EditState.Editing
                          ? Text("")
                          : IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  //      createWorkoutPlanModel.workoutPlan.creator =
                                  //          userModel.user;

                                  createWorkoutPlanModel.loadState =
                                      LoadState.Loading;
                                  if (_state == Mode.NEW) {
                                    createWorkoutPlanModel
                                            .workoutPlan.workouts =
                                        createWorkoutPlanModel.workouts;

                                    trainerDataModel.addWorkout(
                                        createWorkoutPlanModel.workoutPlan);
                                    Navigator.pop(context);
                                  } else if (_state == Mode.EDITING) {
                                    createWorkoutPlanModel
                                            .workoutPlan.workouts =
                                        createWorkoutPlanModel.workouts;

                                    trainerDataModel.updateWorkout(
                                        createWorkoutPlanModel.workoutPlan);
                                    Navigator.pop(context);
                                  } else {
                                    trainerDataModel.assignWorkoutPlan(
                                        workoutPlan, studentData);
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                  }
                                  //                     createWorkoutPlanModel.saveWorkoutPlan();
                                }
                              },
                            )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            itemCount: createWorkoutPlanModel.dayCount,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final workout =
                                  createWorkoutPlanModel.workouts[index];
                              return GestureDetector(
                                onTap: () {
                                  workout.getRest == false
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditWorkout(
                                                  workout,
                                                  createWorkoutPlanModel)),
                                        )
                                      : print("rest day");
                                },
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
                                    onDismissed: (DismissDirection direction) {
                                      handleDismiss(createWorkoutPlanModel,
                                          workout, index);
                                    },
                                    /*handleDismiss(
                                    createWorkoutPlanModel,
                                    workout,
                                    index,
                                  ),*/

                                    /*      (direction) {
                                    createWorkoutPlanModel.removeWorkout(workout);
                                  },*/
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                            fit: FlexFit.tight,
                                            flex: 1,
                                            child: Center(
                                              child: Text(" " +
                                                  (index + 1).toString() +
                                                  ".\nGün"),
                                            )),
                                        WorkoutDayTile(
                                            workout.name, workout.rest),
                                      ],
                                    )),
                              );
                            }),
                        GestureDetector(
                          onTap: createWorkoutPlanModel.addWorkout,
                          child: Card(
                            child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text("Gün ekle")),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddWorkoutPlanDescription(
                                          createWorkoutPlanModel)),
                            );
                          },
                          child: Card(
                            child: createWorkoutPlanModel
                                        .workoutPlan.description ==
                                    null
                                ? ListTile(
                                    leading: Icon(Icons.add),
                                    title: Text("Antrenman Açıklaması Ekle"))
                                : ListTile(
                                    leading: Icon(Icons.edit),
                                    title:
                                        Text("Antrenman Açıklamasını Düzenle")),
                          ),
                        ),
                        /*              GestureDetector(
                          onTap: createWorkoutPlanModel.addRest,
                          child: Card(
                            child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text("Dinlenme günü ekle")),
                          ),
                        )*/
                      ],
                    ),
                  )),
            );
          else
            return LoadingScreen();
        }));
  }
}
