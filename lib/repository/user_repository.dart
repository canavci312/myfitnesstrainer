import 'package:myfitnesstrainer/locator.dart';
import 'package:myfitnesstrainer/models/message.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/services/auth_base.dart';
import 'package:myfitnesstrainer/services/auth_service.dart';
import 'package:myfitnesstrainer/services/firestore_services.dart';

class UserRepository implements AuthBase {
  AuthService _firebaseAuthService = locator<AuthService>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();

  @override
  Future<User> currentUser() async {
    User _user = await _firebaseAuthService.currentUser();
    if (_user != null) {
      return await _firestoreDBService.readUser(_user.userID);
    } else
      return null;
  }

  Future<User> signInWithGoogle() async {
    User _user = await _firebaseAuthService
        .signInWithGoogle(); //id emaili dışında hiçbişey belli değil
    if (_user != null) {
      _user = await _firestoreDBService.saveUser(_user);
      if (_user != null) {
        return _user;
      } else {
        await _firebaseAuthService.signOut();
        return null;
      }
    } else
      return null;
  }

  @override
  Future<bool> signOut() async {
    return await _firebaseAuthService.signOut();
  }

}
