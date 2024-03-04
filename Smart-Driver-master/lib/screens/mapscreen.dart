import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:smartdriver/services/locationservices.dart';
import 'package:smartdriver/constants.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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
        new LatLng(currentLocation.latitude, currentLocation.longitude);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.gps_fixed, size: 25, color: Colors.white),
        onPressed: () async {
          currentLocation = await locationObj.getMyLocation();
          setState(() {
            myLocation =
                new LatLng(currentLocation.latitude, currentLocation.longitude);
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
                child: FlutterMap(
              options: new MapOptions(
                center: myLocation,
                zoom: 13.0,
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key=pdk4u3RgF0fAqo957mSgLLkDHYr7r0VP",
                  additionalOptions: {
                    'apiKey': 'pdk4u3RgF0fAqo957mSgLLkDHYr7r0VP',
                  },
                ),
                new MarkerLayerOptions(markers: [
                  new Marker(
                      height: 20,
                      width: 20,
                      point: myLocation,
                      builder: (context) => new Container(
                            child: IconButton(
                                icon: Icon(
                                  Icons.navigation,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                onPressed: () {
                                  print('marker tapped');
                                }),
                          )),
                ]),
                // new PolylineLayerOptions(polylines: [
                //   Polyline(),
                // ]),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
