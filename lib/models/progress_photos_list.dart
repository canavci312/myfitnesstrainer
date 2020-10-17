import 'package:myfitnesstrainer/models/progress_photos.dart';

class ProgressPhotosList {
  List<ProgressPhotos> progressPhotosList;
  ProgressPhotosList() {
    progressPhotosList = [];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['progressPhotosList'] = firestoreProgressPhotosList();

    return map;
  }

  ProgressPhotosList.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      var list = map['progressPhotosList'] as List;
      if (list != null) {
        List<ProgressPhotos> progressPhotos =
            list.map((i) => ProgressPhotos.fromMap(i)).toList();
        this.progressPhotosList = progressPhotos;
      }
    }
  }

  firestoreProgressPhotosList() {
    List<Map<String, dynamic>> convertedProgressPhotosList = [];
    if (progressPhotosList != null)
      this.progressPhotosList.forEach((element) {
        ProgressPhotos thisprogressPhotos = element;
        convertedProgressPhotosList.add(thisprogressPhotos.toMap());
      });
    return convertedProgressPhotosList;
  }
}
