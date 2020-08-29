import 'package:flutter/cupertino.dart';
import 'package:myfitnesstrainer/models/student_other_information.dart';

class UpdateOtherInformationViewModel extends ChangeNotifier {
  StudentOtherInformation studentOtherInformation = StudentOtherInformation();
  double sliderValue = 0;
  UpdateOtherInformationViewModel() {
    studentOtherInformation.availableDays = 3;
    studentOtherInformation.dailyActivity = DailyActivity.Inactive;
    studentOtherInformation.equipments = "";
    studentOtherInformation.gender = Gender.Male;
    studentOtherInformation.goal = Goal.LoseFat;
  }
  changeSliderValue(double value) {
    sliderValue = value;
    notifyListeners();
  }

  setAvilableDays(int value) {
    studentOtherInformation.availableDays = value;
    notifyListeners();
  }

  updateDailyActivity() {
    if (sliderValue > 33)
      studentOtherInformation.dailyActivity = DailyActivity.Inactive;
    else if (sliderValue > 33 && sliderValue < 66)
      studentOtherInformation.dailyActivity = DailyActivity.Normal;
    else
      studentOtherInformation.dailyActivity = DailyActivity.Active;
    notifyListeners();
  }

  setGoal(Goal goal) {
    studentOtherInformation.goal = goal;
    notifyListeners();
  }

  setGender(Gender gender) {
    studentOtherInformation.gender = gender;
    notifyListeners();
  }

  setEquipments(String equipments) {
    studentOtherInformation.equipments = equipments;
    notifyListeners();
  }

  setBirthday(DateTime birthday) {
    studentOtherInformation.birthday = birthday;
    notifyListeners();
  }
}
