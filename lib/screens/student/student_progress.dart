import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/student_other_information.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/viewmodel/measurement_logs_viewmodel.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StudentProgressPage extends StatefulWidget {
  @override
  _StudentProgressPageState createState() => _StudentProgressPageState();
}

class _StudentProgressPageState extends State<StudentProgressPage> {
  final StudentDataModel _studentDataModel = locator<StudentDataModel>();
  bool loading = true;
  final MeasurementLogsModel _measurementLogsModel =
      locator<MeasurementLogsModel>();

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  List<WeightChartData> listWeight;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  double log10(num x) => log(x) / ln10;

  double _bmi;

  double _bodyFat;

  double calculateBodyMassIndex() {
    _bmi = roundDouble(
        _studentDataModel.studentData.recentMeasurement.weight /
            pow(_studentDataModel.studentData.recentMeasurement.height / 100,
                2),
        2);
    return _bmi;
  }

  Widget getBMIResult() {
    if (_bmi >= 25) {
      return Text('Kilolu',
          style: TextStyle(color: Colors.yellow, fontSize: 30));
    } else if (_bmi > 18.5) {
      return Text('Normal',
          style: TextStyle(color: Colors.green, fontSize: 30));
    } else {
      return Text('Zayıf',
          style: TextStyle(color: Colors.yellow, fontSize: 30));
    }
  }

  Widget getBodyFatResult() {
    if (_studentDataModel.studentData.studentOtherInformation.gender ==
        Gender.Male) {
      if (_bodyFat >= 25) {
        return Text('Obez', style: TextStyle(color: Colors.red, fontSize: 30));
      } else if (_bodyFat >= 18 && _bodyFat <= 24) {
        return Text('Ortalama',
            style: TextStyle(color: Colors.black, fontSize: 30));
      } else {
        return Text('Fit', style: TextStyle(color: Colors.green, fontSize: 30));
      }
    } else {
      if (_bodyFat >= 32) {
        return Text('Obez', style: TextStyle(color: Colors.red, fontSize: 30));
      } else if (_bodyFat >= 25 && _bodyFat <= 31) {
        return Text('Ortalama',
            style: TextStyle(color: Colors.black, fontSize: 30));
      } else {
        return Text('Fit', style: TextStyle(color: Colors.green, fontSize: 30));
      }
    }
  }

  _getSeriesData() {
    List<charts.Series<WeightChartData, DateTime>> series = [
      charts.Series(
        id: "Weight",
        data: listWeight,
        domainFn: (WeightChartData series, _) => series.date,
        measureFn: (WeightChartData series, _) => series.weight,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      )
    ];
    return series;
  }

  double calculateBodyFat() {
    if (_studentDataModel.studentData.studentOtherInformation.gender ==
        Gender.Male)
      _bodyFat = roundDouble(
          ((495.0 /
                  (1.0324 -
                      0.19077 *
                          log10(_studentDataModel
                                  .studentData.recentMeasurement.waist -
                              _studentDataModel
                                  .studentData.recentMeasurement.neck) +
                      0.15456 *
                          log10(_studentDataModel
                              .studentData.recentMeasurement.height))) -
              450),
          2);
    else
      _bodyFat = roundDouble(
          (495.0 /
                  (1.29579 -
                      0.35004 *
                          log10(_studentDataModel
                                  .studentData.recentMeasurement.waist +
                              _studentDataModel
                                  .studentData.recentMeasurement.hip -
                              _studentDataModel
                                  .studentData.recentMeasurement.neck) +
                      0.22100 *
                          log10(_studentDataModel
                              .studentData.recentMeasurement.height))) -
              450,
          2);
    return _bodyFat;
  }

  @override
  void initState() {
    listWeight = [];

    _measurementLogsModel.allMeasurements.measurementLogs.forEach((element) {
      String string = dateFormat.format(element.date);
      DateTime dateTime = dateFormat.parse(string);
      listWeight.add(WeightChartData(dateTime, element.weight));
    });
    calculateBodyFat();
    calculateBodyMassIndex();
    loading = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen
        : Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Text("Yağ%",
                              style: TextStyle(
                                  fontSize: 60, color: Colors.black87)),
                          Text(_bodyFat.toString(),
                              style: TextStyle(
                                  fontSize: 60, color: Colors.black87)),
                          getBodyFatResult(),
                        ],
                      ),
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text("VKİ",
                              style: TextStyle(
                                  fontSize: 60, color: Colors.black87)),
                          Text(_bmi.toString(),
                              style: TextStyle(
                                  fontSize: 60, color: Colors.black87)),
                          getBMIResult(),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        "Kilo Değişimi",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                          height: 200.0,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: charts.TimeSeriesChart(
                              _getSeriesData(),
                              animate: false,
                              dateTimeFactory: LocalizedDateTimeFactory(
                                  Localizations.localeOf(context)),
                              primaryMeasureAxis: charts.NumericAxisSpec(
                                  tickProviderSpec:
                                      charts.BasicNumericTickProviderSpec(
                                          zeroBound: false)),
                              domainAxis: charts.DateTimeAxisSpec(
                                  tickFormatterSpec:
                                      charts.AutoDateTimeTickFormatterSpec(
                                          day: charts.TimeFormatterSpec(
                                format: 'dd MMMM',
                                transitionFormat: 'dd MMMM',
                              ))),
                            ),
                          )),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}

class WeightChartData {
  DateTime date;
  double weight;
  WeightChartData(this.date, this.weight);
}

class LocalizedDateTimeFactory extends charts.LocalDateTimeFactory {
  final Locale locale;

  @override
  DateFormat createDateFormat(String pattern) {
    return DateFormat(pattern, locale.languageCode);
  }

  LocalizedDateTimeFactory(this.locale);
}
