import 'package:flutter/material.dart';
import 'package:owl_book/services/auth.dart';
import 'package:owl_book/shared/loading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:owl_book/services/database.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;
  // text field state
  String email = '';
  String password = '';
  String phone='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
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
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
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
                validator: (val) => val.length< 6 ? 'Enter a password with chars less than 6' : null,
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
                validator: (val) => val != password ? 'confirm your password please!' : null,
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
                validator: (val) => val.length <7 ? 'Enter a valid phone number' : null,
                onChanged: (val) {
                  setState(() => phone = val);
                },
              ),
              SizedBox(height: 10.0,),
              MaterialButton(
                onPressed: () async {
                  if(_formKey.currentState.validate())
                    {
                      loading=true;
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null)
                        {
                          setState(() {
                            error = 'please supply a valid email!!';
                            loading=false;
                          });

                        }
                      else
                        {
//                          add the location and phone number in the database i do not know how yet
                          double longitude=0.0;
                          double latitude=0.0;
                          final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

                          geolocator
                              .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
                              .then((Position position) async {
                              longitude=position.longitude;
                              latitude=position.latitude;
//                              print(longitude);
//                              print("------------------------------------------------------");
//                              print(latitude);
                              await DatabaseService(uid: result.uid).updateUserData(phone, longitude, latitude,[]);

                          }).catchError((e) {
                            print(e);
                          });





                        }
                    }

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
              SizedBox(height: 12.0,),
              Text(error,style: TextStyle(color: Colors.red,fontSize: 14.0))


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