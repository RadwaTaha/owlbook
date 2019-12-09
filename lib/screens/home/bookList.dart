import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:owl_book/models/user.dart';
import 'package:owl_book/services/database.dart';
import 'package:owl_book/services/auth.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:owl_book/services/AppSettings.config.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
GlobalConfiguration cfg =  GlobalConfiguration().loadFromMap(appSettings);

String  url =cfg.getString("bookAPI");

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookFinderPage(),
    );
  }
}
String k="";

class BookFinderPage extends StatelessWidget {

  final String text;
  BookFinderPage({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    url=url+text.replaceAll(RegExp(' '), '+');
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Finder'),
        leading: Icon(Icons.book),
      ),
      body: FutureBuilder(
          future: _fetchPotterBooks(),
          builder: (context, AsyncSnapshot<List<Book>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: Book was not found'));
              } else {
                return ListView(
                    children: snapshot.data.map((b) => BookTile(b)).toList());
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class BookTile extends StatelessWidget {
  final Book book;
  BookTile(this.book);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(book.thumbnailUrl),
      ),
      title: Text(book.title),
      subtitle: Text(book.author),
      onTap: () => _navigateToDetailsPage(book, context),
    );
  }
}

List<Book> _fetchBooks() {
  return List.generate(100, (i) => Book(title: 'Book $i', author: 'Author $i'));
}

Future<List<Book>> _fetchPotterBooks() async {
  final res = await http.get(url);
  if (res.statusCode == 200) {
    print(json.decode(res.body)["items"][1]["volumeInfo"]["authors"].join(', '));
    return _parseBookJson(res.body);
  } else {
    throw Exception('Error: ${res.statusCode}');
  }
}

List<Book> _parseBookJson(String jsonStr) {
  final jsonMap = json.decode(jsonStr);
  final jsonList = (jsonMap['items'] as List);
  List<Book> books=[];
  for(int i=0;jsonList.length>i;i++)
  {
    if(jsonList[i]["volumeInfo"]["title"]!=null && jsonList[i]["volumeInfo"]["title"]!=null &&jsonList[i]["volumeInfo"]["imageLinks"]["smallThumbnail"]!=null)
      books.add(Book(title: jsonList[i]["volumeInfo"]["title"],author:jsonList[i]["volumeInfo"]["title"] ,thumbnailUrl:jsonList[i]["volumeInfo"]["imageLinks"]["smallThumbnail"] ));
  }
  return books;

}

class Book {
  final String title;
  final String author;
  final String thumbnailUrl;

  Book({@required this.title, @required this.author, this.thumbnailUrl})
      : assert(title != null),
        assert(author != null);
}

void _navigateToDetailsPage(Book book, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => BookDetailsPage(book),
  ));
}

class BookDetailsPage extends StatelessWidget {
  final Book book;
  BookDetailsPage(this.book);
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BookDetails(book),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your onPressed code here!
          FirebaseUser user= await FirebaseAuth.instance.currentUser();
          print(user.uid);
          // adding books to user account
          print(book.title);
          print(book.author);
          print(book.thumbnailUrl);
          DatabaseService databaseService = await DatabaseService(uid: user.uid);
          databaseService.addBooks(book.title, book.author, book.thumbnailUrl);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,


      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}

class BookDetails extends StatelessWidget {
  final Book book;
  BookDetails(this.book);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(book.thumbnailUrl),
          SizedBox(height: 10.0),
          Text(book.title),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(book.author,
                style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}