import 'package:get_it/get_it.dart';
import 'package:myfitnesstrainer/repository/user_repository.dart';
import 'package:myfitnesstrainer/services/auth_service.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';
import 'package:myfitnesstrainer/services/sqflite_services.dart';
import 'package:myfitnesstrainer/viewmodel/exercises_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';

GetIt locator = GetIt.I; // GetIt.I -  GetIt.instance - nin kisaltmasidir

void setupLocator() {
  locator.registerLazySingleton(() => AuthService.instance());
  locator.registerLazySingleton(() => FirestoreDBService());
  locator.registerLazySingleton(() => UserRepository());
  locator.registerLazySingleton(() => UserModel());
  locator.registerLazySingleton(() => DatabaseHelper());
  locator.registerLazySingleton(() => ExerciseViewModel());
  locator.registerLazySingleton(() => TrainerDataModel());
  locator.registerLazySingleton(() => StudentDataModel());
}
