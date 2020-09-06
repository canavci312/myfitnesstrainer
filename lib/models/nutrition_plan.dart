import 'package:myfitnesstrainer/models/meal.dart';

class NutritionPlan {
  NutritionPlan({this.name, this.meals}) {
    meals = [];
  }
  String name;
  List<Meal> meals;
  NutritionPlan.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      var list = map['meals'] as List;

      List<Meal> mealList = list.map((i) => Meal.fromMap(i)).toList();
      this.meals = mealList;
      this.name = map['name'];
    }
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['meals'] = firestoreMealList();
    return map;
  }

  firestoreMealList() {
    List<Map<String, dynamic>> convertedMealList = [];
    if (meals != null) {
      meals.forEach((meal) {
        Meal thisMealList = meal;
        convertedMealList.add(thisMealList.toMap());
      });
    }

    return convertedMealList;
  }
}
