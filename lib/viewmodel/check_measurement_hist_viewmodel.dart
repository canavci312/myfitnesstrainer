import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/measurement_logs.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';

enum LoadState { Idle, Loading }

class CheckMeasurementHistoryViewModel with ChangeNotifier {
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  MeasurementLogs measurementLogs = MeasurementLogs();
  LoadState _state = LoadState.Loading;

  final StudentData studentData;
  CheckMeasurementHistoryViewModel(this.studentData) {
    loadMeasurementLogs();
  }
  loadMeasurementLogs() async {
    measurementLogs =
        await _firestoreDBService.getMeasurementLogs(studentData.getUser);
    state = LoadState.Idle;
  }

  LoadState get state => _state;

  set state(LoadState value) {
    _state = value;
    notifyListeners();
  }
}
