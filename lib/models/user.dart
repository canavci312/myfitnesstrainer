import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String userID;
  bool trainer = false;
  bool admin = false;
  String name = "";
  DateTime createdAt;
  String imageUrl = "";
  String email = "";
  User(
      {this.userID,
      this.trainer,
      this.admin,
      this.name,
      this.createdAt,
      this.imageUrl,
      this.email});

  User.setFromMap(Map<String, dynamic> map) {
    if (map != null) {
      userID = map['userID'];
      email = map['email'];
      name = map['name'];
      imageUrl = map['imageUrl'];
      admin = map['admin'];
      trainer = map['trainer'];
      createdAt = (map['createdAt'] as Timestamp).toDate();
    }
  }
  /*firestoreStudentList() {
    List<Map<String, dynamic>> convertedStudentList = [];
    if (students != null&&students.length>0) {
      students.forEach((student) {
        User thisUser = student;
        convertedStudentList.add(thisUser.toMap());
      });
      return convertedStudentList;
    }
    else return null;
  }*/

  bool set(User user2) {
    this.userID = user2.userID;
    this.trainer = user2.trainer;
    this.admin = user2.admin;
    this.name = user2.name;
    this.createdAt = user2.createdAt;

    this.imageUrl = user2.imageUrl;

    return true;
  }

  Map<String, dynamic> toMapWithoutTimeStamp() {
    return {
      'userID': userID,
      'email': email,
      'name': name,
      'imageUrl': imageUrl ??
          'https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72x72.png',
      'admin': admin ?? false,
      'trainer': trainer ?? false,
    };
  }

  User.setFromMapWithoutTimeStamp(Map<String, dynamic> map) {
    if (map != null) {
      userID = map['userID'];
      email = map['email'];
      name = map['name'];
      imageUrl = map['imageUrl'];
      admin = map['admin'];
      trainer = map['trainer'];
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'name': name,
      'imageUrl': imageUrl ??
          'https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72x72.png',
      'admin': admin ?? false,
      'trainer': trainer ?? false,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  @override
  String toString() {
    var str = '';
    if (userID != null)
      str = "UserID= " +
          userID +
          "  UserName= " +
          name +
          "  trainer" +
          trainer.toString() +
          " email " +
          email +
          " admin " +
          admin.toString();
    return str;
    //       "students"+students.toString()
    //      +"coach"+coach.toString();
  }
}
