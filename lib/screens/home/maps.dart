import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:owl_book/shared/loading.dart';
import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owl_book/services/database.dart';
import 'package:owl_book/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' show cos, sqrt, asin;
import 'BookOwnerProfile.dart';



void main() => runApp(Maps());

class Maps extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title:"hello"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;
  bool search=false;
  String bookName;
  String mail;
  String uid;
  String address;
  bool mapToggle=false;
  final Map<String, Marker> _markers = {};
  Uint8List markerIcon;
  Position currentLocation;
  BitmapDescriptor customIcon;


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }


  void initState(){
    super.initState();
    Geolocator().getCurrentPosition().then((currLoc){
      setState(() {
        SharedPreferences.getInstance().then((pref){
          setState(() {
            mail=pref.get("email");
            uid=pref.get("uid");
            final coordinates = new Coordinates(currLoc.latitude, currLoc.longitude);

            Geocoder.local.findAddressesFromCoordinates(coordinates).then((addresses){
              setState(() {
                address=addresses.first.addressLine;
                currentLocation=currLoc;
                mapToggle=true;
                _markers.clear();
                final marker=Marker(
                  markerId: MarkerId(uid),
                  position: LatLng(currentLocation.latitude,currentLocation.longitude),
                  infoWindow: InfoWindow(title: mail,snippet: address,onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => BookOwnerProfile()),
//                    );


                  }),
                );
                _markers[uid]=marker;

              });
            });

          });
        });

      });
    });
  }

  @override
  Widget build(BuildContext context) {
//    createMarker(context);
    return Scaffold(
        body: mapToggle? Stack(
          children: <Widget>[
            GoogleMap(
              zoomGesturesEnabled: true,
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: LatLng(currentLocation.latitude,currentLocation.longitude),
                  zoom: 12.0
              ),
              markers: _markers.values.toSet(),

            ),
            Positioned(
              top: 30.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white
                ),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter Book',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0,top: 15.0),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: (){
                          search=true;
                        },
                        iconSize: 30.0,
                      )
                  ),
                  onChanged: (val) {
                    setState(() {
                      bookName=val;

                    });
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white
                ),
                child: RaisedButton(
                  color: Color(0xffc12026),
                  onPressed: () {
                    int count=0;


                    final CollectionReference userCollection = Firestore.instance.collection('users');
                    userCollection.snapshots().listen((snapshot) {
                      snapshot.documents.forEach((doc)  {
                        print("hello");
                        bool found=false;

                        for (int i = 0; doc.data['books'].length > i; i++) {
                          String book = doc.data['books'][i]['name'];
                          if (book.toLowerCase() == bookName.toLowerCase()) {
                            found = true;
                          }
                        }


                        if (doc.documentID != uid) {
                          if(found){
                            //print("hello2");
                            //print(doc.data['lattitude']);
                            double totalDistance = 0;
                            totalDistance = calculateDistance(currentLocation.latitude, currentLocation.longitude, doc.data['lattitude'], doc.data['longitude']);
                            print(totalDistance);
                           // print(doc.data['email']);

                            if(totalDistance<500) {
                              final coordinates1 = new Coordinates(
                                  doc.data['lattitude'],
                                  doc.data['longitude']);
                              Geocoder.local
                                  .findAddressesFromCoordinates(
                                  coordinates1).then((addresses1) {
                                var first1 = addresses1.first;
                                final marker1 = Marker(
                                    markerId: MarkerId(doc.documentID),
                                    position: LatLng(doc.data['lattitude'],
                                        doc.data['longitude']),
                                    infoWindow: InfoWindow(
                                        title: doc.data['email'],
                                        snippet: first1.addressLine),
                                        onTap: () {

                                       print(found);
                                      SharedPreferences.getInstance().then((prefs) {
                                        List<String> books=[];
                                        List<String> authors=[];
                                        List<String> covers=[];
//
                                        for(int i=0;doc.data['books'].length>i;i++){
                                          books.add(doc.data['books'][i]['name']);
                                          authors.add(doc.data['books'][i]['author']);
                                          covers.add(doc.data['books'][i]['coverUrl']);
                                          //books[i]=doc.data['books'][i]['name'];
                                         // authors[i]=doc.data['books'][i]['author'];
                                         // covers[i]=doc.data['books'][i]['coverUrl'];
                                        }


//                                        SharedPreferences.getInstance().then((prefs) async{
//                                          await prefs.setStringList("booksnames",books );
//                                          await prefs.setStringList("bookauthors", authors);
//                                          await prefs.setStringList("bookcovers", covers);
//
//
//                                        });


                                        print("hereeeeeeeeeeeeeeeeee");
                                        prefs.setString("OwnerMail", doc.data['email']);
                                        prefs.setString("Ownerphone", doc.data['phone']);
                                        prefs.setStringList("Ownerbooknames", books);
                                        prefs.setStringList("Ownerbookauthors", authors);
                                        prefs.setStringList("Ownerbookcovers", covers);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => BookOwnerProfile(),
                                        ));

                                      });



                                    }


                                );
                                setState(() {
                                  _markers[doc.documentID] = marker1;
                                });

                                print(_markers.length);
                              });
                            }
//                                  ---------------------------------
                          }
////                                ----------------------------------------Pop up menu---------------------------------------------------------
//                          if(count==0){
//                            print("no books found for you sorry;(");
//                          }

                        }
                      });

                    });
//                    add markers
//                    runApp(MyHomePage());


                  },
                  child: const Text(
                    'Find My Book',
                    style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold ),

                  ),
                ),
              ),
            ),


          ],
        ):Loading()

    );

  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


  void onMapCreated(controller){
    setState(() {
      mapController=controller;
    });
  }


}