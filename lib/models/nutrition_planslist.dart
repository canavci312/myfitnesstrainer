import 'package:myfitnesstrainer/models/nutrition_plan.dart';

class NutritionPlansList {
  List<NutritionPlan> nutritionPlans;
  NutritionPlansList() {
    nutritionPlans = [];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['nutritionPlans'] = firestoreNutritionPlans();

    return map;
  }

  NutritionPlansList.fromMap(Map<String, dynamic> map) {
    var list = map['nutritionPlans'] as List;
    if (list.length > 0) {
      List<NutritionPlan> nutritionPlansList =
          list.map((i) => NutritionPlan.fromMap(i)).toList();
      this.nutritionPlans = nutritionPlansList;
    } else
      nutritionPlans = [];
  }

  firestoreNutritionPlans() {
    List<Map<String, dynamic>> convertedNutritionPlanList = [];
    if (nutritionPlans != null)
      this.nutritionPlans.forEach((element) {
        NutritionPlan thisNutritionPlan = element;
        convertedNutritionPlanList.add(thisNutritionPlan.toMap());
      });
    return convertedNutritionPlanList;
  }
}
