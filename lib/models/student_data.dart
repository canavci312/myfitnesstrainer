import 'package:myfitnesstrainer/models/measurement.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';

class StudentData {
  User _user;
  WorkoutPlan _workoutPlan = WorkoutPlan();
  Measurement recentMeasurement;
  Measurement lastMeasurement;
  User _coach;
  User get getUser => _user;

  set setUser(User user) => this._user = user;

  WorkoutPlan get getWorkoutPlan => _workoutPlan;

  set setWorkoutPlan(WorkoutPlan workoutPlan) =>
      this._workoutPlan = workoutPlan;

  set setCoach(User coach) => this._coach = coach;

  User get getCoach => _coach;

  StudentData({User user, WorkoutPlan workoutPlan, User coach}) {
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
    };
  }

  StudentData.fromMapWithoutCoach(Map<String, dynamic> map) {
    _user = User.setFromMap(map['user']);
    _workoutPlan = WorkoutPlan.fromMap(map['workoutPlan']);
    recentMeasurement = Measurement.fromMap(map['recentMeasurement']);
    lastMeasurement = Measurement.fromMap(map['lastMeasurement']);
  }
}
