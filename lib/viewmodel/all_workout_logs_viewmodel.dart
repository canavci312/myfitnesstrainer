import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/all_workout_logs.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';

enum LogsState { Loading, Idle }

class AllWorkoutLogsModel with ChangeNotifier {
  LogsState _state = LogsState.Loading;
  UserModel _userModel = locator<UserModel>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  AllWorkoutLogs allWorkoutLogs = AllWorkoutLogs();
  LogsState get state => _state;

  set state(LogsState value) {
    _state = value;
    notifyListeners();
  }

  reset() {
    _state = LogsState.Loading;
    allWorkoutLogs = AllWorkoutLogs();
  }

  Future<void> loadWorkoutLogs() async {
    allWorkoutLogs = await _firestoreDBService.getWorkoutLogs(_userModel.user);
    state = LogsState.Idle;
  }

  Future<void> saveWorkoutLogs() async {
    await _firestoreDBService.saveWorkoutLog(allWorkoutLogs, _userModel.user);
    state = LogsState.Idle;
  }
}
