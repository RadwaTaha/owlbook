import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BookOwnerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: BOP(),
    );
  }


}
class BOP extends StatefulWidget{

  @override
  _BOPState createState() => _BOPState();
}

class _BOPState extends State<BOP> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text('Book Owner Profile'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      //body: ,

    );
  }
}