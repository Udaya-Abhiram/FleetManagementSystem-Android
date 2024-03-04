import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartfleet/globals.dart' as globals;
import 'package:smartfleet/services/curd.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key key,
    @required this.profile,
  }) : super(key: key);

  final QuerySnapshot profile;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  CurdMethods curdObj = new CurdMethods();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.green[100],
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image(
                        image: NetworkImage(
                            widget.profile.documents[0].data['logoUrl']),
                        height: 100),
                    Text(widget.profile.documents[0].data['orgName']),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/homepage');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('View Profile'),
              onTap: () async {
                await curdObj.getUserProfile().then((results) async {
                  await setState(() {
                    globals.profile = results;
                  });
                  Navigator.of(context).pushReplacementNamed('/profilepage');
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('NotificationS'),
              onTap: () async {
                await curdObj.getNotifications().then((results) async {
                  await setState(() {
                    globals.notification = results;
                  });
                });
                Navigator.of(context).pushNamed('/notificationpage');
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.signOutAlt),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut().then((user) {
                  Navigator.of(context).pushReplacementNamed('/landingpage');
                }).catchError((e) {
                  print(e.toString());
                });
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.book),
              title: Text('User Guide'),
              onTap: () {
                // Navigator.of(context).pushReplacementNamed('/userguide');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // Navigator.of(context).pushReplacementNamed('/infopage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
