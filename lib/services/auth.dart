import 'package:firebase_auth/firebase_auth.dart';
import 'package:owl_book/models/user.dart';

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
// register with email and password
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