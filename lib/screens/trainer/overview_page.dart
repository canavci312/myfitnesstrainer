import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/trainer/student_details.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _trainerModel = Provider.of<TrainerDataModel>(context, listen: true);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _trainerModel.trainerData.studentList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StudentDetails(
                                                _trainerModel.trainerData.studentList[index]
                                              )
                                        ));
            },
                      child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(_trainerModel
                    .trainerData.studentList[index].getUser.imageUrl),
              ),
              title:
                  Text(_trainerModel.trainerData.studentList[index].getUser.name),
              subtitle: _trainerModel
                          .trainerData.studentList[index].getWorkoutPlan.name ==
                      null
                  ? Text("Öğrenci program bekliyor")
                  : Text(_trainerModel
                      .trainerData.studentList[index].getWorkoutPlan.name),
            ),
          );
        });
  }
}
