import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartfleet/services/curd.dart';
import 'package:smartfleet/constants.dart';

class VehicleList extends StatefulWidget {
  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
  String _vehicleNum;
  String _vehicleType = 'Vehicle type';
  String _make;
  String _model;

  String _driverRef;
  String _routeRef;

  QuerySnapshot vehicles;
  QuerySnapshot drivers;
  QuerySnapshot routes;

  List listofdrivers;

  CurdMethods curdObj = new CurdMethods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Vehicle', style: TextStyle(fontSize: 15.0)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration:
                        InputDecoration(hintText: 'Enter Vehicle Number'),
                    onChanged: (value) {
                      this._vehicleNum = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      DropdownButton(
                        value: _vehicleType,
                        icon: Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        underline: Container(
                          height: 5,
                          color: Colors.grey,
                        ),
                        onChanged: (String newVal) {
                          setState(() {
                            _vehicleType = newVal;
                          });
                        },
                        items: <String>[
                          'Vehicle type',
                          'Car',
                          'Bus',
                          'Lorry',
                          'Auto',
                          'Van'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  TextField(
                    decoration:
                        InputDecoration(hintText: 'Enter Vehicle Company'),
                    onChanged: (value) {
                      this._make = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration:
                        InputDecoration(hintText: 'Enter Vehicle Model'),
                    onChanged: (value) {
                      this._model = value;
                    },
                  ),
                  SizedBox(height: 5.0),
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
                        color: Colors.green,
                        shape: StadiumBorder(),
                      ),
                      MaterialButton(
                        elevation: 2,
                        height: 45,
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () async {
                          FirebaseUser user =
                              await FirebaseAuth.instance.currentUser();
                          var uid = user.uid;
                          Map<String, String> vehicleData = {
                            'vehicleNum': this._vehicleNum,
                            'vehicleType': this._vehicleType,
                            'make': this._make,
                            'model': this._model,
                            'driverRef': 'null',
                            'routeRef': 'null',
                            'uid': uid
                          };
                          curdObj.addVehicle(vehicleData).then((results) {
                            Navigator.of(context).pop();
                            print('Vehicle added');
                          }).catchError((e) {
                            print(e.toString());
                          });
                        },
                        color: Colors.green,
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

  Future<bool> addDriverAndRouteDialog(
      BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Assign Driver and Route',
                style: TextStyle(fontSize: 15.0)),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('profiles')
                                .where("orgId", isEqualTo: currentUserId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Loading..!");
                              } else {
                                List<DropdownMenuItem> drivers = [];
                                for (int i = 0;
                                    i < snapshot.data.documents.length;
                                    i++) {
                                  DocumentSnapshot snap =
                                      snapshot.data.documents[i];
                                  drivers.add(DropdownMenuItem(
                                    child: Text(
                                      snap.data['Name'],
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    value: snap.documentID,
                                  ));
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.person),
                                    SizedBox(width: 50),
                                    DropdownButton(
                                      icon: Icon(Icons.arrow_drop_down),
                                      items: drivers,
                                      onChanged: (value) {
                                        setState(() {
                                          print(value);
                                          _driverRef = value;
                                        });
                                      },
                                      value: _driverRef,
                                      isExpanded: false,
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                                .collection('routes')
                                .where("uid", isEqualTo: currentUserId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text("Loading..!");
                              } else {
                                List<DropdownMenuItem> routes = [];
                                for (int i = 0;
                                    i < snapshot.data.documents.length;
                                    i++) {
                                  DocumentSnapshot snap =
                                      snapshot.data.documents[i];
                                  routes.add(DropdownMenuItem(
                                    child: Text(
                                      snap.data['to'],
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    value: snap.documentID,
                                  ));
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.directions),
                                    SizedBox(width: 50),
                                    DropdownButton(
                                      icon: Icon(Icons.arrow_drop_down),
                                      items: routes,
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          _routeRef = value;
                                        });
                                      },
                                      value: _routeRef,
                                      isExpanded: false,
                                    ),
                                  ],
                                );
                              }
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          MaterialButton(
                            elevation: 2,
                            height: 45,
                            child: Text(
                              'Cancel',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: Colors.green,
                            shape: StadiumBorder(),
                          ),
                          MaterialButton(
                            elevation: 2,
                            height: 45,
                            child: Text(
                              'Assign',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              curdObj.assignDriverAndRoute(selectedDoc, {
                                'driverRef': _driverRef,
                                'routeRef': _routeRef
                              }).then((reuslts) {
                                Firestore.instance
                                    .collection('profiles')
                                    .document(_driverRef)
                                    .updateData({
                                      'vehicleId': selectedDoc,
                                      'routeId': _routeRef
                                    })
                                    .then((value) {})
                                    .catchError((e) {
                                      print(e);
                                    });
                              }).catchError((e) {
                                print(e);
                              });
                            },
                            color: Colors.green,
                            shape: StadiumBorder(),
                          ),
                          SizedBox(height: 0.5)
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    curdObj.getVehicles().then((results) {
      setState(() {
        vehicles = results;
      });
    });
    curdObj.getDrivers().then((results) {
      setState(() {
        drivers = results;
      });
    });
    curdObj.getRoutes().then((results) {
      setState(() {
        routes = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.green,
          title: Text('Vehicle List'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  curdObj.getVehicles().then((results) {
                    setState(() {
                      vehicles = results;
                    });
                  });
                }),
            IconButton(
                icon: FaIcon(FontAwesomeIcons.plus),
                onPressed: () {
                  addDialog(context);
                }),
          ],
        ),
        body: Container(
          color: Colors.green[100],
          child: _vehicleList(),
          padding: EdgeInsets.all(10),
        ));
  }

  Widget _vehicleList() {
    if (vehicles != null) {
      return ListView.builder(
        itemCount: vehicles.documents.length,
        itemBuilder: (context, i) {
          return Card(
            color: Colors.green[100],
            elevation: 8,
            child: Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(vehicles.documents[i].data['vehicleNum'],
                        style: TextStyle(fontSize: 25)),
                    leading: FaIcon(FontAwesomeIcons.bus, size: 40),
                    trailing: MaterialButton(
                      elevation: 2,
                      height: 35,
                      child: Text(
                        'Track',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () async {
                        String driverRef =
                            await vehicles.documents[i].data['driverRef'];
                        DocumentSnapshot driverData = await Firestore.instance
                            .collection('profiles')
                            .document(driverRef)
                            .get();
                        driverIdToTrack = await driverData.data['uid'];
                        liveLocationData = await Firestore.instance
                            .collection('livelocations')
                            .where('driverId', isEqualTo: driverIdToTrack)
                            .getDocuments();
                        // print(liveLocationData.documents[0].data['logitude']);
                        Navigator.of(context).pushNamed('/tracking');
                      },
                      color: Colors.green,
                      shape: StadiumBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MaterialButton(
                        elevation: 2,
                        height: 35,
                        child: Text(
                          'Assign or Change Route and Driver',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () {
                          addDriverAndRouteDialog(
                              context, vehicles.documents[i].documentID);
                        },
                        color: Colors.green,
                        shape: StadiumBorder(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Text('Loading Please Wait...!');
    }
  }
}
