import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/models/trainer_data.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/models/workout_planslist.dart';

class FirestoreDBService {
  final Firestore _firebaseDB = Firestore.instance;

  Future<User> saveUser(User user) async {
    DocumentSnapshot _okunanUser =
        await Firestore.instance.document("users/${user.userID}").get();

    if (_okunanUser.data == null) {
      await _firebaseDB
          .collection("users")
          .document(user.userID)
          .setData(user.toMap());
      DocumentSnapshot _okunanUser =
          await Firestore.instance.document("users/${user.userID}").get();
      return User.setFromMap(_okunanUser.data);
    } else {
      user = new User.setFromMap(_okunanUser.data);
      return user;
    }
  }

  Future<StudentData> checkStudentData(StudentData studentData) async {
    String userID = studentData.getUser.userID;

    DocumentSnapshot _okunanStudentData =
        await Firestore.instance.document("students/$userID").get();
    if (_okunanStudentData.data == null) {
      await _firebaseDB
          .collection("students")
          .document(studentData.getUser.userID)
          .setData(studentData.toMap());
       DocumentSnapshot _okunanStudentData =
        await Firestore.instance.document("students/$userID").get(); 
            studentData = new StudentData.fromMap(_okunanStudentData.data);
      return studentData;  
    } else {
      studentData = new StudentData.fromMap(_okunanStudentData.data);
      return studentData;
    }
  }

  Future<TrainerData> checkTrainerData(TrainerData trainerData) async {
    var userID = trainerData.userID;
    DocumentSnapshot _okunanTrainerData =
        await Firestore.instance.document("trainers/$userID").get();
    if (_okunanTrainerData.data == null) {
      await _firebaseDB
          .collection("trainers")
          .document(userID)
          .setData(trainerData.toMap());
      return trainerData;
    } else {
      trainerData = new TrainerData.fromMap(_okunanTrainerData.data);
      return trainerData;
    }
  }
    Future<TrainerData> getTrainerData(String userID) async {
    DocumentSnapshot _okunanTrainerData =
        await Firestore.instance.document("trainers/$userID").get();
  
      var trainerData = new TrainerData.fromMap(_okunanTrainerData.data);
      return trainerData;
    }
  


  Future<void> saveStudentData(StudentData studentData) async {
    String userID = studentData.getUser.userID;

    await _firebaseDB
        .collection("students")
        .document(userID)
        .setData(studentData.toMap());
  }

  Future<StudentData> getStudentData(String userID) async {
    DocumentSnapshot _okunanStudentData =
        await Firestore.instance.document("students/$userID").get();
    if (_okunanStudentData.data == null) return null;
    StudentData studentData = new StudentData.fromMap(_okunanStudentData.data);
    return studentData;
  }

  Future<User> getTrainer() async {
    QuerySnapshot querySnapshot = await _firebaseDB
        .collection("users")
        .where('trainer', isEqualTo: true)
        .getDocuments();
    DocumentSnapshot _okunan = querySnapshot.documents[0];
    return User.setFromMap(_okunan.data);
  }

  Future<User> readUser(String userID) async {
    DocumentSnapshot _okunanUser =
        await _firebaseDB.collection("users").document(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data;

    User _okunanUserNesnesi = User.setFromMap(_okunanUserBilgileriMap);
    //print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
    return _okunanUserNesnesi;
  }

  Future<WorkoutPlansList> getWorkoutPlansList(User user) async {
    DocumentSnapshot _okunanPlanlar =
        await _firebaseDB.collection("workouts").document(user.userID).get();
    if (_okunanPlanlar.data == null) {
      print("Userın hiç plani yok");
      return null;
    }
    Map<String, dynamic> _okunanPlanBilgileriMap = _okunanPlanlar.data;
    WorkoutPlansList _okunanPlanListNesnesi =
        WorkoutPlansList.fromMap(_okunanPlanBilgileriMap);
    //print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
    return _okunanPlanListNesnesi;
  }

  Future<void> saveTrainerData(TrainerData trainerData) async {
    try {
      await _firebaseDB
          .collection("trainers")
          .document(trainerData.userID)
          .setData(trainerData.toMap());
    } catch (e) {
      print(e);
    }
  }
}