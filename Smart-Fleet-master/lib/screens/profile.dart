import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartfleet/components/mydrawer.dart';
import 'package:smartfleet/services/curd.dart';
import 'package:smartfleet/globals.dart' as globals;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  CurdMethods curdObj = new CurdMethods();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green,
      ),
      drawer: MyDrawer(profile: globals.profile),
      body: Container(
        width: double.infinity,
        color: Colors.green[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Name: ' + globals.profile.documents[0].data['orgName'],
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Text(
              'Organization: ' + globals.profile.documents[0].data['orgType'],
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Text(
              'City: ' + globals.profile.documents[0].data['city'],
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Text(
              'State: ' + globals.profile.documents[0].data['state'],
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
