import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as l;
import 'package:location/location.dart';
import 'package:smartdriver/services/locationservices.dart';

import 'package:smartdriver/constants.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class map extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<map> {
  final String apiKey = "XPGL90GUgrnuovlef100AbqC4lfo8z2F";
  LocationMethods locationObj = new LocationMethods();

  Timer timer;

  LocationData liveLocation = currentLocation;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) async {
      currentLocation = await locationObj.getMyLocation();
      Firestore.instance
          .collection('livelocations')
          .document(liveLocationId)
          .updateData({
        'latitude': currentLocation.latitude,
        'logitude': currentLocation.longitude
      });
      // print(currentLocation.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    var myLocation =
        new l.LatLng(currentLocation.latitude, currentLocation.longitude);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.gps_fixed, size: 25, color: Colors.white),
        onPressed: () async {
          currentLocation = await locationObj.getMyLocation();
          setState(() {
            myLocation = new l.LatLng(
                currentLocation.latitude, currentLocation.longitude);
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Navigation'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              color: Colors.red[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Droping Point: ' + routeData.data['to'],
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(37.42796133580664, -122.085749655962),
                        zoom: 12))
              ],
            )),
          ],
        ),
      ),
    );
  }
}
