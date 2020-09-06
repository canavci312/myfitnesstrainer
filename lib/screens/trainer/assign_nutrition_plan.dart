import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/screens/trainer/create_nutrition_plan.dart';
import 'package:myfitnesstrainer/screens/trainer/create_workout_plan.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:provider/provider.dart';

class AssignNutritionPlan extends StatelessWidget {
  StudentData _studentData;
  AssignNutritionPlan(this._studentData);
  @override
  Widget build(BuildContext context) {
    final _trainerModel = Provider.of<TrainerDataModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: Text(_studentData.getUser.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Text("Önceden Hazırlanmış Programlarınız"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _trainerModel
                  .trainerData.nutritionPlansList.nutritionPlans.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNutritionPlanPage(
                                  nutritionPlan: _trainerModel.trainerData
                                      .nutritionPlansList.nutritionPlans[index],
                                  studentData: _studentData,
                                )));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(_trainerModel.trainerData.nutritionPlansList
                          .nutritionPlans[index].name),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
