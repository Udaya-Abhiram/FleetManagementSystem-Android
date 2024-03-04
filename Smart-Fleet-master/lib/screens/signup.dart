import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartfleet/constants.dart';
import 'package:smartfleet/services/curd.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email;
  String _password;

  CurdMethods curdObj = new CurdMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.green[100],
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 70),
            Image(
              image: AssetImage('assets/images/bus1.png'),
              height: 200,
            ),
            SizedBox(height: 10),
            Text(
              "Smart Fleet",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Signup',
                      style: TextStyle(fontSize: 25),
                    )),
              ],
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (val) {
                          _email = val;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[100],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        obscureText: true,
                        onChanged: (val) {
                          _password = val;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[100],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        elevation: 2,
                        height: 45,
                        child: Text(
                          'Signup',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((result) {
                            currentUser = result.user;
                            currentUserId = currentUser.uid.toString();
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacementNamed('/editprofile');
                          }).catchError((e) {
                            print(e.toString());
                          });
                        },
                        color: Colors.green,
                        shape: StadiumBorder(),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Have an account? ',
                            style: TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
