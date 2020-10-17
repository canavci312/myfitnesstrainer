import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/screens/common/coloredtab.dart';
import 'package:myfitnesstrainer/viewmodel/exercise_statistics_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/student_exercise_sessions_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class ExerciseDetails extends StatelessWidget {
  final Exercise _exercise;
  ExerciseDetails(this._exercise);
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Bilgiler'),
    Tab(text: "Geçmiş"),
    Tab(text: "İstatistikler"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_exercise.name),
          bottom: ColoredTabBar(
            Colors.blue,
            TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.amber,
              tabs: myTabs,
            ),
          ),
          leading: InkWell(
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: TabBarView(
          children: [
            About(_exercise),
            Sessions(_exercise),
            Statistics(_exercise)
          ],
        ),
      ),
    );
  }
}

class About extends StatelessWidget {
  final Exercise _exercise;
  About(this._exercise);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text("Ana çalışan bölge : ",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(_exercise.mainMuscle)
        ]),
        Row(children: <Widget>[
          Text("Gerekli ekipmanlar : ",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(_exercise.equipment)
        ]),
        Row(children: <Widget>[
          Text("Egzersiz türü : ",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(_exercise.type)
        ]),
        new Text("Nasıl Yapılır?",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          child: new Column(
            children: <Widget>[
              _exercise.description == null
                  ? Text("Henüz bir açıklama eklenmemiş :( ",
                      style: TextStyle(fontSize: 15), textAlign: TextAlign.left)
                  : Text(_exercise.description,
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left),
            ],
          ),
        ),
      ],
    );
  }
}

class Sessions extends StatelessWidget {
  String calculateDaysAgo(DateTime time) {
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    final now = new DateTime.now();
    final difference = now.difference(time);
    return timeago.format(DateTime.now().subtract(difference), locale: 'tr');
  }

  final Exercise _exercise;
  Sessions(this._exercise);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StudentExerciseSessionsViewModel>(
        create: (context) => StudentExerciseSessionsViewModel(_exercise),
        child: Consumer<StudentExerciseSessionsViewModel>(
            builder: (context, oldLogsVM, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: oldLogsVM.dates.length > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: oldLogsVM.exerciseLogsList.length,
                        itemBuilder: (BuildContext context, int workoutIndex) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                  calculateDaysAgo(
                                      oldLogsVM.dates[workoutIndex]),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: oldLogsVM
                                      .exerciseLogsList[workoutIndex]
                                      .setLogs
                                      .length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        padding: EdgeInsets.all(8),
                                        child: oldLogsVM
                                                    .exerciseLogsList[
                                                        workoutIndex]
                                                    .setLogs[index]
                                                    .duration ==
                                                null
                                            ? oldLogsVM
                                                        .exerciseLogsList[
                                                            workoutIndex]
                                                        .setLogs[index]
                                                        .weight !=
                                                    0
                                                ? Text(
                                                    "Set " +
                                                        (index + 1).toString() +
                                                        ", " +
                                                        oldLogsVM
                                                            .exerciseLogsList[
                                                                workoutIndex]
                                                            .setLogs[index]
                                                            .weight
                                                            .toString() +
                                                        " kg " +
                                                        oldLogsVM
                                                            .exerciseLogsList[
                                                                workoutIndex]
                                                            .setLogs[index]
                                                            .reps
                                                            .toString() +
                                                        " tekrar",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.0,
                                                    ),
                                                  )
                                                : Text(
                                                    "Set " +
                                                        (index + 1).toString() +
                                                        ", " +
                                                        oldLogsVM
                                                            .exerciseLogsList[
                                                                workoutIndex]
                                                            .setLogs[index]
                                                            .reps
                                                            .toString() +
                                                        " tekrar",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.0,
                                                    ))
                                            : oldLogsVM
                                                        .exerciseLogsList[
                                                            workoutIndex]
                                                        .setLogs[index]
                                                        .weight !=
                                                    0
                                                ? Text(
                                                    "Set " +
                                                        (index + 1).toString() +
                                                        ", " +
                                                        oldLogsVM
                                                            .exerciseLogsList[
                                                                workoutIndex]
                                                            .setLogs[index]
                                                            .weight
                                                            .toString() +
                                                        " kg " +
                                                        oldLogsVM
                                                            .exerciseLogsList[
                                                                workoutIndex]
                                                            .setLogs[index]
                                                            .duration
                                                            .toString() +
                                                        " saniye",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.0,
                                                    ))
                                                : Text(
                                                    "Set " +
                                                        (index + 1).toString() +
                                                        ", " +
                                                        oldLogsVM
                                                            .exerciseLogsList[
                                                                workoutIndex]
                                                            .setLogs[index]
                                                            .duration
                                                            .toString() +
                                                        " saniye",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.0,
                                                    )));
                                  },
                                ),
                              ),
                            ),
                          );
                        })
                    : Card(
                        child: ListTile(
                        title: Text("Egzersiz Geçmişi",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                        subtitle: Text("Egzersiz geçmişiniz bulunmamaktadır."),
                      ))),
          );
        }));
  }
}

class Statistics extends StatelessWidget {
  final Exercise _exercise;
  Statistics(this._exercise);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExerciseStatisticsViewModel>(
        create: (context) => ExerciseStatisticsViewModel(_exercise),
        child: Consumer<ExerciseStatisticsViewModel>(
            builder: (context, oldLogsVM, child) {
          return oldLogsVM.durationBased
              ? Column(
                  children: [
                    ListTile(
                        leading: Icon(MaterialCommunityIcons.trophy),
                        title: Text("En iyi setiniz")),
                    ListTile(title: Text("Maksimum 1 tekrar ağırlık")),
                    ListTile(
                        leading: Icon(MaterialIcons.timer,
                            size: 20, color: Colors.blueGrey),
                        title: Text("En uzun hareket süresi")),
                    ListTile(title: Text("Toplam kaldırılan ağırlık")),
                    ListTile(title: Text("Toplam harcanan süre")),
                    ListTile(title: Text("Toplam set")),
                  ],
                )
              : Column(
                  children: [
                    ListTile(
                        leading: Icon(MaterialCommunityIcons.trophy,
                            color: Color.fromRGBO(189, 139, 40, 90)),
                        title: Text("En iyi setiniz")),
                    ListTile(
                        leading: Icon(MaterialCommunityIcons.medal,
                            color: Colors.blue),
                        title: Text("Maksimum 1 tekrar ağırlık")),
                    ListTile(
                      leading: Icon(MaterialCommunityIcons.dumbbell,
                          size: 20, color: Colors.brown),
                      title: Text(
                        "Toplam kaldırılan ağırlık",
                      ),
                      subtitle: Text(oldLogsVM.totalWeight.toString() + " kg"),
                    ),
                    ListTile(
                      leading: Icon(
                        Feather.repeat,
                        color: Colors.teal,
                      ),
                      title: Text("Toplam set"),
                      subtitle: Text(oldLogsVM.totalSets.toString()),
                    ),
                    ListTile(
                      leading: Icon(MaterialCommunityIcons.replay,
                          color: Colors.deepPurple),
                      title: Text("Toplam tekrar"),
                      subtitle: Text(oldLogsVM.totalReps.toString()),
                    ),
                    ListTile(
                      leading:
                          Icon(Entypo.add_to_list, color: Colors.green[600]),
                      title: Text("Yapılan Antrenman Sayısı"),
                      subtitle: Text(
                          oldLogsVM.exerciseLogsWithDateList.length.toString()),
                    ),
                  ],
                );
        }));
  }
}
