import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/models/exercise.dart';
import 'package:myfitnesstrainer/screens/common/coloredtab.dart';

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
        backgroundColor: Colors.white,
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
        Row(children:<Widget>[Text("Ana çalışan bölge : ",style: TextStyle(fontWeight: FontWeight.bold)) ,Text(_exercise.mainMuscle)]),

        Row(children:<Widget>[Text("Gerekli ekipmanlar : ",style: TextStyle(fontWeight: FontWeight.bold)) ,Text(_exercise.equipment)]),

        Row(children:<Widget>[Text("Egzersiz türü : ",style: TextStyle(fontWeight: FontWeight.bold)) ,Text(_exercise.type)]),

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
  final Exercise _exercise;
  Sessions(this._exercise);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Statistics extends StatelessWidget {
  final Exercise _exercise;
  Statistics(this._exercise);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}