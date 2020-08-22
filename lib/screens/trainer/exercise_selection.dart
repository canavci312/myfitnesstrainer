import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/exercise_targets.dart';
import 'package:myfitnesstrainer/screens/trainer/custom_search_delegate.dart';
import 'package:myfitnesstrainer/screens/trainer/exercise_listtile.dart';
import 'package:myfitnesstrainer/viewmodel/exercice_checkbox_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/exercises_viewmodel.dart';
import 'package:provider/provider.dart';

class ExerciseSelection extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /* List<String> exerciseType = [
    "Hepsi",
    "Güç",
    "Streç",
    "Kardiyo",
    "Powerlifting",
    "Olimpik Ağırlık Kaldırma"
  ];
  List<String> mainMuscle = [
    "Hepsi",
    "Göğüs",
    "Üst bacak",
    "Karın",
    "Kardiyo",
    "Alt bacak",
    "Kalça",
    "Omuz",
    "Sırt",
    "Biceps",
    "Triceps",
    "Önkol"
  ];
  List<String> equipment = [
    "Hepsi",
    "Vücut Ağırlığı",
    "Dambıl",
    "Direnç Bandı",
    "Barfiks",
    "Spor Salonu"
  ];*/

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExerciseViewModel(),
      child: Consumer<ExerciseViewModel>(
          builder: (context, exerciseViewModel, child) {
        return FutureBuilder(
            future: exerciseViewModel.loadExercises(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Scaffold(
                    floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.check),
                        onPressed: () {
                          List<ExerciseTargets> exerciseTargets = [];
                          exerciseViewModel.checkedList.forEach((element) {
                            exerciseTargets
                                .add(ExerciseTargets(exercise: element));
                            print(element);
                          });
                          Navigator.pop(context, exerciseTargets);
                        }),
                    key: _scaffoldKey,
                    appBar: AppBar(
                      title: Text("Egzersiz Listesi"),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                  exerciseViewModel, _scaffoldKey),
                            );
                          },
                        ),
                      ],
                    ),
                    body: Column(
                      children: [
                        /*           Container(
                          child: Row(children: [
                            DropdownButton<String>(
                              items: exerciseType.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                            DropdownButton<String>(
                              items: mainMuscle.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                            DropdownButton<String>(
                              items: equipment.map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (_) {},
                            ),
                          ]),
                        ),*/
                        Expanded(
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: exerciseViewModel.allExercises.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ChangeNotifierProvider(
                                  create: (context) =>
                                      ExerciseCheckboxViewModel(
                                          exerciseViewModel.allExercises,
                                          exerciseViewModel.checkedList),
                                  child: Consumer<ExerciseCheckboxViewModel>(
                                      builder: (context,
                                          exerciseCheckboxViewModel, child) {
                                    return ExerciseListTile(
                                      name: exerciseCheckboxViewModel
                                          .allExercises[index].name,
                                      isChecked: exerciseCheckboxViewModel
                                          .checkedList
                                          .contains(exerciseViewModel
                                              .allExercises[index]),
                                      checkboxCallback: (checkboxState) {
                                        exerciseCheckboxViewModel
                                            .toogleCheckList(
                                                exerciseViewModel
                                                    .allExercises[index],
                                                _scaffoldKey,
                                                context);
                                      },
                                    );
                                  }),
                                );
                              }),
                        ),
                      ],
                    ));
              } else {
                return Scaffold(
                    appBar: AppBar(title: Text("Egzersiz Listesi")),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Egzersizler yükleniyor lütfen bekleyiniz"),
                          CircularProgressIndicator()
                        ],
                      ),
                    ));
              }
            });
      }),
    );
  }
}
