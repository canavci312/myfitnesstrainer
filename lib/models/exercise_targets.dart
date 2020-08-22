import 'package:myfitnesstrainer/models/exercise.dart';

class ExerciseTargets {
  Exercise exercise;
  bool repBased;
  int setCount;
  int minRep;
  int maxRep;
  int duration;
  int rest;
  ExerciseTargets(
      {this.exercise,
      this.repBased: true,
      this.setCount: 3,
      this.minRep: 12,
      this.maxRep: 15,
      this.duration: 60,
      this.rest: 60});

  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise.toMap(),
      'repBased': repBased,
      'setCount': setCount,
      'minRep': minRep,
      'maxRep': maxRep,
      'duration': duration,
      'rest': rest,
    };
  }

  ExerciseTargets.fromMap(Map<String, dynamic> map) {
    this.exercise = new Exercise.fromMap(map['exercise']);

    this.repBased = map['repBased'];
    this.setCount = map['setCount'];
    this.minRep = map['minRep'];
    this.maxRep = map['maxRep'];
    this.duration = map['duration'];
    this.rest = map['rest'];
  }
  @override
  String toString() {
    String str;
    if (repBased) {
      str = setCount.toString() +
          " set " +
          minRep.toString() +
          "-" +
          maxRep.toString() +
          " tekrar " +
          rest.toString() +
          " sn dinlenme";
    } else {
      str = setCount.toString() +
          " set " +
          duration.toString() +
          " sn" +
          rest.toString() +
          " sn dinlenme";
    }
    return str;
  }
}
