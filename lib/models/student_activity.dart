class StudentActivity {
  DateTime lastWorkout;
  DateTime lastPhoto;
  StudentActivity();
  Map<String, dynamic> toMap() {
    return {
      'lastWorkout': lastWorkout,
      'lastPhoto': lastPhoto,
    };
  }

  StudentActivity.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map['lastWorkout'] != null)
        this.lastWorkout = (map['lastWorkout'].toDate());
      if (map['lastPhoto'] != null)
        this.lastPhoto = (map['lastPhoto'].toDate());
    }
  }
}
