import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:owl_book/models/user.dart';

class Book{
  String name;
  String author;
  String coverUrl;
  Book({this.name,this.author,this.coverUrl});
}

class DatabaseService
{
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String phoneNumber,double lattitude, double longitude,List books) async {
    return await userCollection.document(uid).setData({
      'phone':phoneNumber,
      'lattitude':lattitude,
      'longitude':longitude,
      'books':books
    });

  }
  Future addBooks(String name, String author , String cover) async{
//    return await userCollection.ge;
    DocumentSnapshot snapshot = await userCollection.document(uid).get();
    List userBooks=snapshot.data['books'];
    String phone=snapshot.data['phone'];
    double lattitude=snapshot.data['lattitude'];
    double longitude=snapshot.data['longitude'];
    List temp=[];
    for(int i=0;userBooks.length>i;i++){
      temp.add(userBooks[i]);
    }

    temp.add({'name':name,'author':author,'coverUrl':cover});


    print(temp);
    return await userCollection.document(uid).setData({
      'phone':phone,
      'lattitude':lattitude,
      'longitude':longitude,
      'books':temp
    });

  }

}