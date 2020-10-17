import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/screens/login_screen.dart';
import 'package:myfitnesstrainer/screens/student/student_home.dart';
import 'package:myfitnesstrainer/screens/trainer/trainer_home.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/measurement_logs_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context, listen: true);
    final _trainerModel = Provider.of<TrainerDataModel>(context, listen: true);
    final _studentModel = Provider.of<StudentDataModel>(context, listen: true);

    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user != null) {
        if (_userModel.user.trainer == true) {
          if (_trainerModel.state != TrainerDataState.Idle) {
            _trainerModel.checkTrainerData(_userModel.user);

            return LoadingScreen();
          } else {
            return TrainerHomePage();
          }
        } else {
          if (_studentModel.state != StudentDataState.Idle) {
            _studentModel.checkStudentData(_userModel.user);
            return LoadingScreen();
          } else {
            final _allWorkoutLogs =
                Provider.of<AllWorkoutLogsModel>(context, listen: true);
            final _allMeasurementLogs =
                Provider.of<MeasurementLogsModel>(context, listen: true);
            if (_allWorkoutLogs.state == LogsState.Loading &&
                _allMeasurementLogs.state == MeasurementLogsState.Loading) {
              print("girdim");
              _allMeasurementLogs.loadMeasurementLogs();
              _allWorkoutLogs.loadWorkoutLogs();
              return LoadingScreen();
            } else
              return StudentHomePage();
          }
          //else return LoadingScreen();
        }
      } else
        return LoginPage();
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
