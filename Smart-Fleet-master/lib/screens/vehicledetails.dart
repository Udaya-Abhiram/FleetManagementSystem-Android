import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:smartfleet/services/curd.dart';

class VehicleDetails extends StatelessWidget {
  const VehicleDetails({
    Key key,
    @required this.selectedVehicle,
    @required this.index,
  }) : super(key: key);

  final QuerySnapshot selectedVehicle;
  final int index;

  // final curdMethods curdObj = new curdMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
              icon: FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text('Vehicle Details'),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Colors.green[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              FaIcon(FontAwesomeIcons.bus, size: 50, color: Colors.green),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.car, size: 50, color: Colors.green),
                  FaIcon(FontAwesomeIcons.ambulance,
                      size: 50, color: Colors.green),
                ],
              ),
              SizedBox(height: 10),
              Text(
                  'Number: ' +
                      selectedVehicle.documents[index].data['vehicleNum'],
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text(
                  'Type: ' +
                      selectedVehicle.documents[index].data['vehicleType'],
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('Make: ' + selectedVehicle.documents[index].data['make'],
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('Model: ' + selectedVehicle.documents[index].data['model'],
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text(
                  'Driver: ' +
                      selectedVehicle.documents[index].data['driverRef'],
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text(
                  'Route No: ' +
                      selectedVehicle.documents[index].data['routeRef'],
                  style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MaterialButton(
                    elevation: 2,
                    height: 45,
                    child: Text(
                      'Update Driver',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {},
                    color: Colors.green,
                    shape: StadiumBorder(),
                  ),
                  MaterialButton(
                    elevation: 2,
                    height: 45,
                    child: Text(
                      'Update Route',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {},
                    color: Colors.green,
                    shape: StadiumBorder(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              MaterialButton(
                elevation: 2,
                height: 45,
                child: Text(
                  'Track',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {},
                color: Colors.green,
                shape: StadiumBorder(),
              ),
            ],
          ),
        ));
  }
}
