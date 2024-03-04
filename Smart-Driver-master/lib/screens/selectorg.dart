import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:smartdriver/constants.dart';
import 'package:smartdriver/services/locationservices.dart';
import 'package:smartdriver/constants.dart';

class SeleceOrg extends StatefulWidget {
  @override
  _SeleceOrgState createState() => _SeleceOrgState();
}

class _SeleceOrgState extends State<SeleceOrg> {
  LocationMethods locationObj = new LocationMethods();

  QuerySnapshot orgData;

  var query =
      Firestore.instance.collection('profiles').where('role', isEqualTo: 'org');

  var driversData;
  var _org;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a organization'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.red[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 40),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('profiles')
                  .where("role", isEqualTo: 'org')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading..!");
                } else {
                  List<DropdownMenuItem> organizations = [];
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    organizations.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.data['orgName'],
                          style: TextStyle(color: Colors.red),
                        ),
                        value: snap.documentID,
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person, color: Colors.red, size: 30),
                      SizedBox(width: 10),
                      Text('Select Your Org.: ',
                          style: TextStyle(fontSize: 18)),
                      SizedBox(width: 10),
                      DropdownButton(
                        icon: Icon(Icons.arrow_drop_down),
                        items: organizations,
                        onChanged: (value) {
                          setState(() {
                            _org = value;
                          });
                        },
                        value: _org,
                        isExpanded: false,
                      ),
                    ],
                  );
                }
              },
            ),
            MaterialButton(
              elevation: 2,
              height: 45,
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                Firestore.instance.collection('notification').add({
                  'drivername': driverName,
                  'driver_id': currentUserId,
                  'orgId': _org,
                }).then((results) {
                  Navigator.of(context).pushReplacementNamed('/loginagain');
                }).catchError((e) {
                  print(e);
                });
              },
              color: Colors.red,
              shape: StadiumBorder(),
            ),
          ],
        ),
      ),
    );
  }
}
