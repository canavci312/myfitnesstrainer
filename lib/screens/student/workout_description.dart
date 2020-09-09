import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';

class WorkoutDescriptionPage extends StatelessWidget {
  WorkoutPlan workoutPlan;
  WorkoutDescriptionPage(this.workoutPlan);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Programın açıklaması"),
      ),
      body: Container(
        child: workoutPlan.description == null
            ? Text("Programın açıklaması girilmemiş",
                style: TextStyle(fontSize: 18))
            : Text(workoutPlan.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 999,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
