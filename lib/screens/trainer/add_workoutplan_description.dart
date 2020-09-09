import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/viewmodel/create_workout_planviewmodel.dart';

class AddWorkoutPlanDescription extends StatelessWidget {
  CreateWorkoutPlanModel model;
  AddWorkoutPlanDescription(this.model);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String description = "";
    TextEditingController _editingController =
        TextEditingController(text: model.workoutPlan.description);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Antrenman Açıklaması"),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  model.saveDescription(_editingController.text);
                  Navigator.pop(context);
                } else
                  print(false);
              })
        ],
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _editingController,
                  decoration: InputDecoration(
                    hintText: "Açıklamalarınızı giriniz",
                  ),
                  scrollPadding: EdgeInsets.all(20.0),
                  keyboardType: TextInputType.multiline,
                  maxLines: 99999,
                  autofocus: true,
                  onChanged: (value) {
                    description = value;
                  },
                  validator: (value) {
                    if (value.length < 1) {
                      return "Lütfen Açıklama giriniz";
                    } else
                      return null;
                  },
                )
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomPadding: true,
    );
  }
}
