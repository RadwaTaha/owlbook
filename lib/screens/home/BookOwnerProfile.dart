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
    return Container(
        child: Center(
          child: Container(
            height: 50.0,
            width: 350.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white
            ),
            child: RaisedButton(
              color: Color(0xffc12026),
              onPressed: () {


              },
              child: const Text(
                'this one for youu',
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),

              ),
            ),
          ),

        )
    );

  }
}