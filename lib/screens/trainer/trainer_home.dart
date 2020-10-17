import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/trainer/chat_list_page.dart';
import 'package:myfitnesstrainer/screens/trainer/create_nutrition_plan.dart';
import 'package:myfitnesstrainer/screens/trainer/create_workout_plan.dart';
import 'package:myfitnesstrainer/screens/trainer/nutrition_plans_page.dart';
import 'package:myfitnesstrainer/screens/trainer/overview_page.dart';
import 'package:myfitnesstrainer/screens/trainer/trainer_drawer.dart';
import 'package:myfitnesstrainer/screens/trainer/workout_plans_page.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TrainerHomePage extends StatefulWidget {
  createState() {
    return TrainerHomePageState();
  }
}

@override
class TrainerHomePageState extends State<TrainerHomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int _currentIndex = 0;
  OverviewPage _overviewPage;
  NutritionPlansPage _nutritionPlansPage;
  WorkoutPlansPage _workoutPlansPage;
  ChatListPage _inboxPage;
  List<Widget> pages;
  Widget currentPage;

  List<String> pageNames;
  void initState() {
    _overviewPage = OverviewPage();
    _nutritionPlansPage = NutritionPlansPage();
    _workoutPlansPage = WorkoutPlansPage();
    _inboxPage = ChatListPage();

    pages = [
      _overviewPage,
      _nutritionPlansPage,
      _workoutPlansPage,
      _inboxPage,
    ];

    pageNames = ['Oveview', 'Workout Plans', 'Inbox Page'];
    currentPage = _overviewPage; //Always workouts will be displayed first

    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    final _trainerModel = Provider.of<TrainerDataModel>(context, listen: true);
    void _onLoading() async {
      // monitor network fetch
      // if failed,use loadFailed(),if no data return,use LoadNodata()
      print("burdayımm");
      _refreshController.loadComplete();
    }

    void _onRefresh() async {
      // monitor network fetch
      await _trainerModel.getTrainerData();
      // if failed,use refreshFailed()

      _refreshController.refreshCompleted();
    }

    return Scaffold(
      drawer: TrainerDrawer(),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateNutritionPlanPage()));
              },
              child: Icon(Icons.add),
            )
          : _currentIndex == 2
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateWorkoutPlanPage()));
                  },
                  child: Icon(Icons.add),
                )
              : null,

      appBar: AppBar(
        title: Text("uygulama adı",
            style: TextStyle(fontFamily: "Signatra", fontSize: 35)),
      ),

      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: currentPage), //currentPage,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            currentPage = pages[index];
          });
        },
        type: BottomNavigationBarType.fixed,
        //This prevents type to change to shifting
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(icon: new Icon(Icons.home), title: Container()
              //         title: new Text('Antrenman'),
              ),
          BottomNavigationBarItem(
              icon: new Icon(Icons.local_dining), title: Container()
              //         title: new Text('Antrenman'),
              ),
          BottomNavigationBarItem(
              icon: new Icon(OMIcons.fitnessCenter), title: Container()
              //          title: new Text('Upload'),
              ),
          BottomNavigationBarItem(icon: new Icon(Icons.mail), title: Container()
              //         title: new Text('Gelen Kutusu'),
              ),
        ],
      ),
    );
  }
}
