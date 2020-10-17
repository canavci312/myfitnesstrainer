import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/measurement_logs.dart';
import 'package:myfitnesstrainer/models/message.dart';
import 'package:myfitnesstrainer/models/progress_photos.dart';
import 'package:myfitnesstrainer/models/progress_photos_list.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/models/trainer_data.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/models/workout_logslist.dart';
import 'package:myfitnesstrainer/models/workout_planslist.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';

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

  Future<void> saveWorkoutLog(AllWorkoutLogs allWorkoutLogs, User user) async {
    StudentDataModel _studentData = locator<StudentDataModel>();
    String userID = user.userID;

    await _firebaseDB
        .collection("workout_logs")
        .document(userID)
        .setData(allWorkoutLogs.toMap());
    _studentData.studentData.studentActivity.lastWorkout =
        allWorkoutLogs.workoutLogs.last.date;
    await _firebaseDB
        .collection("students")
        .document(userID)
        .setData(_studentData.studentData.toMap());
    if (_studentData.studentData.getCoach != null) {
      var trainerDataSnapshot = await _firebaseDB
          .collection("trainers")
          .document(_studentData.studentData.getCoach.userID)
          .get();
      TrainerData trainerData = TrainerData.fromMap(trainerDataSnapshot.data);
      trainerData.studentList
          .removeWhere((element) => element.getUser.userID == user.userID);
      trainerData.studentList.add(_studentData.studentData);
      await _firebaseDB
          .collection("trainers")
          .document(_studentData.studentData.getCoach.userID)
          .setData(trainerData.toMap());
    }
  }

  Future<AllWorkoutLogs> getWorkoutLogs(User user) async {
    String userID = user.userID;

    DocumentSnapshot _okunanWorkoutLogsData =
        await Firestore.instance.document("workout_logs/$userID").get();
    if (_okunanWorkoutLogsData.data == null) {
      return AllWorkoutLogs();
    } else
      return AllWorkoutLogs.fromMap(_okunanWorkoutLogsData.data);
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

  Future<void> savePhotos(String userID, ProgressPhotos progressPhotos) async {
    StudentDataModel _studentData = locator<StudentDataModel>();
    try {
      DocumentSnapshot photosSnapshot =
          await _firebaseDB.collection("photos").document(userID).get();
      if (photosSnapshot.data == null) {
        print("burdayım");
        ProgressPhotosList photosList = ProgressPhotosList();
        photosList.progressPhotosList.add(progressPhotos);
        await _firebaseDB
            .collection("photos")
            .document(userID)
            .setData(photosList.toMap());
        _studentData.studentData.studentActivity.lastPhoto =
            progressPhotos.date;
        await _firebaseDB
            .collection("students")
            .document(userID)
            .setData(_studentData.studentData.toMap());
      } else {
        ProgressPhotosList photosList =
            ProgressPhotosList.fromMap(photosSnapshot.data);
        photosList.progressPhotosList.add(progressPhotos);
        await _firebaseDB
            .collection("photos")
            .document(userID)
            .setData(photosList.toMap());
        _studentData.studentData.studentActivity.lastPhoto =
            progressPhotos.date;
        await _firebaseDB
            .collection("students")
            .document(userID)
            .setData(_studentData.studentData.toMap());
      }
      if (_studentData.studentData.getCoach != null) {
        var trainerDataSnapshot = await _firebaseDB
            .collection("trainers")
            .document(_studentData.studentData.getCoach.userID)
            .get();
        TrainerData trainerData = TrainerData.fromMap(trainerDataSnapshot.data);
        trainerData.studentList
            .removeWhere((element) => element.getUser.userID == userID);
        trainerData.studentList.add(_studentData.studentData);
        await _firebaseDB
            .collection("trainers")
            .document(_studentData.studentData.getCoach.userID)
            .setData(trainerData.toMap());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> saveMessage(Message message) async {
    var _kaydedilecekMesajMapYapisi = message.toMap();

    await _firebaseDB
        .collection("conversations")
        .document(message.sentFrom)
        .collection(message.sentTo)
        .document()
        .setData(_kaydedilecekMesajMapYapisi);

    await _firebaseDB
        .collection("conversations")
        .document(message.sentTo)
        .collection(message.sentFrom)
        .document()
        .setData(_kaydedilecekMesajMapYapisi);

    return true;
  }

  Stream<List<Message>> getMessages(
      String currentUserID, String sohbetEdilenUserID) {
    var snapShot = _firebaseDB
        .collection("conversations")
        .document(currentUserID)
        .collection(sohbetEdilenUserID)
        .orderBy("date", descending: true)
        .snapshots();
    return snapShot.map((mesajListesi) => mesajListesi.documents
        .map((mesaj) => Message.fromMap(mesaj.data))
        .toList());
  }

  saveMeasurementLogs(MeasurementLogs measurement, String userID) async {
    print("firestore a girdi modele girdi");
    await _firebaseDB
        .collection("measurement_logs")
        .document(userID)
        .setData(measurement.toMap());
  }

  Future<MeasurementLogs> getMeasurementLogs(User user) async {
    String userID = user.userID;

    DocumentSnapshot _okunanWorkoutLogsData =
        await Firestore.instance.document("measurement_logs/$userID").get();
    if (_okunanWorkoutLogsData.data == null) {
      return MeasurementLogs();
    } else
      return MeasurementLogs.fromMap(_okunanWorkoutLogsData.data);
  }

  Future<ProgressPhotosList> getPhotos(String userID) async {
    DocumentSnapshot _okunanFotoListData =
        await Firestore.instance.document("photos/$userID").get();
    if (_okunanFotoListData.data != null) {
      return ProgressPhotosList.fromMap(_okunanFotoListData.data);
    } else
      return null;
  }
}
