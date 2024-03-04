import 'package:flutter/material.dart';
import 'package:smartfleet/screens/driverlist.dart';
import 'package:smartfleet/screens/editProfile.dart';
import 'package:smartfleet/screens/home.dart';
import 'package:smartfleet/screens/login.dart';
import 'package:smartfleet/screens/mapscreen.dart';
import 'package:smartfleet/screens/notifications.dart';
import 'package:smartfleet/screens/profile.dart';
import 'package:smartfleet/screens/routeslist.dart';
import 'package:smartfleet/screens/trackingScreen.dart';
import 'package:smartfleet/screens/vehiclelist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Login(), routes: <String, WidgetBuilder>{
      '/landingpage': (BuildContext context) => new MyApp(),
      '/homepage': (BuildContext context) => HomePage(),
      '/notificationpage': (BuildContext context) => NotificationPage(),
      '/editprofile': (BuildContext context) => EditProfile(),
      '/vehiclelist': (BuildContext context) => VehicleList(),
      '/profilepage': (BuildContext context) => Profile(),
      '/driverlist': (BuildContext context) => DriverList(),
      '/routelist': (BuildContext context) => RoutesList(),
      '/tracking': (BuildContext context) => TrackingScreen(),
      '/mapscreen': (BuildContext context) => MapScreen()
    });
  }
}
