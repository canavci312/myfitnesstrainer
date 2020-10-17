import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/workout.dart';
import 'package:myfitnesstrainer/screens/common/exercise_details.dart';
import 'package:myfitnesstrainer/screens/common/navigation.dart';
import 'package:myfitnesstrainer/screens/student/workout_helper.dart';

class StudentWorkoutDetails extends StatelessWidget {
  Workout workout;
  StudentWorkoutDetails(this.workout);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.name),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.fitness_center),
          onPressed: () {
            Navigator.of(context)
                .push(NavigationFromLeft(WorkoutHelper(workout)));
          }),
      body: Column(children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: workout.exerciseTargetsList.length,
            itemBuilder: (BuildContext context, int index2) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(NavigationFromLeft(ExerciseDetails(
                      workout.exerciseTargetsList[index2].exercise)));
                },
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                      title: Text(
                          workout.exerciseTargetsList[index2].exercise.name),
                      subtitle:
                          Text(workout.exerciseTargetsList[index2].toString())),
                ),
              );
            }),
      ]),
    );
  }
}
