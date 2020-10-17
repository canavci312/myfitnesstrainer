import 'package:flutter/widgets.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/models/workout_logslist.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';

enum LoadState { Idle, Loading }

class CheckWorkoutHistoryViewModel with ChangeNotifier {
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  AllWorkoutLogs allWorkoutLogs = AllWorkoutLogs();
  LoadState _state = LoadState.Loading;

  final StudentData studentData;
  CheckWorkoutHistoryViewModel(this.studentData) {
    loadMeasurementLogs();
  }
  loadMeasurementLogs() async {
    allWorkoutLogs =
        await _firestoreDBService.getWorkoutLogs(studentData.getUser);
    state = LoadState.Idle;
  }

  LoadState get state => _state;

  set state(LoadState value) {
    _state = value;
    notifyListeners();
  }
}
