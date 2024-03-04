import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartfleet/services/curd.dart';

class DriverList extends StatefulWidget {
  @override
  _DriverListState createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  QuerySnapshot drivers;

  CurdMethods curdObj = new CurdMethods();

  @override
  void initState() {
    super.initState();
    curdObj.getDrivers().then((results) {
      setState(() {
        drivers = results;
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
          title: Text('Drivers List'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  curdObj.getDrivers().then((results) {
                    setState(() {
                      drivers = results;
                    });
                  });
                }),
          ],
        ),
        body: Container(
          color: Colors.green[100],
          child: _driverList(),
          padding: EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
        ));
  }

  Widget _driverList() {
    if (drivers != null) {
      return ListView.builder(
        itemCount: drivers.documents.length,
        itemBuilder: (context, i) {
          return Card(
            color: Colors.green[100],
            elevation: 8,
            child: ListTile(
              title: Text(drivers.documents[i].data['Name'],
                  style: TextStyle(fontSize: 20)),
              leading: FaIcon(FontAwesomeIcons.user, size: 40),
              subtitle: Text(drivers.documents[i].data['licenceid'],
                  style: TextStyle(fontSize: 15)),
            ),
          );
        },
      );
    } else {
      return Text('No data found...!');
    }
  }
}
