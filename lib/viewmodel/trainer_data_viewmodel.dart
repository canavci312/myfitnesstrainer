import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/nutrition_plan.dart';
import 'package:myfitnesstrainer/models/nutrition_planslist.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/models/trainer_data.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';
import 'package:myfitnesstrainer/models/workout_planslist.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';

enum TrainerDataState { Idle, Busy }

class TrainerDataModel with ChangeNotifier {
  TrainerDataState _state = TrainerDataState.Busy;
  TrainerData trainerData = TrainerData();

  WorkoutPlansList workoutPlansList = WorkoutPlansList();
  // NutritionPlansList nutritionPlansList = NutritionPlansList();
  UserModel _userModel = locator<UserModel>();

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  TrainerDataModel();
  Future<void> checkTrainerData(User user) async {
    trainerData.workoutPlans = workoutPlansList;
    trainerData.userID = user.userID;
    trainerData = await _firestoreDBService.checkTrainerData(trainerData);
    print("userID: " +
        trainerData.userID +
        "workoutPlanList:" +
        trainerData.workoutPlans.toString());
    state = TrainerDataState.Idle;
  }

  reset() {
    trainerData = TrainerData();
    workoutPlansList = WorkoutPlansList();
    state = TrainerDataState.Busy;
  }

  TrainerDataState get state => _state;

  set state(TrainerDataState value) {
    _state = value;
    notifyListeners();
  }

  Future<void> getTrainerData() async {
    print("Trainer Data is Refreshed");
    trainerData = await _firestoreDBService.getTrainerData(trainerData.userID);

    notifyListeners();
  }

  Future<void> addWorkout(WorkoutPlan workoutPlan) async {
    trainerData.workoutPlans.workoutPlans.add(workoutPlan);
    await _firestoreDBService.saveTrainerData(trainerData);
    notifyListeners();
  }

  Future<void> addNutrition(NutritionPlan nutritionPlan) async {
    trainerData.nutritionPlansList.nutritionPlans.add(nutritionPlan);
    await _firestoreDBService.saveTrainerData(trainerData);
    notifyListeners();
  }

  Future<void> updateNutrition() async {
    await _firestoreDBService.saveTrainerData(trainerData);
    notifyListeners();
  }

  Future<void> updateWorkout(WorkoutPlan workoutPlan) async {
    await _firestoreDBService.saveTrainerData(trainerData);
    notifyListeners();
  }

  Future<void> removeWorkout(WorkoutPlan workoutPlan) async {
    trainerData.workoutPlans.workoutPlans.remove(workoutPlan);
    await _firestoreDBService.saveTrainerData(trainerData);
    notifyListeners();
  }

  Future<void> removeNutrition(NutritionPlan nutritionPlan) async {
    trainerData.workoutPlans.workoutPlans.remove(nutritionPlan);
    await _firestoreDBService.saveTrainerData(trainerData);
    notifyListeners();
  }

  Future<void> assignNutritionPlan(
      NutritionPlan nutritionPlan, StudentData studentData) async {
    studentData.nutritionPlan = nutritionPlan;
    studentData.setCoach = _userModel.user;
    trainerData.studentList.forEach((element) {
      if (element.getUser.userID == studentData.getUser.userID) {
        trainerData.studentList.remove(element);
        trainerData.studentList.add(studentData);
      }
    });
    await _firestoreDBService.saveStudentData(studentData);
    await _firestoreDBService.saveTrainerData(trainerData);
    notifyListeners();
  }

  Future<void> assignWorkoutPlan(
      WorkoutPlan workoutPlan, StudentData studentData) async {
    studentData.setWorkoutPlan = workoutPlan;
    studentData.setCoach = _userModel.user;
    trainerData.studentList.forEach((element) {
      if (element.getUser.userID == studentData.getUser.userID) {
        trainerData.studentList.remove(element);
        trainerData.studentList.add(studentData);
      }
    });
    await _firestoreDBService.saveStudentData(studentData);
    await _firestoreDBService.saveTrainerData(trainerData);
    notifyListeners();
  }
}
