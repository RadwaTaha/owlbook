import 'package:flutter/material.dart';
import 'diagonal_clipper.dart';
import 'package:flutter/material.dart';
import 'dart:ui'
as ui;

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    final String imgUrl = 'https://images.pexels.com/photos/5834/nature-grass-leaf-green.jpg?cs=srgb&dl=book-pages-chapter-dark-5834.jpg&fm=jpg';

    return new Stack(children: < Widget > [
      new Container(color: Color(0xffc12026), ),
      new Image.network(imgUrl, fit: BoxFit.fill, ),
      new BackdropFilter(
        filter: new ui.ImageFilter.blur(
          sigmaX: 6.0,
          sigmaY: 6.0,
        ),
        child: new Container(
          decoration: BoxDecoration(
            color: Color(0xffc12026).withOpacity(0.7),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ), )),
      new Scaffold(

        drawer: new Drawer(child: new Container(), ),
        backgroundColor: Colors.transparent,
        body: new Center(
          child: new Column(
            children: < Widget > [
              new SizedBox(height: _height / 12, ),
              new CircleAvatar(radius: _width < _height ? _width / 4 : _height / 4, backgroundImage: NetworkImage(imgUrl), ),
              new SizedBox(height: _height / 25.0, ),
              new Text('Moaz Ashraf', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: _width / 15, color: Colors.white), ),
              new Padding(padding: new EdgeInsets.only(top: _height / 30, left: _width / 8, right: _width / 8),
                child: new Text("If you don't like something, change it. If you can't it,change your attitude",
                  style: new TextStyle(fontWeight: FontWeight.normal, fontSize: _width / 25, color: Colors.white), textAlign: TextAlign.center, ), ),
              new Divider(height: _height / 30, color: Colors.white, ),
              new Row(
                children: < Widget > [

                  rowCell(2, 'BOOKS')

                ], ),
              new Divider(height: _height / 30, color: Colors.white),
              new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),

                elevation: 50.0,
                child: Container(
                  //height: MediaQuery.of(context).size.height - 250,
                  
                  width: MediaQuery.of(context).size.width - 40,
                  child: Container(
                    margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
                   // child: Text("The old drift", style: new TextStyle(fontWeight: FontWeight.bold, fontSize: _width / 15),),
                    //child: child,
                  ),
                ),
              ),
              new Padding(padding: new EdgeInsets.only(left: _width / 8, right: _width / 8,top: 120), child: new FlatButton(onPressed: () {},
                child: new MaterialButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)) ,
                child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: < Widget > [
                  new Icon(Icons.subdirectory_arrow_left),
                  new SizedBox(width: _width / 30, ),
                  new Text('LOG OUT')
                ], )), color: Colors.white, ), ),
            ],
          ),
        )
      )
    ], );
  }

  Widget rowCell(int count, String type) => new Expanded(child: new Column(children: < Widget > [
    new Text('$count', style: new TextStyle(color: Colors.white), ),
    new Text(type, style: new TextStyle(color: Colors.white, fontWeight: FontWeight.normal))
  ], ));
}