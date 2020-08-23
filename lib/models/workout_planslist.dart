import 'package:myfitnesstrainer/models/workout_plan.dart';

class WorkoutPlansList {
  List<WorkoutPlan> workoutPlans;
  List<WorkoutPlan> get getWorkoutPlans => workoutPlans;

  WorkoutPlansList() {
    workoutPlans = [];
  }
  Map<String, dynamic> toMap() {
    return {
      'workoutsPlans': firestoreWorkoutPlansList(),
    };
  }

  WorkoutPlansList.fromMap(Map<String, dynamic> map) {
    var list = map['workoutsPlans'] as List;
    List<WorkoutPlan> workoutPlanList =
        list.map((i) => WorkoutPlan.fromMap(i)).toList();

    this.workoutPlans = workoutPlanList;
  }
  firestoreWorkoutPlansList() {
    List<Map<String, dynamic>> convertedWorkoutPlansList = [];
    if (workoutPlans != null) {
      this.workoutPlans.forEach((workoutPlan) {
        WorkoutPlan thisWorkoutPlan = workoutPlan;
        convertedWorkoutPlansList.add(thisWorkoutPlan.toMap());
      });
    }
    return convertedWorkoutPlansList;
  }
}
