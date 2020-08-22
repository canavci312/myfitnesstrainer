
import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/student/student_nutrition_plan.dart';
import 'package:myfitnesstrainer/screens/student/student_progress.dart';
import 'package:myfitnesstrainer/screens/student/student_upload.dart';
import 'package:myfitnesstrainer/screens/student/student_workout_plan.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:myfitnesstrainer/screens/common/inbox_page.dart';

import 'package:myfitnesstrainer/screens/trainer/trainer_drawer.dart';
class StudentHomePage extends StatefulWidget {

  createState() {
    return StudentHomePageState();
  }
}

@override
class StudentHomePageState extends State<StudentHomePage> {
  int _currentIndex = 0;
  StudentNutritionPlanPage _nutritionPlanPage;
  StudentWorkoutPlanPage _workoutPlanPage;
  StudentUploadPage _uploadPage;
  StudentProgressPage _progressPage;
  InboxPage _inboxPage;
  List<Widget> pages;
  Widget currentPage;

  void initState() {
    _workoutPlanPage = StudentWorkoutPlanPage();
    _nutritionPlanPage = StudentNutritionPlanPage();
    _uploadPage = StudentUploadPage();
    _progressPage = StudentProgressPage();
    _inboxPage = InboxPage();

    pages = [
      _workoutPlanPage,
      _nutritionPlanPage,
      _uploadPage,
      _progressPage,
      _inboxPage,
    ];
    currentPage = _workoutPlanPage; //Always workouts will be displayed first

    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      drawer: TrainerDrawer(),
      appBar: AppBar(
        title: Text("Gymnopolis",
            style: TextStyle(fontFamily: "Signatra", fontSize: 35)),
      ),
      body: currentPage, //currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
 //       unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: true,

        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            currentPage = pages[index];
          });
        },
        //This prevents type to change to shifting
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(

              icon: new Icon(Icons.directions_bike),
              
                       title: Container(),
              ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.local_dining),
              title: Container(),
        //                title: new Text('Beslenme'),
              ),
          BottomNavigationBarItem(
              icon: new Icon(OMIcons.addBox),
              title: Container(),
            //            title: new Text('Upload'),
              ),
          BottomNavigationBarItem(
              icon: new Icon(OMIcons.showChart), 
              title: Container(),
        //         title: new Text('Progress'),
              ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: Container(),
        
     //                  title: new Text('Gelen Kutusu'),
              ),
        ],
      ),
    );
  }
}
