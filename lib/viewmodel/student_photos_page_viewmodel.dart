import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/progress_photos_list.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';


enum LoadState { Idle, Loading }

class StudentPhotosPageViewModel with ChangeNotifier {
  UserModel _userViewModel = locator<UserModel>();
  LoadState _state = LoadState.Loading;
  ProgressPhotosList progressPhotosList;
  DateTime selectedDate1;
  DateTime selectedDate2;
  Image firstFront;
  Image secondFront;
  Image firstSide;
  Image secondSide;

  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  StudentPhotosPageViewModel() {
    getPhotos();
  }
  Future<void> getPhotos() async {
    progressPhotosList =
        await _firestoreDBService.getPhotos(_userViewModel.user.userID);
    if (progressPhotosList != null) {
      selectedDate1 = progressPhotosList.progressPhotosList.first.date;
      selectedDate2 = progressPhotosList.progressPhotosList.last.date;
    }
    state = LoadState.Idle;
  }

  LoadState get state => _state;

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
