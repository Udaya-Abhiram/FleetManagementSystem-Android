import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartdriver/constants.dart';
import 'package:smartdriver/services/locationservices.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DocumentSnapshot vehicleData;
  // DocumentSnapshot routeData;

  // CurdMethods curdObj = new CurdMethods();

  // @override
  // void initState() {
  //   super.initState();
  //   curdObj.getVehicleData().then((results) {
  //     vehicleData = results;
  //     print(vehicleData.exists);
  //   });
  //   curdObj.getRouteData().then((results) {
  //     routeData = results;
  //   });
  // }

  LocationMethods locationObj = new LocationMethods();

  Future<bool> signoutDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('Are you sure, logout?', style: TextStyle(fontSize: 15.0)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MaterialButton(
                        elevation: 2,
                        height: 45,
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.red,
                        shape: StadiumBorder(),
                      ),
                      MaterialButton(
                        elevation: 2,
                        height: 45,
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut().then((user) {
                            Navigator.of(context)
                                .pushReplacementNamed('/loginpage');
                          }).catchError((e) {
                            print(e);
                          });
                        },
                        color: Colors.red,
                        shape: StadiumBorder(),
                      ),
                      SizedBox(height: 0.5)
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Home'),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  signoutDialog(context);
                },
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          SizedBox(width: 20)
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Hello Mr.' + driverName,
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 10),
              Text(
                'Congrats, you are a smart driver..!',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image(
                      image: NetworkImage(orgData.documents[0].data['logoUrl']),
                      height: 100),
                  SizedBox(height: 20),
                  Text(
                    orgData.documents[0].data['orgName'],
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('Vehicle Number: '),
                  Text(
                    vehicleData.data['vehicleNum'],
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('Route Number: '),
                  Text(
                    routeData.data['routeNum'],
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text('Destination: '),
                  Text(
                    routeData.data['to'],
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Text(
              //   'Click the below button to start your journey..!',
              //   style: TextStyle(fontSize: 20),
              // ),
              SizedBox(height: 10),
              MaterialButton(
                elevation: 2,
                height: 45,
                child: Text(
                  'Start',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () async {
                  currentLocation = await locationObj.getMyLocation();
                  QuerySnapshot oldLiveDoc = await Firestore.instance
                      .collection('livelocations')
                      .where('driverId', isEqualTo: currentUserId)
                      .getDocuments();
                  // print('hello' + oldLiveDoc.documents[0].exists.toString());
                  if (oldLiveDoc.documents.isNotEmpty) {
                    String oldLiveId = oldLiveDoc.documents[0].documentID;
                    Firestore.instance
                        .collection('livelocations')
                        .document(oldLiveId)
                        .delete();
                  }
                  Firestore.instance.collection('livelocations').add({
                    'driverId': currentUserId,
                    'latitude': currentLocation.latitude,
                    'logitude': currentLocation.longitude
                  }).then((results) {
                    liveLocationId = results.documentID;
                  });
                  Navigator.of(context).pushNamed('/map');
                },
                color: Colors.red,
                shape: StadiumBorder(),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
