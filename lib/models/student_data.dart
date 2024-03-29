import 'package:myfitnesstrainer/models/measurement.dart';
import 'package:myfitnesstrainer/models/nutrition_plan.dart';
import 'package:myfitnesstrainer/models/student_activity.dart';
import 'package:myfitnesstrainer/models/student_other_information.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';

class StudentData {
  User _user;
  WorkoutPlan _workoutPlan = WorkoutPlan();
  StudentOtherInformation studentOtherInformation = StudentOtherInformation();
  NutritionPlan nutritionPlan;
  Measurement recentMeasurement;
  Measurement lastMeasurement;
  User _coach;
  StudentActivity studentActivity;
  User get getUser => _user;

  set setUser(User user) => this._user = user;

  WorkoutPlan get getWorkoutPlan => _workoutPlan;

  set setWorkoutPlan(WorkoutPlan workoutPlan) =>
      this._workoutPlan = workoutPlan;

  set setCoach(User coach) => this._coach = coach;

  User get getCoach => _coach;

  StudentData({User user, WorkoutPlan workoutPlan, User coach}) {
    studentActivity = StudentActivity();
    setUser = user;
    setWorkoutPlan = workoutPlan;
    setCoach = coach;
  }
  StudentData.fromMap(Map<String, dynamic> map) {
    _user = User.setFromMap(map['user']);
    _workoutPlan = WorkoutPlan.fromMap(map['workoutPlan']);
    _coach = User.setFromMap(map['coach']);
    recentMeasurement = Measurement.fromMap(map['recentMeasurement']);
    lastMeasurement = Measurement.fromMap(map['lastMeasurement']);
    studentOtherInformation =
        StudentOtherInformation.fromMap(map['studentOtherInformation']);
    nutritionPlan = NutritionPlan.fromMap(map['nutritionPlan']);
    studentActivity = StudentActivity.fromMap(map['studentActivity']);
  }
  Map<String, dynamic> toMap() {
    return {
      'user': _user.toMap(),
      if (_workoutPlan != null) 'workoutPlan': _workoutPlan.toMap(),
      if (_workoutPlan == null) 'workoutPlan': null,
      if (_coach != null) 'coach': _coach.toMap(),
      if (_coach == null) 'coach': null,
      if (recentMeasurement != null)
        'recentMeasurement': recentMeasurement.toMap(),
      if (recentMeasurement == null) 'recentMeasurement': null,
      if (lastMeasurement != null) 'lastMeasurement': lastMeasurement.toMap(),
      if (lastMeasurement == null) 'lastMeasurement': null,
      if (studentOtherInformation != null)
        'studentOtherInformation': studentOtherInformation.toMap(),
      if (studentOtherInformation == null) 'studentOtherInformation': null,
      if (nutritionPlan != null) 'nutritionPlan': nutritionPlan.toMap(),
      if (nutritionPlan == null) 'nutritionPlan': null,
      if (nutritionPlan != null) 'studentActivity': studentActivity.toMap(),
      if (nutritionPlan == null) 'studentActivity': null,
    };
  }

  Map<String, dynamic> toMapWithoutCoach() {
    return {
      'user': _user.toMap(),
      if (_workoutPlan != null) 'workoutPlan': _workoutPlan.toMap(),
      if (_workoutPlan == null) 'workoutPlan': null,
      if (recentMeasurement != null)
        'recentMeasurement': recentMeasurement.toMap(),
      if (recentMeasurement == null) 'recentMeasurement': null,
      if (lastMeasurement != null) 'lastMeasurement': lastMeasurement.toMap(),
      if (lastMeasurement == null) 'lastMeasurement': null,
      if (studentOtherInformation != null)
        'studentOtherInformation': studentOtherInformation.toMap(),
      if (studentOtherInformation == null) 'studentOtherInformation': null,
      if (nutritionPlan != null) 'nutritionPlan': nutritionPlan.toMap(),
      if (nutritionPlan == null) 'nutritionPlan': null,
      if (nutritionPlan != null) 'studentActivity': studentActivity.toMap(),
      if (nutritionPlan == null) 'studentActivity': null,
    };
  }

  StudentData.fromMapWithoutCoach(Map<String, dynamic> map) {
    _user = User.setFromMap(map['user']);
    _workoutPlan = WorkoutPlan.fromMap(map['workoutPlan']);
    recentMeasurement = Measurement.fromMap(map['recentMeasurement']);
    lastMeasurement = Measurement.fromMap(map['lastMeasurement']);
    studentOtherInformation =
        StudentOtherInformation.fromMap(map['studentOtherInformation']);
    nutritionPlan = NutritionPlan.fromMap(map['nutritionPlan']);
    studentActivity = StudentActivity.fromMap(map['studentActivity']);
  }
}
