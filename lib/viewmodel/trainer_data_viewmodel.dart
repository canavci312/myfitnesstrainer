import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/trainer_data.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';
import 'package:myfitnesstrainer/models/workout_planslist.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';

enum TrainerDataState { Idle, Busy }

class TrainerDataModel with ChangeNotifier {
  TrainerDataState _state = TrainerDataState.Busy;
  TrainerData trainerData = TrainerData();
  WorkoutPlansList workoutPlansList=WorkoutPlansList();
  
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  TrainerDataModel();
  Future<void> checkTrainerData(User user) async {
    trainerData.workoutPlans=workoutPlansList;
    trainerData.userID=user.userID;
    trainerData =
        await _firestoreDBService.checkTrainerData( trainerData);
    print("userID: "+trainerData.userID+"workoutPlanList:"+trainerData.workoutPlans.toString());
    state = TrainerDataState.Idle;
  }

  TrainerDataState get state => _state;

  set state(TrainerDataState value) {
    _state = value;
    notifyListeners();
  }
  Future<void> addWorkout(WorkoutPlan workoutPlan) async {
    trainerData.workoutPlans.workoutPlans.add(workoutPlan);
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

}
