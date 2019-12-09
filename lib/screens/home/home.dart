import 'package:flutter/material.dart';
import 'package:owl_book/screens/home/BookOwnerProfile.dart';
import 'package:owl_book/services/auth.dart';
import 'HomePage.dart';
import 'maps.dart';
class Home1 extends StatelessWidget {

  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Maps(),
    );
  }
}