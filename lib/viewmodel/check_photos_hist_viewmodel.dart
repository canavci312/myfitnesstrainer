import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/progress_photos_list.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';

enum LoadState { Idle, Loading }

class CheckPhotosHistoryViewModel with ChangeNotifier {
  final StudentData _studentData;

  LoadState _state = LoadState.Loading;
  ProgressPhotosList progressPhotosList;
  DateTime selectedDate1;
  DateTime selectedDate2;
  Image firstFront;
  Image secondFront;
  Image firstSide;
  Image secondSide;

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  CheckPhotosHistoryViewModel(this._studentData) {
    getPhotos();
  }

  Future<void> getPhotos() async {
    progressPhotosList =
        await _firestoreDBService.getPhotos(_studentData.getUser.userID);
    if (progressPhotosList != null) {
      selectedDate1 = progressPhotosList.progressPhotosList.first.date;
      selectedDate2 = progressPhotosList.progressPhotosList.last.date;
    }
    state = LoadState.Idle;
  }

  LoadState get state => _state;
  String getName() {
    return _studentData.getUser.name.toString();
  }

  set state(LoadState value) {
    _state = value;
    notifyListeners();
  }

  loadImage() async {}

  void mergePhotos() {
    firstFront = Image.network(progressPhotosList.progressPhotosList
        .firstWhere((element) => element.date == selectedDate1)
        .frontUrl);
    secondFront = Image.network(progressPhotosList.progressPhotosList
        .firstWhere((element) => element.date == selectedDate2)
        .frontUrl);
    firstSide = Image.network(progressPhotosList.progressPhotosList
        .firstWhere((element) => element.date == selectedDate1)
        .sideUrl);
    secondSide = Image.network(progressPhotosList.progressPhotosList
        .firstWhere((element) => element.date == selectedDate2)
        .sideUrl);
    notifyListeners();
  }

  void selection1Changed(DateTime newValue) {
    selectedDate1 = newValue;
    notifyListeners();
  }

  void selection2Changed(DateTime newValue) {
    selectedDate2 = newValue;
    notifyListeners();
  }
}
