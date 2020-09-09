import 'package:myfitnesstrainer/models/contact.dart';

class ContactList {
  List<Contact> contacts;

  ContactList() {
    contacts = [];
  }
  Map<String, dynamic> toMap() {
    return {
      'contacts': firestoreWorkoutPlansList(),
    };
  }

  ContactList.fromMap(Map<String, dynamic> map) {
    var list = map['contacts'] as List;
    List<Contact> contactList = list.map((i) => Contact.fromMap(i)).toList();

    this.contacts = contactList;
  }
  firestoreWorkoutPlansList() {
    List<Map<String, dynamic>> convertedContactList = [];
    if (contacts != null) {
      this.contacts.forEach((element) {
        Contact thisContact = element;
        convertedContactList.add(thisContact.toMap());
      });
    }
    return convertedContactList;
  }
}
