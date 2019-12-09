import 'package:flutter/material.dart';
import 'package:owl_book/screens/home/profile2.dart';
import 'bookList.dart';
import 'package:owl_book/services/auth.dart';
import 'maps.dart';

void main() => runApp(SecondHome());

class SecondHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            body: TabBarView(
              children: [
                FirstScreen(),
                SecondScreen(),
                ThirdScreen()
              ],
            ),
            // drawer: Drawer(

            //   child: ListView(
            //     // Important: Remove any padding from the ListView.
            //     padding: EdgeInsets.zero,
            //     children: < Widget > [

            //     ],
            //   ),
            // ),
          ),
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title
  }): super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State < MyHomePage > {
  final myController = TextEditingController();

  get text => null;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {

    final emailField = TextField(
      controller: myController,
      obscureText: false,
       style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SFUIDisplay'
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Book name",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final searchButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffc12026),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          _sendDataToSecondScreen(context);
        },
        child: Text("Search",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white, fontWeight: FontWeight.bold)),
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


//------------------------------------------------------------------------------------------------




class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Maps();

  }
}

class FirstScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return profile2();
    // return Container(
    //   child: Center(
    //     child: Column(
    //       children: <Widget>[
    //         Text("Moaz"),
    //         FloatingActionButton(
    //           onPressed: () async{
    //             // Add your onPressed code here!
    //             await _auth.signOut();
    //           },
    //           child: Icon(Icons.power_settings_new),
    //           backgroundColor: Colors.blue,

    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: MyHomePage(),
      ),
    );
  }
}