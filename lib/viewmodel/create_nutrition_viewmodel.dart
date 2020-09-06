import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/models/food.dart';
import 'package:myfitnesstrainer/models/meal.dart';
import 'package:myfitnesstrainer/models/nutrition_plan.dart';

enum EditState { Idle, Editing }
enum LoadState { Idle, Loading }

class CreateNutritionPlanModel with ChangeNotifier {
  NutritionPlan nutritionPlan;
  List<Meal> _meals;
  CreateNutritionPlanModel({this.nutritionPlan}) {
    if (nutritionPlan == null) {
      nutritionPlan = NutritionPlan(name: "");
      _meals = [];
    } else {
      _meals = nutritionPlan.meals;
      this.nutritionPlan = nutritionPlan;
    }
  }

  EditState _state = EditState.Idle;
  LoadState _loadState = LoadState.Idle;
  List<Meal> get meals => _meals;
  EditState get state => _state;

  void updateName(String name) {
    nutritionPlan.name = name;
    state = EditState.Idle;
    notifyListeners();
  }

  void editStarted() {
    state = EditState.Editing;
    notifyListeners();
  }

  LoadState get loadState => _loadState;

  set loadState(LoadState value) {
    _loadState = value;
    notifyListeners();
  }

  set state(EditState value) {
    _state = value;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  String get name {
    return nutritionPlan.name;
  }

  /*Future<void> saveWorkoutPlan() async {
    await _firestoreDBService.saveWorkout(_workoutPlan);
  }
*/
  void addMeal(String name) {
    _meals.add(new Meal(foods: <Food>[], name: name));
    nutritionPlan.meals = _meals;

    notifyListeners();
  }

  void removeMeal(Meal meal) {
    _meals.remove(meal);
    nutritionPlan.meals = _meals;

    notifyListeners();
  }

  void addMealIndex(Meal meal, int index) {
    try {
      _meals.insert(index, meal);
    } catch (e) {
      _meals.add(meal);
    } finally {
      nutritionPlan.meals = _meals;

      notifyListeners();
    }
  }
}
