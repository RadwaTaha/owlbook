import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:ui' as ui;
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

Widget rowCell(int count, String type) => new Expanded(child: new Column(children: <Widget>[
  new Text('$count',style: new TextStyle(color: Colors.white),),
  new Text(type,style: new TextStyle(color: Colors.white, fontWeight: FontWeight.normal))
],));

class _BOPState extends State<BOP> {

String mail="";
String phone="";
List books=[];
List Bookname=[];
List authoer=[];


  @override
  Widget build(BuildContext context) {

    SharedPreferences.getInstance().then((prefs){
      setState(() {
        mail=prefs.get("OwnerMail");
        phone=prefs.get("Ownerphone");
       // books=prefs.getStringList("Ownerbooks");
        Bookname=prefs.getStringList("Ownerbooknames");
        authoer=prefs.getStringList("Ownerbookauthors");
        //Bookname=prefs.get("Ownerbooknames");
        //authoer=prefs.get("Ownerbookauthors");
      });

    });

    print(mail);
    print(phone);
    print(books);
    print("******");
    print(Bookname);
    print(authoer);
    print("-----------------------");


    final _width = MediaQuery
        .of(context)
        .size
        .width;
    final _height = MediaQuery
        .of(context)
        .size
        .height;
    //final String imgUrl = 'https://pixel.nymag.com/imgs/daily/selectall/2017/12/26/26-eric-schmidt.w700.h700.jpg';

    return new Stack(children: <Widget>[
      new Container(color: Colors.red,),
      new Image(image: AssetImage('Assets/logo.png')),
      new BackdropFilter(
          filter: new ui.ImageFilter.blur(
            sigmaX: 6.0,
            sigmaY: 6.0,
          ),
          child: new Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(1),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),)),
      new Scaffold(
          appBar: new AppBar(
            //title: new Text(widget.title),
            centerTitle: false,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          drawer: new Drawer(child: new Container(),),
          backgroundColor: Colors.transparent,
          body: new Center(
            child: new Column(
              children: <Widget>[
                new SizedBox(height: _height / 12,),
                new CircleAvatar(
                  radius: _width < _height ? _width / 4 : _height / 4,
                  backgroundImage:  AssetImage('Assets/logo.png')),
                new SizedBox(height: _height / 25.0,),
                new Text(mail, style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _width / 15,
                    color: Colors.white),),
                new Padding(padding: new EdgeInsets.only(
                    top: _height / 30, left: _width / 8, right: _width / 8),
                  child: new Text(
                    phone,
                    style: new TextStyle(fontWeight: FontWeight.normal,
                        fontSize: _width / 25,
                        color: Colors.white), textAlign: TextAlign.center,),),
                new Divider(height: _height / 30, color: Colors.white,),
                new Column(
                  children: <Widget>[
                    new Text(Bookname.toString()),
                    new Text(authoer.toString()),
                   // rowCell(, 'POSTS'),
                    //new Icon(Icons.person),
//                    rowCell(1, ),
//                    rowCell(275, 'FOLLOWING'),
                  ],),
                new Divider(height: _height / 30, color: Colors.white),
                new Padding(padding: new EdgeInsets.only(
                    left: _width / 8, right: _width / 8),
                  child: new FlatButton(onPressed: () {},
                    child: new Container(child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.person),
                        new SizedBox(width: _width / 30,),
                        new Text('Notifiy')
                      ],)), color: Colors.blue[50],),),
              ],
            ),
          )
      )
    ],);
  }
}