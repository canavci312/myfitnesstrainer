import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:myfitnesstrainer/screens/student/student_image_upload.dart';
import 'package:myfitnesstrainer/screens/student/update_measurement.dart';
import 'package:myfitnesstrainer/screens/student/update_other_information.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:provider/provider.dart';

class StudentUploadPage extends StatelessWidget {
  const StudentUploadPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _studentData = Provider.of<StudentDataModel>(context, listen: true);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Text("Bilgilerim: ", style: TextStyle(fontSize: 25))),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child:
                      Icon(Icons.check_circle, color: Colors.green, size: 50)),
              Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateOtherInformation()),
                    );
                  },
                  child: Text(
                    "DEĞİŞTİR",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child: Text("Ölçümlerim: ", style: TextStyle(fontSize: 25))),
              DateTime.now()
                          .difference(
                              _studentData.studentData.recentMeasurement.date)
                          .inDays <
                      7
                  ? Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Icon(Icons.check_circle,
                          color: Colors.green, size: 50))
                  : Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Icon(Ionicons.ios_alert,
                          color: Colors.red, size: 50)),
              DateTime.now()
                          .difference(
                              _studentData.studentData.recentMeasurement.date)
                          .inDays >
                      7
                  ? Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateMeasurement()),
                          );
                        },
                        child: Text("GÜNCELLE",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  : Flexible(fit: FlexFit.tight, flex: 2, child: SizedBox())
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  fit: FlexFit.tight,
                  flex: 2,
                  child:
                      Text("Fotoğraflarım: ", style: TextStyle(fontSize: 25))),
              _studentData.studentData.studentActivity.lastPhoto != null &&
                      DateTime.now()
                              .difference(_studentData
                                  .studentData.studentActivity.lastPhoto)
                              .inDays <
                          7
                  ? Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Icon(Icons.check_circle,
                          color: Colors.green, size: 50))
                  : Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Icon(Ionicons.ios_alert,
                          color: Colors.red, size: 50)),
              DateTime.now()
                          .difference(_studentData
                              .studentData.studentActivity.lastPhoto)
                          .inDays >
                      7
                  ? Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentImageUpload()),
                          );
                        },
                        child: Text("GÜNCELLE",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  : Flexible(fit: FlexFit.tight, flex: 2, child: SizedBox())
            ],
          ),
        ),
      ],
    );
  }
}
