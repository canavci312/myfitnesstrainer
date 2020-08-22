import 'package:flutter/material.dart';

class ExerciseListTile extends StatelessWidget {
  String name;
  final bool isChecked;
  final Function checkboxCallback;

  ExerciseListTile({this.name, this.isChecked, this.checkboxCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: checkboxCallback,
      ),
      onTap: () {},
    );
  }
}
