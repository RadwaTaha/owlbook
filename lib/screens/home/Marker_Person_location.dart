import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'locations.dart' as locations;



void main() => runApp(MarkerPerson());

class MarkerPerson extends StatefulWidget {
  @override
  _MarkerPersonState createState() => _MarkerPersonState();
}

class _MarkerPersonState extends State<MarkerPerson> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("Nada"),//user name
        position: LatLng(30.0444, 31.2357),//position on the map
        infoWindow: InfoWindow(
          title: "Nada",
          snippet: "Rehab 1",//address in words
        ),
      );
      _markers["Nada"] = marker;
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Google Office Locations'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: const LatLng(0, 0),
          zoom: 2,
        ),
        markers: _markers.values.toSet(),
      ),
    ),
  );
}