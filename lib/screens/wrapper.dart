import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticte.dart';
import 'package:owl_book/models/user.dart';
import 'Home/home.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user=Provider.of<User>(context);

    print(user);
    // return either home or authenticates
    if(user==null){
      return Authenticate();
    }
    else
    {
      return Home1();
    }
  }
}