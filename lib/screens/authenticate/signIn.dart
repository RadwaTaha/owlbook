import 'package:flutter/material.dart';
import 'package:owl_book/services/auth.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[

              SizedBox(height: 30.0),
              TextFormField(
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person_outline),
                      labelStyle: TextStyle(
                          fontSize: 15
                      )
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
                  }
              ),
              SizedBox(height: 20.0),
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
              SizedBox(height: 20.0),
              MaterialButton(
                onPressed: () async{
                  print(email);
                  print(password);
                },//since this is only a UI app
                child: Text('SIGN IN',
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
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Colors.black,
                                fontSize: 15,
                              )
                          ),

                          TextSpan(
                              text: "sign up",
                              style: TextStyle(
                                fontFamily: 'SFUIDisplay',
                                color: Color(0xffc12026),
                                fontSize: 15,
                              )
                          )
                        ]
                    ),
                  ),

                ),

              ),
              FlatButton(
                color: Colors.white,
                textColor: Color(0xffc12026),
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.white,
                onPressed: () {
                  /*...*/
                  widget.toggleView();

                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: 'SFUIDisplay',
                    color: Color(0xffc12026),
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );


  }
}
