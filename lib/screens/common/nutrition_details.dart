import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/nutrition_plan.dart';

import 'package:expandable/expandable.dart';
import 'package:myfitnesstrainer/screens/trainer/create_nutrition_plan.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:provider/provider.dart';
import 'navigation.dart';

class NutritionDetailsPage extends StatelessWidget {
  final NutritionPlan _nutritionPlan;
  NutritionDetailsPage(this._nutritionPlan);

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainerDataModel>(
        builder: (context, trainerDataModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_nutritionPlan.name.toUpperCase()),
          actions: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                trainerDataModel.removeNutrition(_nutritionPlan);
                Navigator.pop(context);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(NavigationFromLeft((CreateNutritionPlanPage(
                  nutritionPlan: _nutritionPlan,
                ))));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/meyve_tabagi.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Beslenme Programı",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _nutritionPlan.meals.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: Icon(Icons.local_dining),
                        title: ExpandablePanel(
                          header: Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Text(
                                _nutritionPlan.meals[index].name.toUpperCase(),
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                          collapsed: Text(
                            _nutritionPlan.meals[index].foods.length
                                    .toString() +
                                " adet besin",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  _nutritionPlan.meals[index].foods.length,
                              itemBuilder: (BuildContext context, int index2) {
                                return ListTile(
                                    title: Text(_nutritionPlan
                                        .meals[index].foods[index2].name),
                                    subtitle: Text(_nutritionPlan
                                            .meals[index].foods[index2].quantity
                                            .toString() +
                                        " " +
                                        _nutritionPlan
                                            .meals[index].foods[index2].unit));
                              }),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
