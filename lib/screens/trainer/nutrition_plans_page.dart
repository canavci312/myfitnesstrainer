import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/common/nutritioncard.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:provider/provider.dart';

class NutritionPlansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TrainerDataModel>(
        builder: (context, trainerDataModel, child) {
      // a previously-obtained Future<String> or null

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 14.0, left: 18),
            child: Text(
              "Hazırladığınız Diyet Programları",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          if (trainerDataModel.trainerData.nutritionPlansList != null)
            Container(
              height: 150,
              constraints: BoxConstraints(minHeight: 200, maxHeight: 200),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: trainerDataModel
                      .trainerData.nutritionPlansList.nutritionPlans.length,
                  itemBuilder: (BuildContext context, int index) {
                    return NutritionCard(trainerDataModel
                        .trainerData.nutritionPlansList.nutritionPlans[index]);
                  }),
            ),
        ],
      );
    });
  }
}
