import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:owl_book/shared/loading.dart';
import 'package:geocoder/geocoder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:owl_book/services/database.dart';
import 'package:owl_book/services/auth.dart';

//import 'mapGeo.dart';
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
  void radwa() async{
    final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon));
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'Assets/p4.png')
          .then((icon) {
        setState(() {
          print(icon);
          customIcon = icon;
        });
      });
    }
  }




  void initState(){
    super.initState();

    Geolocator().getCurrentPosition().then((currLoc){
      setState(() async {
        currentLocation=currLoc;
        mapToggle=true;
        _markers.clear();
        FirebaseUser user= await FirebaseAuth.instance.currentUser();
        final coordinates = new Coordinates(currentLocation.latitude, currentLocation.longitude);
        var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        print("${first.featureName} : ${first.addressLine}");
        final marker=Marker(
          markerId: MarkerId(user.uid),
          position: LatLng(currentLocation.latitude,currentLocation.longitude),
          infoWindow: InfoWindow(title: user.email,snippet: first.addressLine),

        );
        _markers[user.uid]=marker;
//        ------------------------------------------Scary part-------------------------------------------------------------

//      -------------------------------------------------------------------------------------------------------------------




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
                zoom: 8.0
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
                onPressed: () async{
                  search=true;

                  FirebaseUser user= await FirebaseAuth.instance.currentUser();
                  final CollectionReference userCollection = Firestore.instance
                      .collection('users');
                  userCollection.snapshots().listen((snapshot) {
                    snapshot.documents.forEach((doc) async {
                      print("hello");

                      if (doc.documentID != user.uid) {
                        print("hello2");
                        final coordinates1 = new Coordinates(
                            doc.data['lattitude'], doc.data['longitude']);
                        var addresses1 = await Geocoder.local
                            .findAddressesFromCoordinates(coordinates1);
                        var first1 = addresses1.first;
                        final marker1 = Marker(
                          markerId: MarkerId(doc.documentID),
                          position: LatLng(doc.data['lattitude'], doc
                              .data['longitude']),
                          infoWindow: InfoWindow(
                              title: doc.data['email'], snippet: first1.addressLine),

                        );
                        _markers[doc.documentID] = marker1;
                        print(_markers.length);
                      }
                    });
                  });
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

  void onMapCreated(controller){
    setState(() {
      mapController=controller;
    });
  }


}
