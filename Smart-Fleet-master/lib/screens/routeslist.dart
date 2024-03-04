import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartfleet/services/curd.dart';

class RoutesList extends StatefulWidget {
  @override
  _RoutesListState createState() => _RoutesListState();
}

class _RoutesListState extends State<RoutesList> {
  String _routeNum;
  String _to;
  String _from;

  QuerySnapshot routes;

  CurdMethods curdObj = new CurdMethods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Route', style: TextStyle(fontSize: 15.0)),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Route Number'),
                    onChanged: (value) {
                      this._routeNum = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'From'),
                    onChanged: (value) {
                      this._from = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'To'),
                    onChanged: (value) {
                      this._to = value;
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
                          Map<String, String> routeData = {
                            'routeNum': this._routeNum,
                            'from': this._from,
                            'to': this._to,
                            'uid': uid
                          };
                          curdObj.addRoute(routeData).then((results) {
                            Navigator.of(context).pop();
                            print('Route added');
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

  @override
  void initState() {
    super.initState();
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
          title: Text('Routes List'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  curdObj.getRoutes().then((results) {
                    setState(() {
                      routes = results;
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
          child: _routesList(),
          padding: EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
        ));
  }

  Widget _routesList() {
    if (routes != null) {
      return ListView.builder(
        itemCount: routes.documents.length,
        itemBuilder: (context, i) {
          return Card(
            color: Colors.green[100],
            elevation: 8,
            child: ListTile(
              title: Text('Route No: ' + routes.documents[i].data['routeNum'],
                  style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.directions, size: 40),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(routes.documents[i].data['from'],
                      style: TextStyle(fontSize: 20)),
                  FaIcon(FontAwesomeIcons.arrowsAltH, size: 20),
                  Text(routes.documents[i].data['to'],
                      style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Text('No data found...!');
    }
  }
}
