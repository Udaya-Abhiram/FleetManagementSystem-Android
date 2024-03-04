import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:smartfleet/constants.dart';
import 'package:latlong/latlong.dart';

class TrackingScreen extends StatefulWidget {
  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    var myLocation = new LatLng(
      liveLocationData.documents[0].data['latitude'],
      liveLocationData.documents[0].data['logitude'],
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.gps_fixed, size: 30, color: Colors.white),
        onPressed: () async {
          liveLocationData = await Firestore.instance
              .collection('livelocations')
              .where('driverId', isEqualTo: driverIdToTrack)
              .getDocuments();
        },
      ),
      appBar: AppBar(
        title: Text('Location of vehilce'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
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
                      height: 45,
                      width: 45,
                      point: myLocation,
                      builder: (context) => new Container(
                            child: IconButton(
                                icon: Icon(
                                  Icons.airport_shuttle,
                                  color: Colors.green,
                                  size: 45,
                                ),
                                onPressed: () {
                                  print('marker tapped');
                                }),
                          )),
                ])
              ],
            )),
          ],
        ),
      ),
    );
  }
}
