import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/models/food.dart';
import 'package:myfitnesstrainer/models/meal.dart';

enum EditViewState { Idle, Editing }

class CreateMealViewModel with ChangeNotifier {
  Meal meal;
  CreateMealViewModel(this.meal);
  EditViewState _state = EditViewState.Idle;
  EditViewState get state => _state;

  int get foodCount {
    return meal.foods.length;
  }

  void updateName(String name) {
    meal.name = name;
    state = EditViewState.Idle;
    notifyListeners();
  }

  void editStarted() {
    state = EditViewState.Editing;
    notifyListeners();
  }

  void addFood(Food food) {
    meal.foods.add(food);
    notifyListeners();
  }

  void updateFood(Food food, Food newFood) {
    if (meal.foods.contains(food)) {
      int index = meal.foods.indexOf(food);
      meal.foods.remove(food);
      meal.foods.insert(index, newFood);
    } else
      print("öyle bir exercise target yok");
    notifyListeners();
  }

  void removeFood(Food food) {
    meal.foods.remove(food);
    notifyListeners();
  }

  set state(EditViewState value) {
    _state = value;
    notifyListeners();
  }
}
