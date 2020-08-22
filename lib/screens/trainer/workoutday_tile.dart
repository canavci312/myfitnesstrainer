import 'package:flutter/material.dart';

class WorkoutDayTile extends StatelessWidget {
  bool rest;
  String name;
  WorkoutDayTile(this.name, this.rest);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      fit: FlexFit.loose,
      child: Card(
        child: ListTile(
            leading: rest
                ? Icon(Icons.airline_seat_individual_suite)
                : Icon(Icons.fitness_center),
            title: Text(name)),
      ),
    );
  }
}
