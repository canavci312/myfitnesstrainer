import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/student/update_measurement.dart';

class StudentUploadPage extends StatelessWidget {
  const StudentUploadPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UpdateMeasurement()),
        );
      },
      child: Text("Ölçümlerimi güncelle"),
    ));
  }
}
