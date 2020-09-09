import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfitnesstrainer/screens/student/workout_log_summary.dart';
import 'package:myfitnesstrainer/screens/student/workout_summary.dart';
import 'package:myfitnesstrainer/viewmodel/all_workout_logs_viewmodel.dart';
import 'package:provider/provider.dart';

class MeasurementHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _showDate(DateTime date) {
      var _formatter = DateFormat.yMMMMEEEEd();
      var _formattedTime = _formatter.format(date);
      return _formattedTime;
    }

    String _monthDiff(DateTime date) {
      var _formatter = DateFormat.yMMMM();
      var _formattedTime = _formatter.format(date);
      return _formattedTime;
    }

    bool isDifferentMonth(DateTime date1, DateTime date2) {
      var firstDate = _monthDiff(date1);
      var secondDate = _monthDiff(date2);
      if (secondDate == firstDate) {
        return false;
      } else {
        return true;
      }
    }

    final _allWorkoutLogs =
        Provider.of<AllWorkoutLogsModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Antrenman Geçmişi"),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _allWorkoutLogs.allWorkoutLogs.workoutLogs.length,
          itemBuilder: (BuildContext context, int index) {
            print(_monthDiff(
                _allWorkoutLogs.allWorkoutLogs.workoutLogs[index].date));
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkoutLogSummary(
                                _allWorkoutLogs
                                    .allWorkoutLogs.workoutLogs[index])),
                      );
                    },
                    child: Card(
                        child: ListTile(
                      title: Text(_allWorkoutLogs
                          .allWorkoutLogs.workoutLogs[index].workoutName),
                      subtitle: Text(_showDate(_allWorkoutLogs
                          .allWorkoutLogs.workoutLogs[index].date)),
                    )),
                  ),
                ),
                index != _allWorkoutLogs.allWorkoutLogs.workoutLogs.length - 1
                    ? isDifferentMonth(
                            _allWorkoutLogs
                                .allWorkoutLogs.workoutLogs[index].date,
                            _allWorkoutLogs
                                .allWorkoutLogs.workoutLogs[index + 1].date)
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(24.0, 14, 14, 6),
                            child: Text(
                                _monthDiff(_allWorkoutLogs.allWorkoutLogs
                                    .workoutLogs[index + 1].date),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600)),
                          )
                        : SizedBox()
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
