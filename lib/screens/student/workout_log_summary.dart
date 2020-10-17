import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/workout_logs.dart';

class WorkoutLogSummary extends StatelessWidget {
  WorkoutLogs workoutLogs;
  WorkoutLogSummary(this.workoutLogs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Antrenman Özetiniz"),
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
                        title:
                            Text(workoutLogs.exerciseLogs[index1].exerciseName),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                workoutLogs.exerciseLogs[index1].setLogs.length,
                            itemBuilder: (BuildContext context, int index2) {
                              return workoutLogs.exerciseLogs[index1]
                                          .setLogs[index2].duration ==
                                      null
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
  }
}
