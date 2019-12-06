import 'package:flutter/material.dart';
import 'package:owl_book/services/auth.dart';


var COLORS = [
  Color(0xffc12026),
  Color(0xFFFF90B3),
  Color(0xFFFFC2E2),
  Color(0xFFB892FF),
  Color(0xFFB892FF)
];

class profile2 extends StatelessWidget {
final AuthService _auth=AuthService();
  var data = [{
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": Color(0xffc12026),
      "image": "https://picsum.photos/200?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": Color(0xffc12026),
      "image": "https://picsum.photos/100?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": Color(0xffc12026),
      "image": "https://picsum.photos/150?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": Color(0xffc12026),
      "image": "https://picsum.photos/125?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": Color(0xffc12026),
      "image": "https://picsum.photos/175?random"
    },
    {
      "title": "Hey Flutterers, See what I did with Flutter",
      "content": "This is just a text description of the item",
      "color": Color(0xffc12026),
      "image": "https://picsum.photos/225?random"
    }
    // {
    //   "title": "Hey Flutterers, See what I did with Flutter",
    //   "content": "This is just a text description of the item",
    //   "color": COLORS[new Random().nextInt(5)],
    //   "image": "https://picsum.photos/250?random"
    // },
    // {
    //   "title": "Hey Flutterers, See what I did with Flutter",
    //   "content": "This is just a text description of the item",
    //   "color": COLORS[new Random().nextInt(5)],
    //   "image": "https://picsum.photos/350?random"
    // },
    // {
    //   "title": "Hey Flutterers, See what I did with Flutter",
    //   "content": "This is just a text description of the item",
    //   "color": COLORS[new Random().nextInt(5)],
    //   "image": "https://picsum.photos/275?random"
    // },
    // {
    //   "title": "Hey Flutterers, See what I did with Flutter",
    //   "content": "This is just a text description of the item",
    //   "color": COLORS[new Random().nextInt(5)],
    //   "image": "https://picsum.photos/300?random"
    // },
    // {
    //   "title": "Hey Flutterers, See what I did with Flutter",
    //   "content": "This is just a text description of the item",
    //   "color": COLORS[new Random().nextInt(5)],
    //   "image": "https://picsum.photos/325?random"
    // }
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: < Widget > [
          new Transform.translate(
            offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.1050),
            child: new ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 50.0, bottom: 50.0),
                scrollDirection: Axis.vertical,
                primary: true,
                itemCount: data.length,
                itemBuilder: (BuildContext content, int index) {
                  return AwesomeListItem(
                    title: data[index]["title"],
                    content: data[index]["content"],
                    color: data[index]["color"],
                    image: data[index]["image"]);
                },
            ),
          ),

          new Transform.translate(
            offset: Offset(0.0, -56.0),
            child: new Container(
              child: new ClipPath(
                clipper: new MyClipper(),
                child: new Stack(
                  children: [
                    new Image.network(
                      "https://images.unsplash.com/photo-1497100022365-1a3688dc53ec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=923&q=80",
                      fit: BoxFit.cover,
                    ),
                    new Opacity(
                      opacity: 0.2,
                      child: new Container(color: COLORS[0]),
                    ),
                    // new SizedBox(height: 12.0),
                    new Transform.translate(
                      offset: Offset(0.0, 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: < Widget > [
                          new SizedBox(height: 50.0),
                          new Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: < Widget > [
                              new CircleAvatar(

                                child: new Container(
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        "https://avatars2.githubusercontent.com/u/3234592?s=460&v=4"),
                                    ),
                                  ),
                                ),
                              ),
                              new SizedBox(width: 25.0),
                              new Column(
                                children: < Widget > [
                                  new Text(
                                    "Moaz Ashraf",

                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 27.0,
                                      letterSpacing: 2.0),
                                  ),
                                  new Text(
                                    "moaazashraf98@gmail.com",

                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      letterSpacing: 2.0),
                                  ),

                                ],


                              ),
                              new MaterialButton(
                                onPressed: () async {
                                  // Add your onPressed code here!
                                  await _auth.signOut();
                                }, //since this is only a UI app
                                child: Text('Log out',
                                  style: TextStyle(
                                    color: Color(0xffc12026),
                                    fontSize: 15,
                                    fontFamily: 'SFUIDisplay',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                color: Colors.white,
                                elevation: 0,
                                minWidth: 80,
                                height: 30,

                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),




                            ],


                          ),


                        ],
                      )

                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper < Path > {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 3.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class AwesomeListItem extends StatefulWidget {
  String title;
  String content;
  Color color;
  String image;

  AwesomeListItem({
    this.title,
    this.content,
    this.color,
    this.image
  });

  @override
  _AwesomeListItemState createState() => new _AwesomeListItemState();
}

class _AwesomeListItemState extends State < AwesomeListItem > {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: < Widget > [
        new Container(width: 10.0, height: 190.0, color: widget.color),
        new Expanded(
          child: new Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: < Widget > [
                  new Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                      child: new Text(
                        widget.content,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                      ),
                  ),
                ],
              ),
          ),
        ),
        new Container(
          height: 150.0,
          width: 150.0,
          color: Colors.white,
          child: Stack(
            children: < Widget > [
              new Transform.translate(
                offset: new Offset(50.0, 0.0),
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  color: widget.color,
                ),
              ),
              new Transform.translate(
                offset: Offset(10.0, 20.0),
                child: new Card(
                  elevation: 20.0,
                  child: new Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 10.0,
                        color: Colors.white,
                        style: BorderStyle.solid),
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                      )),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}