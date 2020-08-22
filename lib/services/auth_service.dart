import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/services/auth_base.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthService implements AuthBase {
  FirebaseAuth _auth;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;
  String name;
  String email;
  String imageUrl;
  Status _status = Status.Uninitialized;

  AuthService.instance()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn() {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;
  Future<FirebaseUser> getUser() async {
    return (await _auth.currentUser());
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      return false;
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      AuthResult result = await _auth.signInWithCredential(credential);
      _user = result.user;
      return _userFromFirebase(_user);
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      return null;
    }
  }

  Future<bool> signOut() async {
    _auth.signOut();
    _googleSignIn.signOut();
    _status = Status.Unauthenticated;
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
  }

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return User(
          userID: user.uid,
          email: user.email,
          name: user.displayName,
          imageUrl: user.photoUrl);
    }
  }

  @override
  Future<User> currentUser() async {
    var firebaseuser = await _auth.currentUser();
    return _userFromFirebase(firebaseuser);
  }
}
