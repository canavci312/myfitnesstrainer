class Exercise {
  int exerciseID;
  String name;
  String description;
  String image;
  String type;
  String video;
  String equipment;
  String mainMuscle;
  bool userCreated;
  Exercise(
      {this.name,
      this.description = 'Henüz bir açıklama eklenmemiş ☹️',
      this.type,
      this.equipment,
      this.mainMuscle = 'Undefined',
      this.userCreated});
  Exercise.withID(
      {this.exerciseID,
      this.name,
      this.description = 'Henüz bir açıklama eklenmemiş ☹️',
      this.type,
      this.image,
      this.video,
      this.equipment,
      this.mainMuscle = 'Undefined',
      this.userCreated});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['exerciseID'] = exerciseID;
    map['name'] = name;
    map['description'] = description;
    map['equipment'] = equipment;
    map['type'] = type;
    map['mainMuscle'] = mainMuscle;
    map['userCreated'] = userCreated;
    return map;
  }

  Exercise.fromMap(Map<String, dynamic> map) {
    
    this.exerciseID = map['exerciseID'];
    this.name = map['name'];
    this.description = map['description'];
    this.equipment = map['equipment'];
    this.type = map['type'];
    this.mainMuscle = map['mainMuscle'];
    if (map['userCreated'] == 0)
      this.userCreated = false;
    else
      this.userCreated = true;
  }
  String getName() {
    return name;
  }
}
