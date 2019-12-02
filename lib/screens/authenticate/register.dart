import 'package:flutter/material.dart';
import 'package:owl_book/services/auth.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  // text field state
  String email = '';
  String password = '';
  String phone='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 15.0),

              TextFormField(
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SFUIDisplay'
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.person_outline),
                    labelStyle: TextStyle(
                        fontSize: 15
                    )
                ),
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                obscureText: true,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SFUIDisplay'
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    labelStyle: TextStyle(
                        fontSize: 15
                    )
                ),
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                obscureText: true,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SFUIDisplay'
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    labelStyle: TextStyle(
                        fontSize: 15
                    )
                ),
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                obscureText: true,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SFUIDisplay'
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.lock_outline),
                    labelStyle: TextStyle(
                        fontSize: 15
                    )
                ),
                onChanged: (val) {
                  setState(() => phone = val);
                },
              ),
              SizedBox(height: 10.0,),
              MaterialButton(
                onPressed: () async {
                  print(email);
                  print(password);
                  print(phone);
                },
                child: Text('SIGN UP',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFUIDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Color(0xffc12026),
                elevation: 0,
                minWidth: 400,
                height: 50,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),


            ],
          ),
        ),
      ),
    );


  }
}

//Container(
//padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//child: RaisedButton(
//child: Text('sign in anon'),
//onPressed: () async {
//dynamic result = await _auth.signInAnon();
//if(result == null){
//print('error signing in');
//} else {
//print('signed in');
//print(result.uid);
//}
//},
//),
//),