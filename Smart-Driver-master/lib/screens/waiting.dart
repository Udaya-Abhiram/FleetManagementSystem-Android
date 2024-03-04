import 'package:flutter/material.dart';

class Waiting extends StatefulWidget {
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[100],
        child: Center(
          child: Text(
            'Waiting for approval',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
