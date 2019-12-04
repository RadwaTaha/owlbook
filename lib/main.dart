
import 'package:flutter/material.dart';
import 'package:owl_book/services/auth.dart';
import 'package:provider/provider.dart';
import 'screens/wrapper.dart';
import 'models/user.dart';
import 'screens/authenticate/register.dart';
import 'signUp.dart';
//import 'profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}