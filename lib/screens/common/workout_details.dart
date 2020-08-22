import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';
import 'package:expandable/expandable.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:provider/provider.dart';

import '../trainer/create_workout_plan.dart';
import 'navigation.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final WorkoutPlan _workoutPlan;
  WorkoutDetailsPage(this._workoutPlan);

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainerDataModel>(
        builder: (context, workoutPlansListViewModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_workoutPlan.name.toUpperCase()),
          actions: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                workoutPlansListViewModel.removeWorkout(_workoutPlan);
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(NavigationFromLeft((CreateWorkoutPlanPage(workoutPlan: _workoutPlan,))));
                
              },
            )
          ],
        ),
        /*   floatingActionButton: FloatingActionButton(child:Icon(Icons.fitness_center), onPressed: () {
                Navigator.of(context).push(NavigationFromLeft(WorkoutHelper(_workout)));

      }),*/

        body: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/5x5workout.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Özet",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _workoutPlan.workouts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _workoutPlan.workouts[index].rest
                        ? Card(
                            margin: EdgeInsets.all(10.0),
                            child: ListTile(
                                leading: Icon(Icons.airline_seat_flat),
                                title: Text("Dinlenme günü")))
                        : Card(
                            margin: EdgeInsets.all(10.0),
                            child: ListTile(
                              leading: Icon(Icons.fitness_center),
                              title: ExpandablePanel(
                                header: Text(_workoutPlan.workouts[index].name),
                                collapsed: Text(
                                  _workoutPlan.workouts[index].exerciseTargetsList
                                          .length
                                          .toString() +
                                      " adet egzersiz",
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                expanded: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _workoutPlan.workouts[index]
                                        .exerciseTargetsList.length,
                                    itemBuilder:
                                        (BuildContext context, int index2) {
                                      return ListTile(
                                          title: Text(_workoutPlan
                                              .workouts[index]
                                              .exerciseTargetsList[index2]
                                              .exercise
                                              .name),
                                          subtitle: Text(_workoutPlan
                                              .workouts[index]
                                              .exerciseTargetsList[index2]
                                              .toString()));
                                    }),
                              ),
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
