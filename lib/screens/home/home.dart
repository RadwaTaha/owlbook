import 'package:flutter/material.dart';
import 'package:owl_book/services/auth.dart';
class Home1 extends StatelessWidget {

  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('main screen'),
        actions: <Widget>[
           FloatingActionButton(
            onPressed: () async{
              // Add your onPressed code here!
              await _auth.signOut();
            },
            child: Icon(Icons.power_settings_new),
            backgroundColor: Colors.blue,

          ),
        ],
      ),
    );
  }
}