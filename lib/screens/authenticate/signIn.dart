import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owl_book/services/auth.dart';
import 'package:owl_book/shared/loading.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;
  // text field state
  String email = '';
  String password = '';
  String error= '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

      body: 
      Container(       
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'Assets/logo.png',
              ),

              SizedBox(height: 30.0),
              TextFormField(
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',
                      prefixIcon: Icon(Icons.person_outline),
                      labelStyle: TextStyle(
                          fontSize: 15
                      )
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
                validator: (val) => val.length< 6 ? 'Enter a password with chars less than 6' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              MaterialButton(
                onPressed: () async{
                  print(email);
                  print(password);
                  if(_formKey.currentState.validate())
                  {
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null)
                    {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                        loading=false;
                      });

                    }
                    else
                    {
//                          add the location and phone number in the database i do not know how yet

                    }
                  }

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
              SizedBox(height: 12.0,),
              Text(error,style: TextStyle(color: Colors.red,fontSize: 14.0)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 0),
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
                            ]
                        ),
                      ),

                    ),

                  ),

                  FlatButton(


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
              )

            ],
          ),
        ),
      ),
    );


  }
}
