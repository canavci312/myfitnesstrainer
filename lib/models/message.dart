import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sentTo;
  final String sentFrom;
  final String message;
  final Timestamp date;

  Message({this.sentTo, this.sentFrom, this.message, this.date});
  Map<String, dynamic> toMap() {
    return {
      'sentTo': sentTo,
      'sentFrom': sentFrom,
      'message': message,
      'date': date ?? FieldValue.serverTimestamp()
    };
  }

  Message.fromMap(Map<String, dynamic> map)
      : this.sentTo = map['sentTo'],
        this.sentFrom = map['sentFrom'],
        this.message = map['message'],
        this.date = map['date'] ;
}
