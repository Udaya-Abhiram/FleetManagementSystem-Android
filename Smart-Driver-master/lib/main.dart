import 'package:flutter/material.dart';
import 'package:smartdriver/screens/editprofile.dart';
import 'package:smartdriver/screens/home.dart';
import 'package:smartdriver/screens/loginagain.dart';
import 'package:smartdriver/screens/loginpage.dart';
import 'package:smartdriver/screens/map.dart';
import 'package:smartdriver/screens/registerpage.dart';
import 'package:smartdriver/screens/selectorg.dart';
import 'package:smartdriver/screens/mapscreen.dart';
import 'package:smartdriver/screens/waiting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Login(), routes: <String, WidgetBuilder>{
      '/landingpage': (BuildContext context) => new MyApp(),
      '/loginpage': (BuildContext context) => Login(),
      '/editprofile': (BuildContext context) => EditProfile(),
      '/loginagain': (BuildContext context) => LoginAgain(),
      '/waiting': (BuildContext context) => Waiting(),
      '/signuppage': (BuildContext context) => Register(),
      '/selectorg': (BuildContext context) => SeleceOrg(),
      // '/mapscreen': (BuildContext context) => MapScreen(),
      '/home': (BuildContext context) => HomePage(),
      '/map': (BuildContext context) => MapScreen()
    });
  }
}
