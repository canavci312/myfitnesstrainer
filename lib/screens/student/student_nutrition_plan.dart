import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:provider/provider.dart';

class StudentNutritionPlanPage extends StatelessWidget {
  const StudentNutritionPlanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentDataModel>(builder: (_, studentDataModel, child) {
      if (studentDataModel.studentData.getCoach.userID == null) {
        return Center(
            child: RaisedButton(
          onPressed: () {
            studentDataModel.assignCoach();
          },
          child: Text("Koç edin"),
        ));
      } else if (studentDataModel.studentData.getCoach.userID != null &&
          studentDataModel.studentData.nutritionPlan == null) {
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
            child: Column(children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount:
                  studentDataModel.studentData.nutritionPlan.meals.length,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            studentDataModel
                                .studentData.nutritionPlan.meals[index].name
                                .toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Divider(
                          color: Colors.black,
                        )
                      ],
                    ),
                    subtitle: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: studentDataModel
                          .studentData.nutritionPlan.meals[index].foods.length,
                      itemBuilder: (BuildContext context, int index2) {
                        return ListTile(
                            title: Text(studentDataModel.studentData
                                .nutritionPlan.meals[index].foods[index2].name),
                            subtitle: Text(studentDataModel
                                    .studentData
                                    .nutritionPlan
                                    .meals[index]
                                    .foods[index2]
                                    .quantity
                                    .toString() +
                                " " +
                                studentDataModel.studentData.nutritionPlan
                                    .meals[index].foods[index2].unit));
                      },
                    ),
                  ),
                );
              })
        ]));
      }
    });
  }
}
