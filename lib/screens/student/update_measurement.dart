import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnesstrainer/models/measurement.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:provider/provider.dart';

class UpdateMeasurement extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _weightController;
  TextEditingController _waistController;
  TextEditingController _armController;
  bool first = true;
  TextEditingController _neckController;
  TextEditingController _hipController;
  TextEditingController _heightController;
  @override
  Widget build(BuildContext context) {
    final _studentModel = Provider.of<StudentDataModel>(context, listen: true);

    Measurement recentMeasurement = _studentModel.studentData.recentMeasurement;
    if (first) {
      _weightController = TextEditingController(
          text: recentMeasurement.weight == null
              ? "60"
              : recentMeasurement.weight.toString());
      _armController = TextEditingController(
          text: recentMeasurement.arm == null
              ? "30"
              : recentMeasurement.weight.toString());
      _waistController = TextEditingController(
          text: recentMeasurement.waist == null
              ? "60"
              : recentMeasurement.waist.toString());
      _neckController = TextEditingController(
          text: recentMeasurement.neck == null
              ? "30"
              : recentMeasurement.neck.toString());
      _hipController = TextEditingController(
          text: recentMeasurement.hip == null
              ? "100"
              : recentMeasurement.hip.toString());
      _heightController = TextEditingController(
          text: recentMeasurement.height == null
              ? "170"
              : recentMeasurement.height.toString());
      first = false;
    }

    if (_studentModel.state == StudentDataState.Idle)
      return Scaffold(
        appBar: AppBar(
          title: Text("Ölçümlerini Kaydet"),
          actions: [
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Measurement measurement = Measurement(
                        height: double.parse(_heightController.text),
                        waist: double.parse(_waistController.text),
                        date: DateTime.now(),
                        hip: double.parse(_hipController.text),
                        neck: double.parse(_neckController.text),
                        weight: double.parse(_weightController.text),
                        arm: double.parse(_armController.text));
                    _studentModel.handleMeasurementUpdate(measurement);
                    Navigator.pop(context);
                  }
                })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kilo(kg)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: TextFormField(
                        validator: (value) {
                          if (value == "" || double.parse(value) <= 20) {
                            return "Geçersiz değer";
                          } else
                            return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        controller: _weightController,
                        decoration: InputDecoration(),
                        //       textAlign: TextAlign.center,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Bel(cm)",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: TextFormField(
                        validator: (value) {
                          if (value == "" || double.parse(value) <= 0) {
                            return "Geçerli bir değer giriniz";
                          } else
                            return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        controller: _waistController,
                        decoration: InputDecoration(),
                        //          textAlign: TextAlign.center,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Kol(cm)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: TextFormField(
                        validator: (value) {
                          if (value == "" || double.parse(value) <= 10) {
                            return "Geçerli bir değer giriniz";
                          } else
                            return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        controller: _armController,
                        decoration: InputDecoration(),
                        //       textAlign: TextAlign.center,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Boyun(cm)",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: TextFormField(
                        validator: (value) {
                          if (value == "" || double.parse(value) <= 0) {
                            return "Geçersiz değer";
                          } else
                            return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        controller: _neckController,
                        decoration: InputDecoration(),
                        //        textAlign: TextAlign.center,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Kalça(cm)",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: TextFormField(
                        validator: (value) {
                          if (value == "" || double.parse(value) <= 0) {
                            return "Geçersiz değer";
                          } else
                            return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        controller: _hipController,
                        decoration: InputDecoration(),
                        //         textAlign: TextAlign.center,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Boy(cm)",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: TextFormField(
                        validator: (value) {
                          if (value == "" || double.parse(value) <= 0) {
                            return "Geçersiz değer";
                          } else
                            return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                        controller: _heightController,
                        decoration: InputDecoration(),
                        //         textAlign: TextAlign.center,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    else {
      return LoadingScreen();
    }
  }
}
