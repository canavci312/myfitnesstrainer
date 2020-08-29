enum Gender { Male, Female }
enum DailyActivity { Active, Normal, Inactive }
enum Goal { AtlethicPerformance, GettingStronger, GainMuscle, LoseFat }

class StudentOtherInformation {
  StudentOtherInformation();
  String equipments;
  int availableDays;
  Goal goal;
  Gender gender;
  DailyActivity dailyActivity;
  DateTime birthday;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['equipments'] = equipments;
    map['availableDays'] = availableDays;
    map['goal'] = goal.toString();
    map['gender'] = gender.toString();

    map['dailyActivity'] = dailyActivity.toString();
    map['birthday'] = birthday;

    return map;
  }

  StudentOtherInformation.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      if (map['birthday'] != null) {
        this.equipments = map['equipments'];
        this.availableDays = map['availableDays'];
        this.goal = Goal.values
            .firstWhere((f) => f.toString() == map["goal"], orElse: () => null);

        this.gender = Gender.values.firstWhere(
            (f) => f.toString() == map["gender"],
            orElse: () => null);
        this.dailyActivity = DailyActivity.values.firstWhere(
            (f) => f.toString() == map["dailyActivity"],
            orElse: () => null);
        this.birthday = (map['birthday'].toDate());
      } else {
        this.equipments = null;
        this.birthday = null;
        this.availableDays = null;

        this.goal = null;
        this.gender = null;
        this.dailyActivity = null;
      }
    }
  }
}
