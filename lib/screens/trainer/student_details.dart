import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:intl/intl.dart';

class StudentDetails extends StatelessWidget {
  StudentData studentData;
  StudentDetails(this.studentData);
  @override
  Widget build(BuildContext context) {
    String firstDate =
        DateFormat("dd.MM.yyyy").format(studentData.lastMeasurement.date);

    String secondDate =
        DateFormat("dd.MM.yyyy").format(studentData.recentMeasurement.date);

    return Scaffold(
      appBar: AppBar(title: Text(studentData.getUser.name)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Kilo:"),
                  Text(studentData.lastMeasurement.weight.toString()),
                  Icon(Icons.arrow_forward),
                  Text(studentData.recentMeasurement.weight.toString()+(studentData.recentMeasurement.weight-studentData.lastMeasurement.weight).toString()),
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
                  Text("Bel:"),
                  Text(studentData.lastMeasurement.waist.toString()),
                  Icon(Icons.arrow_forward),
                  Text(studentData.recentMeasurement.waist.toString()),
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
                  Text(studentData.recentMeasurement.height.toString()),
                ],
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
