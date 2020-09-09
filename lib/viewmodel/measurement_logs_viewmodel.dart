import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/measurement.dart';
import 'package:myfitnesstrainer/models/measurement_logs.dart';
import 'package:myfitnesstrainer/models/workout_logslist.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';

enum MeasurementLogsState { Loading, Idle }

class MeasurementLogsModel with ChangeNotifier {
  MeasurementLogsState _state = MeasurementLogsState.Loading;
  UserModel _userModel = locator<UserModel>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  MeasurementLogs allMeasurements = MeasurementLogs();
  MeasurementLogsState get state => _state;

  set state(MeasurementLogsState value) {
    _state = value;
    notifyListeners();
  }

  reset() {
    _state = MeasurementLogsState.Loading;
    allMeasurements = MeasurementLogs();
  }

  Future<void> loadMeasurementLogs() async {
    allMeasurements =
        await _firestoreDBService.getMeasurementLogs(_userModel.user);
    state = MeasurementLogsState.Idle;
  }

  Future<void> saveMeasurementLogs(Measurement newMeasurement) async {
    print("view modele girdi");
    allMeasurements.measurementLogs.add(newMeasurement);
    await _firestoreDBService.saveMeasurementLogs(
        allMeasurements, _userModel.user.userID);
    state = MeasurementLogsState.Idle;
  }
}
