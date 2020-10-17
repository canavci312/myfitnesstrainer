import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfitnesstrainer/screens/student/student_chat_page.dart';
import 'package:myfitnesstrainer/screens/student/student_drawer.dart';
import 'package:myfitnesstrainer/screens/student/student_nutrition_plan.dart';
import 'package:myfitnesstrainer/screens/student/student_progress.dart';
import 'package:myfitnesstrainer/screens/student/student_upload.dart';
import 'package:myfitnesstrainer/screens/student/student_workout_plan.dart';
import 'package:myfitnesstrainer/screens/student/workout_description.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';

import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StudentHomePage extends StatefulWidget {
  createState() {
    return StudentHomePageState();
  }
}

@override
class StudentHomePageState extends State<StudentHomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int _currentIndex = 0;
  StudentNutritionPlanPage _nutritionPlanPage;
  StudentWorkoutPlanPage _workoutPlanPage;
  StudentUploadPage _uploadPage;
  StudentProgressPage _progressPage;
  StudentChatPage _inboxPage;
  List<Widget> pages;
  Widget currentPage;

  void initState() {
    _workoutPlanPage = StudentWorkoutPlanPage();
    _nutritionPlanPage = StudentNutritionPlanPage();
    _uploadPage = StudentUploadPage();
    _progressPage = StudentProgressPage();
    _inboxPage = StudentChatPage();

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
    final _studentModel = Provider.of<StudentDataModel>(context, listen: true);
    void _onLoading() async {
      // monitor network fetch
      // if failed,use loadFailed(),if no data return,use LoadNodata()
      print("burdayımm");
      _refreshController.loadComplete();
    }

    void _onRefresh() async {
      // monitor network fetch
      await _studentModel.getStudentData();
      // if failed,use refreshFailed()

      _refreshController.refreshCompleted();
    }

    return Scaffold(
      drawer: StudentDrawer(),
      appBar: currentPage == _inboxPage
          ? null
          : AppBar(
              title: Text("Spor Hocam",
                  style: TextStyle(fontFamily: "Signatra", fontSize: 35)),
              actions: [
                currentPage == _workoutPlanPage
                    ? IconButton(
                        icon: Icon(FontAwesomeIcons.infoCircle),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkoutDescriptionPage(
                                    _studentModel.studentData.getWorkoutPlan)),
                          );
                        })
                    : Container(),
              ],
            ),
      body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: currentPage), //currentPage,
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
