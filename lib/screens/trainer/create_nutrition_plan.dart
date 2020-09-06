import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/food.dart';
import 'package:myfitnesstrainer/models/meal.dart';
import 'package:myfitnesstrainer/models/nutrition_plan.dart';
import 'package:myfitnesstrainer/models/student_data.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';

import 'package:myfitnesstrainer/viewmodel/create_meal_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/create_nutrition_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:provider/provider.dart';

enum Mode { EDITING, NEW, ASSIGNING }

class CreateNutritionPlanPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Mode _state;

  NutritionPlan nutritionPlan;
  StudentData studentData;
  CreateNutritionPlanPage({this.nutritionPlan, this.studentData}) {
    if (nutritionPlan == null)
      _state = Mode.NEW;
    else {
      if (studentData == null)
        _state = Mode.EDITING;
      else
        _state = Mode.ASSIGNING;
    }
  }
  bool isExec = false;
  TextEditingController _editingController;

  @override
  // ignore: must_call_super

  // ignore: must_call_super

  Widget _editTitleTextField(
      CreateNutritionPlanModel createNutritionPlanModel) {
    if (!isExec) {
      _editingController =
          TextEditingController(text: createNutritionPlanModel.name);
    }
    isExec = true;
    if (createNutritionPlanModel.state == EditState.Idle)
      return Center(
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          showCursor: true,
          cursorColor: Colors.black,
          decoration: InputDecoration(hintText: "Program ismi"),
          onChanged: (newValue) {
            createNutritionPlanModel.updateName(newValue.toString());
          },
          validator: (value) {
            if (value.length < 1) return "Beslenme Programı ismini giriniz";
            if (value.length > 30)
              return "İsim çok uzun";
            else
              return null;
          },
          autofocus: false,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          createNutritionPlanModel.editStarted();
        },
        child: Text(
          createNutritionPlanModel.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }

  handleDismiss(
      CreateNutritionPlanModel createNutritionPlanModel, Meal meal, int index) {
    // Get a reference to the swiped item
    Meal copy = meal;
    // Remove it from the list
    createNutritionPlanModel.removeMeal(meal);

    _scaffoldKey.currentState
        .showSnackBar(
          SnackBar(
            content: Text("Silindi. Geri almak ister misiniz?"),
            duration: Duration(seconds: 5),
            action: SnackBarAction(
                label: "Geri Al",
                textColor: Colors.yellow,
                onPressed: () {
                  // Deep copy the email

                  // Insert it at swiped position and set state
                  createNutritionPlanModel.addMealIndex(copy, index);
                }),
          ),
        )
        .closed
        .then((reason) {
      if (reason != SnackBarClosedReason.action) {
        // The SnackBar was dismissed by some other means
        // that's not clicking of action button
        // Make API call to backend

      }
    });
  }

  Widget build(BuildContext context) {
    TrainerDataModel trainerDataModel = locator<TrainerDataModel>();
    return ChangeNotifierProvider(
        create: (context) =>
            CreateNutritionPlanModel(nutritionPlan: nutritionPlan),
        child: Consumer<CreateNutritionPlanModel>(
            builder: (context, createNutritionPlanModel, child) {
          if (createNutritionPlanModel.loadState == LoadState.Idle)
            return Form(
              key: _formKey,
              autovalidate: false,
              child: Scaffold(
                  key: _scaffoldKey,
                  appBar: AppBar(
                    title: _editTitleTextField(createNutritionPlanModel),
                    actions: <Widget>[
                      createNutritionPlanModel.state == EditState.Editing
                          ? Text("")
                          : IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  //      createWorkoutPlanModel.workoutPlan.creator =
                                  //          userModel.user;

                                  createNutritionPlanModel.loadState =
                                      LoadState.Loading;
                                  if (_state == Mode.NEW) {
                                    createNutritionPlanModel.nutritionPlan
                                        .meals = createNutritionPlanModel.meals;

                                    trainerDataModel.addNutrition(
                                        createNutritionPlanModel.nutritionPlan);
                                    Navigator.pop(context);
                                  } else if (_state == Mode.EDITING) {
                                    createNutritionPlanModel.nutritionPlan
                                        .meals = createNutritionPlanModel.meals;

                                    trainerDataModel.updateNutrition();
                                    Navigator.pop(context);
                                  } else {
                                    trainerDataModel.assignNutritionPlan(
                                        nutritionPlan, studentData);
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                  }
                                  //                     createWorkoutPlanModel.saveWorkoutPlan();
                                }
                              },
                            )
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            itemCount: createNutritionPlanModel.meals.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final meal =
                                  createNutritionPlanModel.meals[index];
                              return GestureDetector(
                                  onTap: () {},
                                  child: Dismissible(
                                    key: UniqueKey(),
                                    background: Container(
                                      color: Colors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.delete,
                                                color: Colors.white),
                                            Text('Sil',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    secondaryBackground: Container(
                                      color: Colors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(Icons.delete,
                                                color: Colors.white),
                                            Text('Sil',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onDismissed: (DismissDirection direction) {
                                      handleDismiss(createNutritionPlanModel,
                                          meal, index);
                                    },
                                    /*handleDismiss(
                                    createWorkoutPlanModel,
                                    workout,
                                    index,
                                  ),*/

                                    /*      (direction) {
                                    createWorkoutPlanModel.removeWorkout(workout);
                                  },*/
                                    child: Card(
                                        child: ChangeNotifierProvider(
                                            create: (context) =>
                                                CreateMealViewModel(meal),
                                            child:
                                                Consumer<CreateMealViewModel>(
                                                    builder: (context,
                                                        createMealViewModel,
                                                        child) {
                                              return Column(
                                                children: [
                                                  ListTile(
                                                      title: Text(
                                                          createMealViewModel
                                                              .meal.name),
                                                      subtitle:
                                                          ListView.builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  createMealViewModel
                                                                      .meal
                                                                      .foods
                                                                      .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return ListTile(
                                                                    title: Text(createMealViewModel
                                                                        .meal
                                                                        .foods[
                                                                            index]
                                                                        .name),
                                                                    subtitle: Text(createMealViewModel
                                                                            .meal
                                                                            .foods[
                                                                                index]
                                                                            .quantity
                                                                            .toString() +
                                                                        " " +
                                                                        createMealViewModel
                                                                            .meal
                                                                            .foods[
                                                                                index]
                                                                            .unit),
                                                                    trailing:
                                                                        Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            String
                                                                                name =
                                                                                createMealViewModel.meal.foods[index].name;
                                                                            double
                                                                                quantity =
                                                                                createMealViewModel.meal.foods[index].quantity;
                                                                            String
                                                                                unit =
                                                                                createMealViewModel.meal.foods[index].unit;
                                                                            final _formKey =
                                                                                GlobalKey<FormState>();
                                                                            print("food count " +
                                                                                createMealViewModel.meal.foods[index].name);
                                                                            final value = await showDialog(
                                                                                context: context,
                                                                                builder: (context) => SingleChildScrollView(
                                                                                        child: Container(
                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                      child: AlertDialog(
                                                                                        title: new Text('Besini Düzenle'),
                                                                                        content: Form(
                                                                                          key: _formKey,
                                                                                          child: Container(
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.min,
                                                                                              children: [
                                                                                                TextFormField(
                                                                                                  initialValue: name,
                                                                                                  decoration: InputDecoration(hintText: "Besin adı örn Elma", labelText: "Adı", border: OutlineInputBorder()),
                                                                                                  onChanged: (value) {
                                                                                                    name = value;
                                                                                                  },
                                                                                                  validator: (value) {
                                                                                                    if (value == "") {
                                                                                                      return "Geçersiz değer";
                                                                                                    } else
                                                                                                      return null;
                                                                                                  },
                                                                                                ),
                                                                                                TextFormField(
                                                                                                  initialValue: quantity.toString(),
                                                                                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                                                  validator: (value) {
                                                                                                    if (value == "" || double.parse(value) <= 0) {
                                                                                                      return "Geçersiz değer";
                                                                                                    } else
                                                                                                      return null;
                                                                                                  },
                                                                                                  inputFormatters: [
                                                                                                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                                                                                                  ],
                                                                                                  decoration: InputDecoration(hintText: "Miktarı(birimsiz) Örn 200", labelText: "Miktar", border: OutlineInputBorder()),
                                                                                                  onChanged: (value) {
                                                                                                    quantity = double.parse(value);
                                                                                                  },
                                                                                                ),
                                                                                                TextFormField(
                                                                                                  initialValue: unit,
                                                                                                  decoration: InputDecoration(hintText: "örn: adet/gr/litre", labelText: "Birim", border: OutlineInputBorder()),
                                                                                                  onChanged: (value) {
                                                                                                    unit = value;
                                                                                                  },
                                                                                                  validator: (value) {
                                                                                                    if (value == "") {
                                                                                                      return "Geçersiz değer";
                                                                                                    } else
                                                                                                      return null;
                                                                                                  },
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        actions: <Widget>[
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                            children: [
                                                                                              new GestureDetector(
                                                                                                onTap: () => Navigator.of(context).pop(),
                                                                                                child: Text("İPTAL"),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          RaisedButton(
                                                                                              color: Colors.blue,
                                                                                              onPressed: () {
                                                                                                if (_formKey.currentState.validate()) {
                                                                                                  createMealViewModel.updateFood(createMealViewModel.meal.foods[index], Food(name: name, quantity: quantity, unit: unit));
                                                                                                  Navigator.of(context).pop();
                                                                                                }
                                                                                              },
                                                                                              child: Text("ONAYLA", style: TextStyle(color: Colors.white))),
                                                                                        ],
                                                                                      ),
                                                                                    )));
                                                                            if (value ==
                                                                                true) {
                                                                              Navigator.of(context).pop();
                                                                            }
                                                                          },
                                                                          child:
                                                                              Icon(Icons.edit),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            createMealViewModel.removeFood(meal.foods[index]);
                                                                          },
                                                                          child:
                                                                              Icon(Icons.delete),
                                                                        ),
                                                                      ],
                                                                    ));
                                                              })),
                                                  Card(
                                                      child: GestureDetector(
                                                    onTap: () async {
                                                      String name = "";
                                                      double quantity;
                                                      String unit = "";
                                                      final _formKey =
                                                          GlobalKey<
                                                              FormState>();
                                                      final value =
                                                          await showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  SingleChildScrollView(
                                                                      child:
                                                                          Container(
                                                                    padding: EdgeInsets.only(
                                                                        bottom: MediaQuery.of(context)
                                                                            .viewInsets
                                                                            .bottom),
                                                                    child:
                                                                        AlertDialog(
                                                                      title: new Text(
                                                                          'Besin ekle'),
                                                                      content:
                                                                          Form(
                                                                        key:
                                                                            _formKey,
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              TextFormField(
                                                                                decoration: InputDecoration(hintText: "Besin adı örn Elma", labelText: "Adı", border: OutlineInputBorder()),
                                                                                onChanged: (value) {
                                                                                  name = value;
                                                                                },
                                                                                validator: (value) {
                                                                                  if (value == "") {
                                                                                    return "Geçersiz değer";
                                                                                  } else
                                                                                    return null;
                                                                                },
                                                                              ),
                                                                              TextFormField(
                                                                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                                                validator: (value) {
                                                                                  if (value == "" || double.parse(value) <= 0) {
                                                                                    return "Geçersiz değer";
                                                                                  } else
                                                                                    return null;
                                                                                },
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                                                                                ],
                                                                                decoration: InputDecoration(hintText: "Miktarı(birimsiz) Örn 200", labelText: "Miktar", border: OutlineInputBorder()),
                                                                                onChanged: (value) {
                                                                                  quantity = double.parse(value);
                                                                                },
                                                                              ),
                                                                              TextFormField(
                                                                                decoration: InputDecoration(hintText: "örn: adet/gr/litre", labelText: "Birim", border: OutlineInputBorder()),
                                                                                onChanged: (value) {
                                                                                  unit = value;
                                                                                },
                                                                                validator: (value) {
                                                                                  if (value == "") {
                                                                                    return "Geçersiz değer";
                                                                                  } else
                                                                                    return null;
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      actions: <
                                                                          Widget>[
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            new GestureDetector(
                                                                              onTap: () => Navigator.of(context).pop(),
                                                                              child: Text("İPTAL"),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        RaisedButton(
                                                                            color: Colors
                                                                                .blue,
                                                                            onPressed:
                                                                                () {
                                                                              if (_formKey.currentState.validate()) {
                                                                                createMealViewModel.addFood(Food(name: name, quantity: quantity, unit: unit));
                                                                                Navigator.of(context).pop();
                                                                              }
                                                                            },
                                                                            child:
                                                                                Text("ONAYLA", style: TextStyle(color: Colors.white))),
                                                                      ],
                                                                    ),
                                                                  )));
                                                      if (value == true) {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: ListTile(
                                                        leading:
                                                            Icon(Icons.add),
                                                        title: Text(
                                                            "Yeni besin ekle")),
                                                  )),
                                                ],
                                              );
                                            }))),
                                  ));
                            }),
                        GestureDetector(
                          onTap: () async {
                            final _formKey = GlobalKey<FormState>();
                            String name = "";
                            final value = await showDialog(
                              context: context,
                              builder: (context) => Form(
                                key: _formKey,
                                child: new AlertDialog(
                                  title: new Text('Öğün adı giriniz'),
                                  content: TextFormField(
                                    decoration: InputDecoration(),
                                    onChanged: (value) {
                                      name = value;
                                    },
                                    validator: (value) {
                                      if (value == "") {
                                        return "Ad boş olamaz";
                                      } else
                                        return null;
                                    },
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        new GestureDetector(
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                          child: Text("İPTAL"),
                                        ),
                                      ],
                                    ),
                                    RaisedButton(
                                        color: Colors.blue,
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            createNutritionPlanModel
                                                .addMeal(name);
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Text("ONAYLA",
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ],
                                ),
                              ),
                            );
                            if (value == true) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Card(
                            child: ListTile(
                                leading: Icon(Icons.add),
                                title: Text("Yeni öğün ekle")),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          else
            return LoadingScreen();
        }));
  }
}
