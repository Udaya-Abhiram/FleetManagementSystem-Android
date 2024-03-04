import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartfleet/screens/signup.dart';
import 'package:smartfleet/constants.dart';
import 'package:smartfleet/globals.dart' as globals;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;

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
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Signin',
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
                          'Signin',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((result) async {
                            currentUser = result.user;
                            print(currentUser);
                            currentUserId = currentUser.uid.toString();
                            print(currentUserId);
                            // print(currentUser.uid);
                            // Navigator.of(context).pop();

                            Navigator.of(context)
                                .pushReplacementNamed('/homepage');
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
                            'New user? ',
                            style: TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text(
                              'Create an account',
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
