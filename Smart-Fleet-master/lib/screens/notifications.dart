import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartfleet/services/curd.dart';
import 'package:smartfleet/constants.dart';
import 'package:smartfleet/globals.dart' as globals;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  CurdMethods curdObj = new CurdMethods();

  // DocumentSnapshot driverData;

  @override
  void initState() {
    super.initState();
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
          title: Text('Notifications'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () async {
                  await curdObj.getNotifications().then((results) {
                    setState(() {
                      globals.notification = results;
                    });
                  });
                }),
          ],
        ),
        body: Container(
          color: Colors.green[100],
          child: _notificationsList(),
          padding: EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
        ));
  }

  Widget _notificationsList() {
    if (globals.notification != null) {
      return ListView.builder(
        itemCount: globals.notification.documents.length,
        itemBuilder: (context, i) {
          return Card(
            color: Colors.green[100],
            elevation: 8,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                      'Name: ' +
                          globals.notification.documents[i].data['drivername'],
                      style: TextStyle(fontSize: 20)),
                  leading: Icon(Icons.person, size: 40),
                  subtitle: Text('wants to be a driver..!'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    MaterialButton(
                      elevation: 2,
                      height: 35,
                      child: Text(
                        'Accept',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () async {
                        String id =
                            globals.notification.documents[i].documentID;
                        DocumentSnapshot driverData = await Firestore.instance
                            .collection('notification')
                            .document(id)
                            .get();
                        String driverId = driverData.data['driver_id'];
                        QuerySnapshot profileData = await Firestore.instance
                            .collection('profiles')
                            .where('uid', isEqualTo: driverId)
                            .getDocuments();
                        String profileId = profileData.documents[0].documentID;
                        Firestore.instance
                            .collection('profiles')
                            .document(profileId)
                            .updateData({
                          'accepted': 'true',
                          'orgId': currentUserId,
                          'vehicleId': 'null',
                          'routeId': 'null'
                        });
                        Firestore.instance
                            .collection('notification')
                            .document(id)
                            .delete();
                      },
                      color: Colors.green,
                      shape: StadiumBorder(),
                    ),
                    MaterialButton(
                      elevation: 2,
                      height: 35,
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () {
                        String id =
                            globals.notification.documents[i].documentID;
                        Firestore.instance
                            .collection('notification')
                            .document(id)
                            .delete();
                      },
                      color: Colors.red,
                      shape: StadiumBorder(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    } else {
      return Text('No data found...!');
    }
  }
}
