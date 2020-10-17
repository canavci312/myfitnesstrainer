import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/viewmodel/check_measurement_hist_viewmodel.dart';
import 'package:provider/provider.dart';

class CheckMeasurementHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _checkMeasurementHistoryViewModel =
        Provider.of<CheckMeasurementHistoryViewModel>(context, listen: true);
    String _showDate(DateTime date) {
      var _formatter = DateFormat.yMMMMEEEEd('tr');
      var _formattedTime = _formatter.format(date);
      return _formattedTime;
    }

    String _monthDiff(DateTime date) {
      var _formatter = DateFormat.yMMMM('tr');
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

    return _checkMeasurementHistoryViewModel.state == LoadState.Idle
        ? Scaffold(
            appBar: AppBar(
              title: Text("Ölçüm Geçmişi"),
            ),
            body: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _checkMeasurementHistoryViewModel
                    .measurementLogs.measurementLogs.length,
                itemBuilder: (BuildContext context, int index) {
                  print(_monthDiff(_checkMeasurementHistoryViewModel
                      .measurementLogs.measurementLogs[index].date));
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 6,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
                            child: ExpandablePanel(
                                header: Text(_showDate(
                                    _checkMeasurementHistoryViewModel
                                        .measurementLogs
                                        .measurementLogs[index]
                                        .date)),
                                expanded: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Kilo: " +
                                          _checkMeasurementHistoryViewModel
                                              .measurementLogs
                                              .measurementLogs[index]
                                              .weight
                                              .toString()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Kol: " +
                                          _checkMeasurementHistoryViewModel
                                              .measurementLogs
                                              .measurementLogs[index]
                                              .arm
                                              .toString()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Bel: " +
                                          _checkMeasurementHistoryViewModel
                                              .measurementLogs
                                              .measurementLogs[index]
                                              .waist
                                              .toString()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Boyun: " +
                                          _checkMeasurementHistoryViewModel
                                              .measurementLogs
                                              .measurementLogs[index]
                                              .neck
                                              .toString()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Kalça: " +
                                          _checkMeasurementHistoryViewModel
                                              .measurementLogs
                                              .measurementLogs[index]
                                              .hip
                                              .toString()),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text("Boy: " +
                                          _checkMeasurementHistoryViewModel
                                              .measurementLogs
                                              .measurementLogs[index]
                                              .height
                                              .toString()),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                      index !=
                              _checkMeasurementHistoryViewModel
                                      .measurementLogs.measurementLogs.length -
                                  1
                          ? isDifferentMonth(
                                  _checkMeasurementHistoryViewModel
                                      .measurementLogs
                                      .measurementLogs[index]
                                      .date,
                                  _checkMeasurementHistoryViewModel
                                      .measurementLogs
                                      .measurementLogs[index + 1]
                                      .date)
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      24.0, 14, 14, 6),
                                  child: Text(
                                      _monthDiff(
                                          _checkMeasurementHistoryViewModel
                                              .measurementLogs
                                              .measurementLogs[index + 1]
                                              .date),
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
          )
        : LoadingScreen();
  }
}
