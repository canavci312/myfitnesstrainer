import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfitnesstrainer/models/message.dart';
import 'package:myfitnesstrainer/screens/loading_screen.dart';
import 'package:myfitnesstrainer/viewmodel/student_data.viewmodel.dart';
import 'package:provider/provider.dart';

class StudentChatPage extends StatelessWidget {
  const StudentChatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _animationDuration = Duration(milliseconds: 300);
    final _textController = TextEditingController();
    final _studentDataModel = Provider.of<StudentDataModel>(context);
    final _scrollController = ScrollController();
    void _onPressed() async {
      if (_textController.text.trim().length > 0) {
        Message _messageSent = Message(
            sentFrom: _studentDataModel.studentData.getUser.userID,
            sentTo: _studentDataModel.studentData.getCoach.userID,
            message: _textController.text);
        var result = await _studentDataModel.saveMessage(_messageSent);
        if (result) {
          _textController.clear();
          _scrollController.animateTo(0.0,
              curve: Curves.easeOut, duration: Duration(microseconds: 10));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: Row(children: [
        CircleAvatar(
            backgroundImage:
                NetworkImage(_studentDataModel.studentData.getCoach.imageUrl)),
        SizedBox(
          width: 10,
        ),
        Text(_studentDataModel.studentData.getCoach.name)
      ])),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<Message>>(
            stream: _studentDataModel.getMessages(
                _studentDataModel.studentData.getUser.userID,
                _studentDataModel.studentData.getCoach.userID),
            builder: (context, streamMessages) {
              if (!streamMessages.hasData) {
                return LoadingScreen();
              } else {
                return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return _chatIconDesign(
                          streamMessages.data[index], _studentDataModel);
                    },
                    itemCount: streamMessages.data.length);
              }
            },
          )),
          IconTheme(
              data: IconThemeData(color: Theme.of(context).accentColor),
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: <Widget>[
                    Flexible(
                        child: TextField(
                            controller: _textController,
                            // onSubmitted: _onSubmitted,
                            decoration: InputDecoration.collapsed(
                                hintText: "Mesaj gönder"))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Theme.of(context).platform == TargetPlatform.iOS
                            ? CupertinoButton(
                                child: Text("Send"), onPressed: _onPressed)
                            : IconButton(
                                icon: Icon(Icons.send), onPressed: _onPressed))
                  ]),
                  decoration: Theme.of(context).platform == TargetPlatform.iOS
                      ? BoxDecoration(
                          border:
                              Border(top: BorderSide(color: Colors.grey[200])))
                      : null))
        ],
      ),
    );
  }
}

Widget _chatIconDesign(Message message, StudentDataModel _studentDataModel) {
  Color recievedMessageColor = Colors.grey[350];
  Color sentMessageColor = Colors.blue;
  var time = "";
  try {
    time = _showTime(message.date ?? Timestamp(1, 1));
  } catch (e) {
    print("hata var" + e.toString());
  }
  if (message.sentFrom == _studentDataModel.studentData.getUser.userID) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50, 8, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      color: sentMessageColor,
                      borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(4),
                  child: Text(message.message,
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              Text(time),
            ],
          )
        ],
      ),
    );
  } else {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 50, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      color: recievedMessageColor,
                      borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(4),
                  child: Text(message.message,
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              Text(time),
            ],
          )
        ],
      ),
    );
  }
}

String _showTime(Timestamp date) {
  var _formatter = DateFormat.Hm();
  var _formattedTime = _formatter.format(date.toDate());
  return _formattedTime;
}
