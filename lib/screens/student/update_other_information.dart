import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myfitnesstrainer/models/measurement.dart';
import 'package:myfitnesstrainer/models/student_other_information.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/update_other_info_viewmodel.dart';
import 'package:provider/provider.dart';

class UpdateOtherInformation extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _equipmentController;

  @override
  Widget build(BuildContext context) {
    final _studentModel = Provider.of<StudentDataModel>(context, listen: true);

    _equipmentController = TextEditingController(text: "");
    if (_studentModel.state == StudentDataState.Idle)
      return ChangeNotifierProvider(
          create: (context) => UpdateOtherInformationViewModel(),
          child: Consumer<UpdateOtherInformationViewModel>(
              builder: (context, updateOtherInformationViewModel, child) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Bilgilerini Kaydet"),
                  actions: [
                    IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          updateOtherInformationViewModel.updateDailyActivity();
                          _studentModel.updateOtherInformation(
                              updateOtherInformationViewModel
                                  .studentOtherInformation);
                          Navigator.pop(context);
                        })
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Hedefiniz: "),
                            DropdownButton<Goal>(
                                value: updateOtherInformationViewModel
                                    .studentOtherInformation.goal,
                                onChanged: (Goal newValue) {
                                  updateOtherInformationViewModel
                                      .setGoal(newValue);
                                },
                                items: Goal.values.map((Goal classType) {
                                  return DropdownMenuItem<Goal>(
                                      value: classType,
                                      child: Text(classType ==
                                              Goal.AtlethicPerformance
                                          ? "Atletik Performans"
                                          : classType == Goal.GettingStronger
                                              ? "Güçlenmek"
                                              : classType == Goal.GainMuscle
                                                  ? "Kas kazanmak"
                                                  : "Yağ Yakmak"));
                                }).toList()),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Cinsiyetiniz: "),
                            DropdownButton<Gender>(
                                value: updateOtherInformationViewModel
                                    .studentOtherInformation.gender,
                                onChanged: (Gender newValue) {
                                  updateOtherInformationViewModel
                                      .setGender(newValue);
                                },
                                items: Gender.values.map((Gender classType) {
                                  return DropdownMenuItem<Gender>(
                                      value: classType,
                                      child: Text(classType == Gender.Male
                                          ? "Erkek"
                                          : "Kadın"));
                                }).toList()),
                          ],
                        ),
                        Text("Aktivite Seviyeniz:"),
                        Slider(
                          value: updateOtherInformationViewModel.sliderValue,
                          min: 0,
                          max: 100,
                          divisions: 4,
                          label: updateOtherInformationViewModel.sliderValue <
                                  33
                              ? "Günün çoğunda oturuyorum"
                              : updateOtherInformationViewModel.sliderValue <
                                          66 &&
                                      updateOtherInformationViewModel
                                              .sliderValue >
                                          33
                                  ? "Genelde hareketliyim"
                                  : "Yerimde duramıyorum!",
                          onChanged: (double value) {
                            updateOtherInformationViewModel
                                .changeSliderValue(value);
                          },
                        ),
                        Text("Haftada kaç gün antrenman yapabilirsiniz?"),
                        Slider(
                          value: updateOtherInformationViewModel
                              .studentOtherInformation.availableDays
                              .toDouble(),
                          min: 1,
                          max: 6,
                          divisions: 5,
                          label: updateOtherInformationViewModel
                              .studentOtherInformation.availableDays
                              .toString(),
                          onChanged: (double value) {
                            updateOtherInformationViewModel
                                .setAvilableDays(value.toInt());
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("Doğum tarihiniz: "),
                            GestureDetector(
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime(2000),
                                        firstDate: DateTime(1920),
                                        lastDate: DateTime(2010))
                                    .then((value) =>
                                        updateOtherInformationViewModel
                                            .setBirthday(value));
                              },
                              child: Text(updateOtherInformationViewModel
                                          .studentOtherInformation.birthday ==
                                      null
                                  ? "seçiniz"
                                  : DateFormat("dd.MM.yyyy")
                                      .format(updateOtherInformationViewModel
                                          .studentOtherInformation.birthday)
                                      .toString()),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              "Ekipmanlarınız: ",
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        TextField(
                          autofocus: false,
                          onChanged: (value) {
                            updateOtherInformationViewModel
                                .setEquipments(value);
                          },
                          decoration: InputDecoration(
                              hintText:
                                  "Örn:Spor salonu, barfiks barı veya sadece vücut ağırlığı"),
                        )
                      ],
                    ),
                  ),
                ));
          }));
    else {
      return LoadingScreen();
    }
  }
}
