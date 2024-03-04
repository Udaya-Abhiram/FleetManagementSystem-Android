import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginAgain extends StatefulWidget {
  @override
  _LoginAgainState createState() => _LoginAgainState();
}

class _LoginAgainState extends State<LoginAgain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[100],
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Please logout and login again..!',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 10),
              MaterialButton(
                elevation: 2,
                height: 45,
                child: Text(
                  'Siginout',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((results) {
                    Navigator.of(context).pushReplacementNamed('/loginpage');
                  }).catchError((e) {
                    print(e.toString());
                  });
                },
                color: Colors.red,
                shape: StadiumBorder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
