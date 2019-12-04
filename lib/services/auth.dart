import 'package:firebase_auth/firebase_auth.dart';
import 'package:owl_book/models/user.dart';
import 'package:owl_book/services/database.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:owl_book/services/AppSettings.config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{



//  sign in anonomously

final FirebaseAuth _auth= FirebaseAuth.instance;// _ means that it is private
User _userFromFirebase(FirebaseUser user)
{
  return user!=null ? User(uid:user.uid) : null;
}

//auth change user stream
  Stream<User> get user{
  return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

Future signInAnon() async{
  try
  {
     AuthResult result=await _auth.signInAnonymously();
     FirebaseUser user=result.user;
     return _userFromFirebase(user);
  }
  catch(e)
  {
    print(e.toString());
    return null;

  }

}


// sign in with email and password
  Future signInWithEmailAndPassword(String email,String password) async{
    try
    {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      GlobalConfiguration cfg =  GlobalConfiguration().loadFromMap(appSettings);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString("uid", user.uid);
      await prefs.setString("email", user.email);
      cfg.updateValue("uid", user.uid);
      print("keysssssssssssss ${cfg.getString("uid")}");
      return _userFromFirebase(user);
    }
    catch(e)
    {
      print(e.toString());
      return null;

    }

  }

// register with email and password
  Future registerWithEmailAndPassword(String email,String password) async{
  try
  {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
//    create a new document for the user with uid 
    await DatabaseService(uid: user.uid).updateUserData("01XXXXXXXXX", 26.8206, 30.8025,[],email);
    return _userFromFirebase(user);
  }
  catch(e)
    {
      print(e.toString());
      return null;
      
    }
  
  }
// sign out
Future signOut() async{
  try{
    GlobalConfiguration cfg =  GlobalConfiguration().loadFromMap(appSettings);
    print("nadooodifromlalaland ${cfg.getString("uid")}");
//    print("Key2 has value ${GlobalConfiguration().getString("key2")}");
//    print("Key5 has value ${cfg.getString("key5")}, this should be null!");
    SharedPreferences prefs = await SharedPreferences.getInstance();

//    await prefs.setString("uid", user.uid);
    print("nadooojjsjjjdi ${prefs.get("uid")}");
    return await _auth.signOut();
  }
  catch(e)
  {
    print(e.toString());
  }
}
}