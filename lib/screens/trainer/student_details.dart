import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfitnesstrainer/models/nutrition_plan.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:intl/intl.dart';
import 'package:myfitnesstrainer/models/student_other_information.dart';
import 'package:myfitnesstrainer/models/workout_plan.dart';
import 'package:myfitnesstrainer/screens/common/coloredtab.dart';
import 'package:myfitnesstrainer/screens/trainer/assign_nutrition_plan.dart';
import 'package:myfitnesstrainer/screens/trainer/assign_workout_plan.dart';
import 'package:myfitnesstrainer/screens/trainer/create_nutrition_plan.dart';
import 'package:myfitnesstrainer/screens/trainer/create_workout_plan.dart';
import 'package:timeago/timeago.dart' as timeago;

class StudentDetails extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(icon: Icon(FontAwesomeIcons.infoCircle)),
    Tab(icon: Icon(FontAwesomeIcons.balanceScale)),
    Tab(icon: Icon(FontAwesomeIcons.dumbbell)),
    Tab(icon: Icon(FontAwesomeIcons.apple)),
  ];

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  StudentData studentData;
  StudentDetails(this.studentData);
  @override
  Widget build(BuildContext context) {
    WorkoutPlan workoutPlan = studentData.getWorkoutPlan;
    NutritionPlan nutritionPlan = studentData.nutritionPlan;
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    String firstDate =
        DateFormat("dd.MM.yyyy").format(studentData.lastMeasurement.date);
    String secondDate =
        DateFormat("dd.MM.yyyy").format(studentData.recentMeasurement.date);
    final now = new DateTime.now();
    final difference = now.difference(studentData.recentMeasurement.date);
    final daysAgo =
        timeago.format(DateTime.now().subtract(difference), locale: 'tr');
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text(studentData.getUser.name),
            bottom: ColoredTabBar(
              Colors.blue,
              TabBar(
                unselectedLabelColor: Colors.white,
                labelColor: Colors.amber,
                tabs: myTabs,
              ),
            ),
          ),
          body: TabBarView(children: [
            informationWidget(context),
            if (studentData.recentMeasurement.height != null)
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpandablePanel(
                  header: Text("Ölçümler",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  collapsed: studentData.recentMeasurement.height != null
                      ? Text("Son ölçüm güncellemesi: " + daysAgo)
                      : Text("Öğrenci hiç ölçüm girmedi"),
                  expanded: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Tarihler:"),
                                Text(firstDate),
                                Icon(Icons.arrow_forward),
                                Text(secondDate),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Kilo:"),
                                Text(studentData.lastMeasurement.weight
                                    .toString()),
                                Icon(Icons.arrow_forward),
                                Text(studentData.recentMeasurement.weight
                                    .toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Bel:"),
                                Text(studentData.lastMeasurement.waist
                                    .toString()),
                                Icon(Icons.arrow_forward),
                                Text(studentData.recentMeasurement.waist
                                    .toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Kol:"),
                                Text(
                                    studentData.lastMeasurement.arm.toString()),
                                Icon(Icons.arrow_forward),
                                Text(studentData.recentMeasurement.arm
                                    .toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Boyun:"),
                                Text(studentData.lastMeasurement.neck
                                    .toString()),
                                Icon(Icons.arrow_forward),
                                Text(studentData.recentMeasurement.neck
                                    .toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Kalça:"),
                                Text(
                                    studentData.lastMeasurement.hip.toString()),
                                Icon(Icons.arrow_forward),
                                Text(studentData.recentMeasurement.hip
                                    .toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.90,
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Boy:"),
                                Text(studentData.recentMeasurement.height
                                    .toString()),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: ListTile(
                        title: Text("Ölçümler",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        subtitle: Text("Öğrenci henüz ölçümlerini girmemiş"),
                      )),
                ),
              ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Antrenman Programı",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      if (workoutPlan.getName == null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text("Öğrenci Program Bekliyor!"),
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AssignWorkoutPlan(
                                                    studentData)));
                                  },
                                  child: Text("Program ver"),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AssignWorkoutPlan(studentData)));
                                },
                                child: Text("PROGRAMI DEĞİŞTİR",
                                    style: TextStyle(color: Colors.black)),
                                color: Colors.white),
                            RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateWorkoutPlanPage(
                                                studentData: studentData,
                                                workoutPlan:
                                                    studentData.getWorkoutPlan,
                                              )));
                                },
                                child: Text("PROGRAMI DÜZENLE",
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.blue),
                          ],
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            studentData.getWorkoutPlan.getWorkouts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return studentData.getWorkoutPlan.workouts[index].rest
                              ? Card(
                                  margin: EdgeInsets.all(10.0),
                                  child: ListTile(
                                      leading: Icon(Icons.airline_seat_flat),
                                      title: Text("Dinlenme günü")))
                              : Card(
                                  margin: EdgeInsets.all(10.0),
                                  child: ListTile(
                                    leading: Icon(Icons.fitness_center),
                                    title: ExpandablePanel(
                                      header: Text(studentData
                                          .getWorkoutPlan.workouts[index].name),
                                      collapsed: Text(
                                        studentData
                                                .getWorkoutPlan
                                                .workouts[index]
                                                .exerciseTargetsList
                                                .length
                                                .toString() +
                                            " adet egzersiz",
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      expanded: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: studentData
                                              .getWorkoutPlan
                                              .workouts[index]
                                              .exerciseTargetsList
                                              .length,
                                          itemBuilder: (BuildContext context,
                                              int index2) {
                                            return ListTile(
                                                title: Text(studentData
                                                    .getWorkoutPlan
                                                    .workouts[index]
                                                    .exerciseTargetsList[index2]
                                                    .exercise
                                                    .name),
                                                subtitle: Text(studentData
                                                    .getWorkoutPlan
                                                    .workouts[index]
                                                    .exerciseTargetsList[index2]
                                                    .toString()));
                                          }),
                                    ),
                                  ),
                                );
                        },
                      ),
                    ]),
              )),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Beslenme Programı",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      if (nutritionPlan.name == null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text("Öğrenci Program Bekliyor!"),
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AssignNutritionPlan(
                                                    studentData)));
                                  },
                                  child: Text("Program ver"),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AssignNutritionPlan(
                                                  studentData)));
                                },
                                child: Text("PROGRAMI DEĞİŞTİR",
                                    style: TextStyle(color: Colors.black)),
                                color: Colors.white),
                            RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateNutritionPlanPage(
                                                studentData: studentData,
                                                nutritionPlan:
                                                    studentData.nutritionPlan,
                                              )));
                                },
                                child: Text("PROGRAMI DÜZENLE",
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.blue),
                          ],
                        ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: studentData.nutritionPlan.meals.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: EdgeInsets.all(10.0),
                            child: ListTile(
                              leading: Icon(Icons.local_dining),
                              title: ExpandablePanel(
                                header: Text(
                                  studentData.nutritionPlan.meals[index].name
                                      .toUpperCase(),
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                collapsed: Text(
                                  studentData.nutritionPlan.meals[index].foods
                                          .length
                                          .toString() +
                                      " adet besin",
                                  softWrap: true,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                expanded: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: studentData.nutritionPlan
                                        .meals[index].foods.length,
                                    itemBuilder:
                                        (BuildContext context, int index2) {
                                      return ListTile(
                                          title: Text(studentData.nutritionPlan
                                              .meals[index].foods[index2].name),
                                          subtitle: Text(studentData
                                                  .nutritionPlan
                                                  .meals[index]
                                                  .foods[index2]
                                                  .quantity
                                                  .toString() +
                                              " " +
                                              studentData
                                                  .nutritionPlan
                                                  .meals[index]
                                                  .foods[index2]
                                                  .unit));
                                    }),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )))
          ])),
    );
  }

  Container informationWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Yaş: "),
                  Text(studentData.studentOtherInformation.birthday == null
                      ? "girilmemiş"
                      : calculateAge(
                              studentData.studentOtherInformation.birthday)
                          .toString()),
                ],
              ),
              Row(
                children: [
                  Text("Cinsiyet: "),
                  Text(studentData.studentOtherInformation.gender == null
                      ? "girilmemiş"
                      : studentData.studentOtherInformation.gender ==
                              Gender.Female
                          ? "Kadın"
                          : "Erkek"),
                ],
              ),
              Row(
                children: [
                  Text("Ekipman: "),
                  Text(studentData.studentOtherInformation.equipments != null
                      ? studentData.studentOtherInformation.equipments
                      : "girilmemiş")
                ],
              ),
              Row(
                children: [
                  Text("Öğrencinin hedefi: "),
                  Text(studentData.studentOtherInformation.goal == null
                      ? "girilmemiş"
                      : studentData.studentOtherInformation.goal ==
                              Goal.GainMuscle
                          ? "Kas kazanmak"
                          : studentData.studentOtherInformation.goal ==
                                  Goal.AtlethicPerformance
                              ? "Atletik Performans"
                              : studentData.studentOtherInformation.goal ==
                                      Goal.LoseFat
                                  ? "Yağ Yakmak"
                                  : "Güçlenmek")
                ],
              ),
              Row(
                children: [
                  Text("Haftalık antrenman günü sayısı: "),
                  Text(studentData.studentOtherInformation.availableDays == null
                      ? "girilmemiş"
                      : studentData.studentOtherInformation.availableDays
                          .toString()),
                ],
              ),
              Text("Son antrenman: "),
            ],
          ),
        ),
      ),
    );
  }
}
