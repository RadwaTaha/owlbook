import 'package:flutter/material.dart';
import 'bookList.dart';
import 'maps.dart';
import 'package:owl_book/screens/home/profile2.dart';
class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final myController = TextEditingController();
  String val="";
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
        //obscureText: true,
        controller: myController,
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'SFUIDisplay'
        ),
        onChanged: (text) {
          //print("radwaaaa ${text}");
          setState(() {
            val=text;
          });
  },
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
      appBar: AppBar(
        title: Text("OWLBOOK"),
        backgroundColor: Color(0xffc12026),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: < Widget > [
            new SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: < Widget > [
                Icon(Icons.person),

                FlatButton(
                  textColor: Color(0xffc12026),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profile2(),
                      ));
                  },
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      fontFamily: 'SFUIDisplay',
                      color: Color(0xffc12026),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: < Widget > [
                Icon(Icons.book),

                FlatButton(
                  textColor: Color(0xffc12026),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Maps(),
                      ));
                  },
                  child: Text(
                    "Next Book",
                    style: TextStyle(
                      fontFamily: 'SFUIDisplay',
                      color: Color(0xffc12026),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: < Widget > [
                Icon(Icons.add),

                FlatButton(
                  textColor: Color(0xffc12026),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddBook(),
                      ));
                  },
                  child: Text(
                    "Add Book",
                    style: TextStyle(
                      fontFamily: 'SFUIDisplay',
                      color: Color(0xffc12026),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ]
        )
      ),
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
  @override
  
  void _sendDataToSecondScreen(BuildContext context) {
    String textToSend = val;
    //print("text1:"+textToSend);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookFinderPage(text: textToSend, ),
      ));
  }
}
