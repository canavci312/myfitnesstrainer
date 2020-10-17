import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfitnesstrainer/models/progress_photos.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/viewmodel/check_photos_hist_viewmodel.dart';
import 'package:provider/provider.dart';

class CheckPhotoHistory extends StatelessWidget {
  final _formatter = DateFormat.yMMMMd('tr');

  Widget build(BuildContext context) {
    final _studentPhotosPageViewModel =
        Provider.of<CheckPhotosHistoryViewModel>(context, listen: true);
    if (_studentPhotosPageViewModel.state == LoadState.Idle)
      return Scaffold(
        appBar: AppBar(title: Text(_studentPhotosPageViewModel.getName())),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<DateTime>(
                        value: _studentPhotosPageViewModel.selectedDate1,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (DateTime newValue) {
                          _studentPhotosPageViewModel
                              .selection1Changed(newValue);
                        },
                        items: _studentPhotosPageViewModel
                            .progressPhotosList.progressPhotosList
                            .map<DropdownMenuItem<DateTime>>(
                                (ProgressPhotos value) {
                          return DropdownMenuItem<DateTime>(
                            value: value.date,
                            child: Text(_formatter.format(value.date)),
                          );
                        }).toList(),
                      ),
                      DropdownButton<DateTime>(
                        value: _studentPhotosPageViewModel.selectedDate2,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (DateTime newValue) {
                          _studentPhotosPageViewModel
                              .selection2Changed(newValue);
                        },
                        items: _studentPhotosPageViewModel
                            .progressPhotosList.progressPhotosList
                            .map<DropdownMenuItem<DateTime>>(
                                (ProgressPhotos value) {
                          return DropdownMenuItem<DateTime>(
                            value: value.date,
                            child: Text(_formatter.format(value.date)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        _studentPhotosPageViewModel.mergePhotos();
                      },
                      child: Text(
                        "KARŞILAŞTIR",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
            Container(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _studentPhotosPageViewModel.firstFront ?? SizedBox(),
                  _studentPhotosPageViewModel.secondFront ?? SizedBox(),
                ],
              ),
            ),
            Container(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _studentPhotosPageViewModel.firstSide ?? SizedBox(),
                  _studentPhotosPageViewModel.secondSide ?? SizedBox(),
                ],
              ),
            ),
          ],
        ),
      );
    else {
      return LoadingScreen();
    }
  }
}
