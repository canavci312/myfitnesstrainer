import 'package:flutter/material.dart';
import 'package:myfitnesstrainer/screens/trainer/trainer_chat_page.dart';
import 'package:myfitnesstrainer/viewmodel/trainer_data_viewmodel.dart';
import 'package:provider/provider.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _trainerDataModel = Provider.of<TrainerDataModel>(context);
    var studentList = _trainerDataModel.trainerData.studentList;
    return ListView.builder(
      itemCount: studentList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TrainerChatPage(studentList[index])));
          },
          child: ListTile(
            title: Text(studentList[index].getUser.name),
          ),
        );
      },
    );
  }
}
