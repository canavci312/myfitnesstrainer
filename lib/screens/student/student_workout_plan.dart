import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/screens/student/student_workout_details.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:provider/provider.dart';

class StudentWorkoutPlanPage extends StatelessWidget {
  const StudentWorkoutPlanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllWorkoutLogsModel _allWorkoutLogsModel = locator<AllWorkoutLogsModel>();

    return Consumer<StudentDataModel>(
        builder: (context, studentDataModel, child) {
      if (studentDataModel.studentData.getCoach.userID == null) {
        return Column(
          children: [
            _allWorkoutLogsModel.allWorkoutLogs.workoutLogs != null
                ? Text("Toplam " +
                    _allWorkoutLogsModel.allWorkoutLogs.workoutLogs.length
                        .toString() +
                    " antrenman yaptınız.")
                : Text(""),
            Center(
                child: RaisedButton(
              onPressed: () {
                studentDataModel.assignCoach();
              },
              child: Text("Koç edin"),
            )),
          ],
        );
      } else if (studentDataModel.studentData.getCoach.userID != null &&
          studentDataModel.studentData.getWorkoutPlan.name == null) {
        return Column(
          children: [
            _allWorkoutLogsModel.allWorkoutLogs.workoutLogs != null
                ? Text("Toplam " +
                    _allWorkoutLogsModel.allWorkoutLogs.workoutLogs.length
                        .toString() +
                    " antrenman yaptınız.")
                : Text(""),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hoşgeldiniz!"),
                Text(
                  "Antenörünüz en kısa süre içinde programınızı hazırlayacaktır...",
                  textAlign: TextAlign.center,
                )
              ],
            )),
          ],
        );
      } else {
        studentDataModel.findNextWorkout();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _allWorkoutLogsModel.allWorkoutLogs.workoutLogs != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Toplam " +
                          _allWorkoutLogsModel.allWorkoutLogs.workoutLogs.length
                              .toString() +
                          " antrenman yaptınız."),
                    )
                  : Text(""),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount:
                    studentDataModel.studentData.getWorkoutPlan.workouts.length,
                itemBuilder: (BuildContext context, index) {
                  //==
                  return !studentDataModel
                          .studentData.getWorkoutPlan.workouts[index].rest
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentWorkoutDetails(
                                        studentDataModel.studentData
                                            .getWorkoutPlan.workouts[index])));
                          },
                          child: ListTile(
                            leading: studentDataModel.nextWorkout ==
                                    studentDataModel.studentData.getWorkoutPlan
                                        .workouts[index]
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Sıradaki"),
                                      Icon(
                                        FontAwesomeIcons.arrowRight,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  )
                                : null,
                            title: Card(
                              margin: EdgeInsets.all(10.0),
                              child: ListTile(
                                  leading: Icon(Icons.fitness_center),
                                  title: (Text(studentDataModel.studentData
                                      .getWorkoutPlan.workouts[index].name)),
                                  subtitle: (Text((studentDataModel
                                                  .studentData
                                                  .getWorkoutPlan
                                                  .workouts[index]
                                                  .calculateWorkoutTime() /
                                              60)
                                          .round()
                                          .toString() +
                                      " dakika, " +
                                      studentDataModel
                                          .studentData
                                          .getWorkoutPlan
                                          .workouts[index]
                                          .exerciseTargetsList
                                          .length
                                          .toString() +
                                      " hareket"))),
                            ),
                          ),
                        )
                      : ListTile(
                          leading: studentDataModel.nextWorkout ==
                                  studentDataModel.studentData.getWorkoutPlan
                                      .workouts[index]
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Sıradaki"),
                                    Icon(FontAwesomeIcons.arrowRight),
                                  ],
                                )
                              : null,
                          title: Card(
                            margin: EdgeInsets.all(10.0),
                            child: ListTile(
                                leading: Icon(Icons.airline_seat_flat),
                                title: Text("Dinlenme günü"),
                                subtitle: studentDataModel.nextWorkout ==
                                        studentDataModel.studentData
                                            .getWorkoutPlan.workouts[index]
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            flex: 2,
                                            child: RaisedButton(
                                                onPressed: () {
                                                  studentDataModel
                                                      .handleRestDay();
                                                },
                                                child: Text("Dinlendim")),
                                          ),
                                        ],
                                      )
                                    : null),
                          ));
                },
              ),
            ],
          ),
        );
      }
    });
  }
}
