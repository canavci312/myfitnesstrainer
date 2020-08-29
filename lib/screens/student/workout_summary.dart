import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/workout.dart';
import 'package:myfitnesstrainer/models/workout_logs.dart';
import 'package:myfitnesstrainer/models/workout_logslist.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';
import 'package:provider/provider.dart';

class WorkoutSummary extends StatelessWidget {
  Workout _workout;
  WorkoutLogs workoutLogs;
  WorkoutSummary(this.workoutLogs, this._workout);

  @override
  Widget build(BuildContext context) {
    final _allWorkoutLogs =
        Provider.of<AllWorkoutLogsModel>(context, listen: true);
    print(_allWorkoutLogs.allWorkoutLogs.workoutLogsList);

    if (_allWorkoutLogs.state == LogsState.Idle)
      return Scaffold(
        appBar: AppBar(
          title: Text("Antrenman Özetiniz"),
          actions: [
            MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  print(_allWorkoutLogs.allWorkoutLogs.workoutLogsList);
                  if (_allWorkoutLogs.allWorkoutLogs.workoutLogsList.length ==
                      0) {
                    WorkoutLogsList _workoutLogsList = WorkoutLogsList();
                    _workoutLogsList.workoutName = _workout.name;
                    _workoutLogsList.workoutLogs.add(workoutLogs);
                    _allWorkoutLogs.allWorkoutLogs.workoutLogsList
                        .add(_workoutLogsList);
                    print("geldim 1");
                  } else {
                    _allWorkoutLogs.allWorkoutLogs.workoutLogsList
                        .forEach((element) {
                      if (element.workoutName == _workout.name) {
                        element.workoutLogs.add(workoutLogs);
                        print("geldim 2");
                      } else {
                        WorkoutLogsList _workoutLogsList = WorkoutLogsList();
                        _workoutLogsList.workoutName = _workout.name;
                        _workoutLogsList.workoutLogs.add(workoutLogs);
                        _allWorkoutLogs.allWorkoutLogs.workoutLogsList
                            .add(_workoutLogsList);

                        print("geldim");
                      }
                    });
                  }

                  _allWorkoutLogs.state = LogsState.Loading;

                  _allWorkoutLogs.saveWorkoutLogs();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text(
                  "KAYDET",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: workoutLogs.exerciseLogs.length,
                      itemBuilder: (BuildContext context, int index1) {
                        return ListTile(
                          title: Text(
                              workoutLogs.exerciseLogs[index1].exerciseName),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: workoutLogs
                                  .exerciseLogs[index1].setLogs.length,
                              itemBuilder: (BuildContext context, int index2) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Set " +
                                      (index2 + 1).toString() +
                                      " " +
                                      workoutLogs.exerciseLogs[index1]
                                          .setLogs[index2].weight
                                          .toString() +
                                      " kilo " +
                                      workoutLogs.exerciseLogs[index1]
                                          .setLogs[index2].reps
                                          .toString() +
                                      " tekrar"),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    else {
      return LoadingScreen();
    }
  }
}
