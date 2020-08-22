import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:provider/provider.dart';

class StudentWorkoutPlanPage extends StatelessWidget {
  const StudentWorkoutPlanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentDataModel>(builder: (context, studentDataModel, child) {
      if(studentDataModel.studentData.getCoach.userID==null){
        return Center(child:RaisedButton(onPressed: () {
          studentDataModel.assignCoach();
        },
        child: Text("Koç edin"),));
      }
      else if(studentDataModel.studentData.getCoach.userID!=null&&studentDataModel.studentData.getWorkoutPlan.name==null)
      {
        return Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Hoşgeldiniz!"),
            Text("Antenörünüz en kısa süre içinde programınızı hazırlayacaktır...",textAlign: TextAlign.center,)
          ],
        ));
      }
      else{
        return Container(color:Colors.green);
      }
      
      
    
  });
}
}