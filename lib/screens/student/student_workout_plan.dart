import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/student/student_workout_details.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:provider/provider.dart';

class StudentWorkoutPlanPage extends StatelessWidget {
  const StudentWorkoutPlanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return Consumer<StudentDataModel>(
        builder: (context, studentDataModel, child) {
      if (studentDataModel.studentData.getCoach.userID == null) {
        return Center(
            child: RaisedButton(
          onPressed: () {
            studentDataModel.assignCoach();
          },
          child: Text("Koç edin"),
        ));
      } else if (studentDataModel.studentData.getCoach.userID != null &&
          studentDataModel.studentData.getWorkoutPlan.name == null) {
        return Center(
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
        ));
      } else {
        return SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount:
                    studentDataModel.studentData.getWorkoutPlan.workouts.length,
                itemBuilder: (BuildContext context, index) {
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
                          child: Card(
                            margin: EdgeInsets.all(10.0),
                            child: ListTile(
                                leading: Icon(Icons.fitness_center),
                                title: (Text(studentDataModel.studentData
                                    .getWorkoutPlan.workouts[index].name)),
                                subtitle: (Text((studentDataModel.studentData
                                                .getWorkoutPlan.workouts[index]
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
                        )
                      : Card(
                          margin: EdgeInsets.all(10.0),
                          child: ListTile(
                              leading: Icon(Icons.airline_seat_flat),
                              title: Text("Dinlenme günü")));
                },
              ),
            ],
          ),
        );
      }
    });
  }
}
