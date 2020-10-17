class ProgressPhotos {
  String frontUrl;
  String sideUrl;
  DateTime date;
  ProgressPhotos();
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'sideUrl': sideUrl,
      'frontUrl': frontUrl,
    };
  }

  ProgressPhotos.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      this.date = (map['date'].toDate());
      this.sideUrl = map['sideUrl'];
      this.frontUrl = map['frontUrl'];
    }
  }
}
