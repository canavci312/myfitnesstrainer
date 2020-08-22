import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/measurement.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';

enum StudentDataState { Idle, Busy }

class StudentDataModel with ChangeNotifier {
  StudentDataState _state = StudentDataState.Busy;
  StudentData studentData = StudentData();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  TrainerDataModel _trainerDataModel = TrainerDataModel();
  StudentDataModel();
  Future<void> checkStudentData(User user) async {
    studentData.setUser = user;
    studentData = await _firestoreDBService.checkStudentData(studentData);

    state = StudentDataState.Idle;
  }
  Future<void> handleMeasurementUpdate(Measurement measurement)async{
    state=StudentDataState.Busy;
    _trainerDataModel.trainerData = await _firestoreDBService.getTrainerData(studentData.getCoach.userID);
    if(studentData.recentMeasurement.weight==null){
      studentData.recentMeasurement = measurement;
    }
    else {
      studentData.lastMeasurement=studentData.recentMeasurement;
      studentData.recentMeasurement=measurement;
    }
    _trainerDataModel.trainerData.studentList.forEach((element){
      if(element.getUser.userID==studentData.getUser.userID){
        _trainerDataModel.trainerData.studentList.remove(element);
        _trainerDataModel.trainerData.studentList.add(studentData);
      }
    }
      
    );
    await _firestoreDBService.saveStudentData(studentData);
    await _firestoreDBService.saveTrainerData(_trainerDataModel.trainerData);
    state=StudentDataState.Idle;
  }
  Future<void> assignCoach() async {
    User coach = await _firestoreDBService.getTrainer();
    _trainerDataModel.trainerData =
        await _firestoreDBService.getTrainerData(coach.userID);
    studentData.setCoach = coach;
    _trainerDataModel.trainerData.studentList.add(studentData);
    await _firestoreDBService.saveTrainerData(_trainerDataModel.trainerData);
    await _firestoreDBService.saveStudentData(studentData);

    notifyListeners();
  }

  StudentDataState get state => _state;

  set state(StudentDataState value) {
    _state = value;
    notifyListeners();
  }
}
