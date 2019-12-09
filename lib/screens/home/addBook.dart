import 'package:flutter/material.dart';

import 'bookList.dart';


class AddBook extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final emailField = Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                      bottomLeft: const Radius.circular(40.0),
                      bottomRight: const Radius.circular(40.0) 
                      ),
                  ),
                             
                  //color: Color(0xfff5f5f5),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                      labelText: 'Book name',
                      prefixIcon: Icon(Icons.book),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                  ),
                );
   

    final searchButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffc12026),
      child: MaterialButton(
        height: 58,
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _sendDataToSecondScreen(context);
        },
        child: Text("Search",
          textAlign: TextAlign.center, 
        )
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width, 
          color: Color(0xff183D6A),
          

          //color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: < Widget > [
                  Image.asset(
                    'Assets/search.png',
                  ),
                  //       Image.asset(
                  //   'Assets/searchowl.jpg',
                  // ),
                  emailField,
                  SizedBox(
                    height: 35.0,
                  ),
                  searchButon,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
  void _sendDataToSecondScreen(BuildContext context) {
    String textToSend = myController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookFinderPage(text: textToSend, ),
      ));
  }
}
