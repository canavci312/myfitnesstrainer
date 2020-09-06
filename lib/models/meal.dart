import 'package:myfitnesstrainer/models/food.dart';

class Meal {
  String name;
  List<Food> foods;
  Meal({this.name, this.foods}) {
    foods = [];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['foods'] = firestoreFoodList();
    return map;
  }

  Meal.fromMap(Map<String, dynamic> map) {
    var list = map['foods'] as List;

    List<Food> foodList = list.map((i) => Food.fromMap(i)).toList();
    this.foods = foodList;
    this.name = map['name'];
  }
  firestoreFoodList() {
    List<Map<String, dynamic>> convertedFoodList = [];
    if (foods != null) {
      foods.forEach((food) {
        Food thisFoodList = food;
        convertedFoodList.add(thisFoodList.toMap());
      });
    }

    return convertedFoodList;
  }
}
