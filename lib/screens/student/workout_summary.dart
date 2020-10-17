import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/workout.dart';
import 'package:myfitnesstrainer/models/workout_logs.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';
import 'package:provider/provider.dart';

class WorkoutSummary extends StatelessWidget {
  Workout _workout;
  WorkoutLogs workoutLogs;
  WorkoutSummary(this.workoutLogs, this._workout);

  @override
  Widget build(BuildContext context) {
    WorkoutLogs workoutLogsClean = WorkoutLogs();
    workoutLogsClean.exerciseLogs = [];
    // print("burdayım" + workoutLogs.exerciseLogs.toString());
    final _allWorkoutLogs =
        Provider.of<AllWorkoutLogsModel>(context, listen: true);
    if (_allWorkoutLogs.state == LogsState.Idle)
      return Scaffold(
        appBar: AppBar(
          title: Text("Antrenman Özetiniz"),
          actions: [
            MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  workoutLogsClean.date = workoutLogs.date;
                  workoutLogsClean.workoutName = _workout.name;
                  workoutLogs.exerciseLogs.forEach((element) {
                    if (element.setLogs.isNotEmpty)
                      workoutLogsClean.exerciseLogs.add(element);
                  });
                  //               print("burdayım" + workoutLogs.exerciseLogs.toString());
                  _allWorkoutLogs.allWorkoutLogs.workoutLogs
                      .add(workoutLogsClean);

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
                                return _workout
                                        .exerciseTargetsList[index1].repBased
                                    ? Padding(
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
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Set " +
                                            (index2 + 1).toString() +
                                            " " +
                                            workoutLogs.exerciseLogs[index1]
                                                .setLogs[index2].weight
                                                .toString() +
                                            " kilo " +
                                            workoutLogs.exerciseLogs[index1]
                                                .setLogs[index2].duration
                                                .toString() +
                                            " saniye"),
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
