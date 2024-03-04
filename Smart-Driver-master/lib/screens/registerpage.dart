import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartdriver/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.red[100],
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 60),
            Image(
              image: AssetImage('assets/images/driver1.png'),
              height: 200,
            ),
            SizedBox(height: 10),
            Text(
              "Smart Driver",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: 25,
                      ),
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
                          }).then((results) {
                            Navigator.of(context)
                                .pushReplacementNamed('/editprofile');
                          }).catchError((e) {
                            print(e.toString());
                          });
                        },
                        color: Colors.red,
                        shape: StadiumBorder(),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Old user? ',
                            style: TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/loginpage');
                            },
                            child: Text(
                              'Log in',
                              style: TextStyle(fontSize: 20, color: Colors.red),
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
