import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  String userID;
  String userName;
  String lastMessage;
  bool messageSeen;
  Contact({userID, userName, lastMessage, messageSeen});
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['lastMessage'] = lastMessage;

    return map;
  }

  Contact.fromMap(Map<String, dynamic> map) {
    this.userID = map['userID'];
    this.userName = map['userName'];
    this.lastMessage = map['lastMessage'];
    this.messageSeen = map['messageSeen'];
  }

}
