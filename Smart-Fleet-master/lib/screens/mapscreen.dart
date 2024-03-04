import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:smartfleet/services/locationservices.dart';
import '../constants.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LocationMethods locationObj = new LocationMethods();
  @override
  Widget build(BuildContext context) {
    var myLocation =
        new LatLng(currentLocation.latitude, currentLocation.longitude);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.gps_fixed, size: 30, color: Colors.white),
        onPressed: () async {
          currentLocation = await locationObj.getMyLocation();
          setState(() {
            myLocation =
                new LatLng(currentLocation.latitude, currentLocation.longitude);
          });
        },
      ),
      appBar: AppBar(
        title: Text('Current Location'),
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
                                  Icons.location_on,
                                  color: Colors.red,
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
