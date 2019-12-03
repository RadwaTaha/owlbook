import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future updateUserData(String phoneNumber,double lattitude, double longitude,List<Book> books) async {
    return await userCollection.document(uid).setData({
      'phone':phoneNumber,
      'lattitude':lattitude,
      'longitude':longitude,
      'books':books
    });

  }
}