import 'package:myfitnesstrainer/models/exercise_targets.dart';

class Workout {
  String id;
  String name;
  bool rest;
  List<ExerciseTargets> exerciseTargetsList;
  String get getId => id;

  set setId(String id) => this.id = id;

  String get getName => name;

  set setName(String name) => this.name = name;

  bool get getRest => rest;

  set setRest(bool rest) => this.rest = rest;

  List get getExerciseList => exerciseTargetsList;

  set setExerciseList(List exerciseList) =>
      this.exerciseTargetsList = exerciseList;

  Workout({this.id, this.name, this.rest, this.exerciseTargetsList});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rest': rest,
      if (!rest) 'exerciseList': firestoreExerciseList(),
    };
  }

  Workout.fromMap(Map<String, dynamic> map) {
    this.rest = map['rest'];

    try {
      if (!rest) {
        var list = map['exerciseList'] as List;

        List<ExerciseTargets> workoutPlanList =
            list.map((i) => ExerciseTargets.fromMap(i)).toList();
        this.exerciseTargetsList = workoutPlanList;
      }

      this.id = map['id'];
      this.name = map['name'];
    } catch (e) {
      print(e);
    }
  }
  firestoreExerciseList() {
    List<Map<String, dynamic>> convertedExerciseList = [];
    if (exerciseTargetsList != null) {
      exerciseTargetsList.forEach((exerciseTargets) {
        ExerciseTargets thisExerciseTargets = exerciseTargets;
        convertedExerciseList.add(thisExerciseTargets.toMap());
      });
    }

    return convertedExerciseList;
  }
}
