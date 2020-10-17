import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/screens/rootpage.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/measurement_logs_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => locator<UserModel>(),
        child: ChangeNotifierProvider(
            create: (context) => locator<TrainerDataModel>(),
            child: ChangeNotifierProvider(
              create: (context) => locator<StudentDataModel>(),
              child: ChangeNotifierProvider(
                create: (context) => locator<AllWorkoutLogsModel>(),
                child: ChangeNotifierProvider(
                  create: (context) => locator<MeasurementLogsModel>(),
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    localizationsDelegates: [
                      GlobalMaterialLocalizations.delegate
                    ],
                    supportedLocales: [const Locale('en'), const Locale('tr')],
                    title: 'Flutter Demo',
                    theme: ThemeData(
                      scaffoldBackgroundColor: Colors.grey[200],
                      // This is the theme of your application.
                      //
                      // Try running your application with "flutter run". You'll see the
                      // application has a blue toolbar. Then, without quitting the app, try
                      // changing the primarySwatch below to Colors.green and then invoke
                      // "hot reload" (press "r" in the console where you ran "flutter run",
                      // or simply save your changes to "hot reload" in a Flutter IDE).
                      // Notice that the counter didn't reset back to zero; the application
                      // is not restarted.
                      primarySwatch: Colors.blue,
                      // This makes the visual density adapt to the platform that you run
                      // the app on. For desktop platforms, the controls will be smaller and
                      // closer together (more dense) than on mobile platforms.
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                    ),
                    home: RootPage(),
                  ),
                ),
              ),
            )));
  }
}
