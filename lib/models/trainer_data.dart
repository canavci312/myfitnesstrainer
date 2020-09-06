import 'package:myfitnesstrainer/models/nutrition_plan.dart';
import 'package:myfitnesstrainer/models/nutrition_planslist.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/models/workout_planslist.dart';

class TrainerData {
  String userID;
  WorkoutPlansList workoutPlans = WorkoutPlansList();
  NutritionPlansList nutritionPlansList = NutritionPlansList();
  List<StudentData> studentList;
  TrainerData() {
    studentList = [];
  }
  TrainerData.fromMap(Map<String, dynamic> map) {
    userID = map['userID'];
    try {
      workoutPlans = WorkoutPlansList.fromMap(map['workoutPlansList']);
    } catch (e) {
      print("burdayım: " + e.toString());
      workoutPlans = null;
    }
    try {
      nutritionPlansList =
          NutritionPlansList.fromMap(map['nutritionPlansList']);
    } catch (e) {
      print("burdayım: " + e.toString());
      nutritionPlansList = null;
    }
    var list = map['studentList'] as List;
    if (list == null) {
      studentList = null;
    } else {
      List<StudentData> students =
          list.map((i) => StudentData.fromMapWithoutCoach(i)).toList();
      studentList = students;
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      if (workoutPlans == null) 'workoutPlansList': null,
      if (workoutPlans != null) 'workoutPlansList': workoutPlans.toMap(),
      'studentList': firestoreStudentsList(),
      if (nutritionPlansList == null) 'nutritionPlansList': null,
      if (nutritionPlansList != null)
        'nutritionPlansList': nutritionPlansList.toMap(),
    };
  }

  firestoreStudentsList() {
    List<Map<String, dynamic>> convertedStudentsList = [];
    if (studentList != null)
      this.studentList.forEach((student) {
        StudentData thisStudent = student;
        convertedStudentsList.add(thisStudent.toMapWithoutCoach());
      });
    return convertedStudentsList;
  }
}
