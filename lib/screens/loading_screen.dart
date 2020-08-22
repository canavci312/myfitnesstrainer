import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
          body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}