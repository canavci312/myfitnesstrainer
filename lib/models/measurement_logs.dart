import 'package:myfitnesstrainer/models/measurement.dart';

class MeasurementLogs {
  List<Measurement> measurementLogs;
  MeasurementLogs() {
    measurementLogs = [];
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['measurementLogs'] = firestoreExerciseLogs();

    return map;
  }

  MeasurementLogs.fromMap(Map<String, dynamic> map) {
    if (map != null) {
      var list = map['measurementLogs'] as List;
      if (list != null) {
        List<Measurement> measurementLogsList =
            list.map((i) => Measurement.fromMap(i)).toList();
        this.measurementLogs = measurementLogsList;
      }
    }
  }

  firestoreExerciseLogs() {
    List<Map<String, dynamic>> convertedMeasurementLogsList = [];
    if (measurementLogs != null)
      this.measurementLogs.forEach((element) {
        Measurement thisMeasurementLogs = element;
        convertedMeasurementLogsList.add(thisMeasurementLogs.toMap());
      });
    return convertedMeasurementLogsList;
  }
}
