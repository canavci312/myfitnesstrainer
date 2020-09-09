import 'package:myfitnesstrainer/models/workout.dart';

class WorkoutPlan {
  String workoutPlanID;
  String name;
  // User creator;
  String description;
  List<Workout> workouts;
  String get getWorkoutPlanID => workoutPlanID;

  set setWorkoutPlanID(String workoutPlanID) =>
      this.workoutPlanID = workoutPlanID;

  String get getName => name;

  set setName(String name) => this.name = name;
  int workoutDayCount() {
    var count = 0;
    workouts.forEach((value) {
      if (value.rest == false) count++;
    });
    return count;
  }

  String get getDescription => description;

  set setDescription(String description) => this.description = description;

  List get getWorkouts => workouts;

  set setWorkout(List workout) => this.workouts = workout;
  WorkoutPlan(
      {workoutPlanID,
      name,
      creatorID,
      creatorName,
      dayCount,
      description,
      workout});

  Map<String, dynamic> toMap() {
    return {
      'workoutPlanID': workoutPlanID,
      'name': name,
      //  'creator': creator.toMap(),
      'workouts': firestoreWorkoutsList(),
      'description': description,
    };
  }

  WorkoutPlan.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      var list = map['workouts'] as List;
      List<Workout> workoutList = list.map((i) => Workout.fromMap(i)).toList();
      this.workouts = workoutList;
      this.workoutPlanID = map['workoutPlanID'];
      this.name = map['name'];
      //  this.creator = new User.setFromMap(map['creator']);

      this.description = map['description'];
    }
  }
  firestoreWorkoutsList() {
    List<Map<String, dynamic>> convertedWorkoutsList = [];
    if (workouts != null) {
      this.workouts.forEach((workout) {
        Workout thisWorkout = workout;
        convertedWorkoutsList.add(thisWorkout.toMap());
      });
    }
    return convertedWorkoutsList;
  }
}
