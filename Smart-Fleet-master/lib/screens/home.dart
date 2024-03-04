import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartfleet/components/mydrawer.dart';
import 'package:smartfleet/services/curd.dart';
import 'package:smartfleet/services/locationservices.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurdMethods curdObj = new CurdMethods();
  LocationMethods locationObj = new LocationMethods();

  QuerySnapshot profile;

  @override
  void initState() {
    super.initState();
    curdObj.getUserProfile().then((results) {
      setState(() {
        profile = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Fleet'),
        backgroundColor: Colors.green,
      ),
      drawer: MyDrawer(profile: profile),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.green[100],
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                'Your Dashboard',
                style: TextStyle(color: Colors.green, fontSize: 30),
              ),
              SizedBox(height: 20),
              Material(
                  elevation: 6,
                  color: Colors.green[100],
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    height: 130,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '20',
                              style:
                                  TextStyle(fontSize: 50, color: Colors.green),
                            ),
                            Text(
                              'Total Vehicles',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.green),
                            )
                          ],
                        ),
                        Icon(
                          Icons.airport_shuttle,
                          color: Colors.green,
                          size: 70,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/vehiclelist');
                    },
                  )),
              SizedBox(height: 20),
              Material(
                  elevation: 6,
                  color: Colors.green[100],
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    height: 130,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '20',
                              style:
                                  TextStyle(fontSize: 50, color: Colors.green),
                            ),
                            Text(
                              'Total Drivers',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.green),
                            )
                          ],
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.green,
                          size: 70,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/driverlist');
                    },
                  )),
              SizedBox(height: 20),
              Material(
                  elevation: 6,
                  color: Colors.green[100],
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(
                    height: 130,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '20',
                              style:
                                  TextStyle(fontSize: 50, color: Colors.green),
                            ),
                            Text(
                              'Total Routes',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.green),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.directions,
                          color: Colors.green,
                          size: 70,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/routelist');
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                elevation: 2,
                height: 35,
                child: Text(
                  'My Current Location',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () async {
                  currentLocation = await locationObj.getMyLocation();
                  Navigator.of(context).pushNamed('/mapscreen');
                },
                color: Colors.green,
                shape: StadiumBorder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
