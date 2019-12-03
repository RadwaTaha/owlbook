import 'package:firebase_auth/firebase_auth.dart';
import 'package:owl_book/models/user.dart';
import 'package:owl_book/services/database.dart';

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
    await DatabaseService(uid: user.uid).updateUserData("01XXXXXXXXX", 26.8206, 30.8025,[]);
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
    return await _auth.signOut();
  }
  catch(e)
  {
    print(e.toString());
  }
}
}