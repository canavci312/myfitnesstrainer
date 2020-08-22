import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfitnesstrainer/models/user.dart';
import 'package:myfitnesstrainer/viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _googleIleGiris(BuildContext context) async {
      final _userModel = Provider.of<UserModel>(context, listen: false);
      User _user = await _userModel.signInWithGoogle();
      if (_user != null) print("Oturum açan user id:" + _user.toString());
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Gymnopolis',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              icon: Icon(FontAwesomeIcons.google, color: Colors.white),
              label: Text('Google ile giriş yap',
                  style: TextStyle(color: Colors.white)),
              color: Colors.redAccent,
              onPressed: () {
                _googleIleGiris(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
