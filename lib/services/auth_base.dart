import 'package:myfitnesstrainer/models/user.dart';

abstract class AuthBase {
  Future<User> currentUser();
  Future<bool> signOut();
  Future<User> signInWithGoogle();
}
