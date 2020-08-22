import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/models/workout_planslist.dart';

class TrainerData {
  String userID;
  WorkoutPlansList workoutPlans;
  List<StudentData> studentList;
  TrainerData(){
    studentList=[];
  }
  TrainerData.fromMap(Map<String, dynamic> map) {
    userID=map['userID'];
    try{workoutPlans =WorkoutPlansList.fromMap(map['workoutPlans']);}catch(e){
      print("burdayım: "+e);
      workoutPlans=null;
    } 
    var list = map['studentList'] as List;
    if(list==null){
      studentList=null;
    }
    else{
    List<StudentData> students =
        list.map((i) => StudentData.fromMapWithoutCoach(i)).toList();
    studentList = students;
    }

  }
  Map<String, dynamic> toMap() {
    return {
      'userID':userID,
      if(workoutPlans==null)
      'workoutPlans':null,
      if(workoutPlans!=null)
      'workoutPlans': workoutPlans.toMap(),
      'studentList': firestoreStudentsList(),
    };
  }

  firestoreStudentsList() {
    List<Map<String, dynamic>> convertedStudentsList = [];
    if(studentList!=null)
    this.studentList.forEach((student) {
      StudentData thisStudent = student;
      convertedStudentsList.add(thisStudent.toMapWithoutCoach());
    });
    return convertedStudentsList;
  }
}
