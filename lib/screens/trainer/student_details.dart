import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:intl/intl.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';
import 'package:myfitnesstrainer/screens/trainer/assign_workout_plan.dart';
import 'package:timeago/timeago.dart' as timeago;

class StudentDetails extends StatelessWidget {
  StudentData studentData;
  StudentDetails(this.studentData);
  @override
  Widget build(BuildContext context) {
    WorkoutPlan workoutPlan = studentData.getWorkoutPlan;
    timeago.setLocaleMessages('tr', timeago.TrMessages());

    String firstDate =
        DateFormat("dd.MM.yyyy").format(studentData.lastMeasurement.date);

    String secondDate =
        DateFormat("dd.MM.yyyy").format(studentData.recentMeasurement.date);
    final now = new DateTime.now();
    final difference = now.difference(studentData.recentMeasurement.date);
    final daysAgo =
        timeago.format(DateTime.now().subtract(difference), locale: 'tr');

    return Scaffold(
      appBar: AppBar(title: Text(studentData.getUser.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ekipman: "),
                        Text("Öğrencinin hedefi: "),
                        Text("Haftalık antrenman günü sayısı: "),
                        Text("Son antrenman: "),
                        Text("Son ölçüm güncellemesi: " + daysAgo),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Tarihler:"),
                            Text(firstDate),
                            Icon(Icons.arrow_forward),
                            Text(secondDate),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Kilo:"),
                            Text(studentData.lastMeasurement.weight.toString()),
                            Icon(Icons.arrow_forward),
                            Text(studentData.recentMeasurement.weight
                                    .toString() +
                                (studentData.recentMeasurement.weight -
                                        studentData.lastMeasurement.weight)
                                    .toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Bel:"),
                            Text(studentData.lastMeasurement.waist.toString()),
                            Icon(Icons.arrow_forward),
                            Text(
                                studentData.recentMeasurement.waist.toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Kol:"),
                            Text(studentData.lastMeasurement.arm.toString()),
                            Icon(Icons.arrow_forward),
                            Text(studentData.recentMeasurement.arm.toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Boyun:"),
                            Text(studentData.lastMeasurement.neck.toString()),
                            Icon(Icons.arrow_forward),
                            Text(studentData.recentMeasurement.neck.toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Kalça:"),
                            Text(studentData.lastMeasurement.hip.toString()),
                            Icon(Icons.arrow_forward),
                            Text(studentData.recentMeasurement.hip.toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.90,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Boy:"),
                            Text(studentData.recentMeasurement.height
                                .toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Antrenman Programı",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        if (workoutPlan.getName == null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Text("Öğrenci Program Bekliyor!"),
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AssignWorkoutPlan(
                                                      studentData)));
                                    },
                                    child: Text("Program ver"),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:
                                studentData.getWorkoutPlan.getWorkouts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return studentData
                                      .getWorkoutPlan.workouts[index].rest
                                  ? Card(
                                      margin: EdgeInsets.all(10.0),
                                      child: ListTile(
                                          leading:
                                              Icon(Icons.airline_seat_flat),
                                          title: Text("Dinlenme günü")))
                                  : Card(
                                      margin: EdgeInsets.all(10.0),
                                      child: ListTile(
                                        leading: Icon(Icons.fitness_center),
                                        title: ExpandablePanel(
                                          header: Text(studentData
                                              .getWorkoutPlan
                                              .workouts[index]
                                              .name),
                                          collapsed: Text(
                                            studentData
                                                    .getWorkoutPlan
                                                    .workouts[index]
                                                    .exerciseTargetsList
                                                    .length
                                                    .toString() +
                                                " adet egzersiz",
                                            softWrap: true,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          expanded: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: studentData
                                                  .getWorkoutPlan
                                                  .workouts[index]
                                                  .exerciseTargetsList
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index2) {
                                                return ListTile(
                                                    title: Text(studentData
                                                        .getWorkoutPlan
                                                        .workouts[index]
                                                        .exerciseTargetsList[
                                                            index2]
                                                        .exercise
                                                        .name),
                                                    subtitle: Text(studentData
                                                        .getWorkoutPlan
                                                        .workouts[index]
                                                        .exerciseTargetsList[
                                                            index2]
                                                        .toString()));
                                              }),
                                        ),
                                      ),
                                    );
                            },
                          ),
                      ]),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
