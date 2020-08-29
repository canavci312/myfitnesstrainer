class SetLogs {
  int reps;
  int weight;
  int duration;
  SetLogs({this.reps, this.weight, this.duration});
  Map<String, dynamic> toMap() =>
      {"reps": this.reps, "duration": duration, "weight": this.weight};

  SetLogs.fromMap(Map<dynamic, dynamic> map)
      : reps = map["reps"],
        duration = map["duration"],
        weight = map["weight"];
}
