
import 'package:flutter/material.dart';
import 'package:owl_book/services/auth.dart';
import 'package:provider/provider.dart';
import 'screens/wrapper.dart';
import 'models/user.dart';
//import 'screens/authenticate/register.dart';
//import 'signUp.dart';
import 'screens/home/profile.dart';
import 'screens/home/profile2.dart';

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