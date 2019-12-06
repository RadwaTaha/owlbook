import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'Marker_Person_location.dart';

class Maps extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

<<<<<<< Updated upstream
class _HomePageState extends State<Maps> {
  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentPosition != null)
              Text("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),

            FloatingActionButton(

              onPressed: () {
                // Add your onPressed code here!
                _getCurrentLocation();
                print(_currentPosition.longitude);
                print("-------------------------------------------------------");
                print(_currentPosition.latitude);

//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => MarkerPerson()),
//                );
              },
              child: Icon(Icons.navigation),
              backgroundColor: Colors.green,
            )
=======
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
  final mycontroller = TextEditingController();
  String book;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  void dispose() {
    // Clean up the controller when the widget is disposed.
    mycontroller.dispose();
    super.dispose();
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
                  infoWindow: InfoWindow(title: mail,snippet: address),
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
                  controller: mycontroller,
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



                    final CollectionReference userCollection = Firestore.instance
                        .collection('users');
                    userCollection.snapshots().listen((snapshot) {
                      snapshot.documents.forEach((doc)  {
                        print("hello");

                        if (doc.documentID != uid) {
//                          print(bookName);
//                          print("hello2");
                        bool found=false;
                        if(doc.data["books"].length!=0) {
                          print(doc.data['books']);
                          for(int i=0;doc.data['books'].length>i;i++){
                            String nameBook=doc.data['books'][i]['name'];
                            if(nameBook.toLowerCase()==bookName.toLowerCase()){
                              found=true;
                            }
                          }
                        }
                        if(found){
                          print("booooooooook owner ${doc.data['email']}");
                          final coordinates1 = new Coordinates(doc.data['lattitude'], doc.data['longitude']);
                          Geocoder.local.findAddressesFromCoordinates(coordinates1).then((addresses1){
                            var first1 = addresses1.first;
                            final marker1 = Marker(
                              markerId: MarkerId(doc.documentID),
                              position: LatLng(doc.data['lattitude'], doc
                                  .data['longitude']),
                              infoWindow: InfoWindow(
                                  title: doc.data['email'], snippet: first1.addressLine),

                            );

                            setState(() {
                              _markers[doc.documentID] = marker1;

                            });


                            print(_markers.length);
                          });

                        }



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

>>>>>>> Stashed changes

          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}