import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/student/workout_history.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class StudentDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    final _studentModel = Provider.of<StudentDataModel>(context, listen: true);
    final _allWorkoutLog =
        Provider.of<AllWorkoutLogsModel>(context, listen: true);
    print(userModel.user.toString());
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            accountEmail: Text(userModel.user.email),
            accountName: Text(userModel.user.name),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                userModel.user.imageUrl,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorkoutHistoryPage()),
              );
            },
            child: ListTile(
              leading: Icon(Icons.history),
              title: Text('Antrenman Geçmişi'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Ölçüm Geçmişi'),
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Eğitmenler'),
          ),
          GestureDetector(
            onTap: () {
              _studentModel.reset();
              _allWorkoutLog.reset();
              userModel.signOut();
            },
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Çıkış yap'),
                )),
          )
        ],
      ),
    );
  }
}
