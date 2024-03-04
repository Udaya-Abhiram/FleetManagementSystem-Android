import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartdriver/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;

  QuerySnapshot profileData;
  QuerySnapshot keyData;
  String isAccepted;
  String key;
  getKey() async {
    String lock;
    keyData = await Firestore.instance.collection('key').getDocuments();
    lock = keyData.documents[0].data['lock'];
    print(lock.toString());
    return lock.toString();
  }

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
                      'Signin',
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
                          'Signin',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        onPressed: () async {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email, password: _password)
                              .then((result) async {
                            currentUser = result.user;
                            // print(result);
                            currentUserId = currentUser.uid.toString();
                            key = getKey().toString();
                            print(key);
                            profileData = await Firestore.instance
                                .collection('profiles')
                                .where('uid', isEqualTo: currentUserId)
                                .getDocuments();
                            isAccepted =
                                profileData.documents[0].data['accepted'];
                          }).then((results) async {
                            if (isAccepted == "true") {
                              driverName =
                                  profileData.documents[0].data['Name'];
                              orgId = profileData.documents[0].data['orgId'];
                              driverLicence =
                                  profileData.documents[0].data['licenceid'];
                              driverPhoneNumber =
                                  profileData.documents[0].data['phone'];
                              vehicleId =
                                  profileData.documents[0].data['vehicleId'];
                              routeId =
                                  profileData.documents[0].data['routeId'];
                              vehicleData = await Firestore.instance
                                  .collection('vehicles')
                                  .document(vehicleId)
                                  .get();
                              routeData = await Firestore.instance
                                  .collection('routes')
                                  .document(routeId)
                                  .get();
                              orgData = await Firestore.instance
                                  .collection('profiles')
                                  .where('uid', isEqualTo: orgId)
                                  .getDocuments();
                              Navigator.of(context)
                                  .pushReplacementNamed('/home');
                            } else if (isAccepted == "false") {
                              Navigator.of(context)
                                  .pushReplacementNamed('/waiting');
                            }
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
                            'New user? ',
                            style: TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/signuppage');
                            },
                            child: Text(
                              'Create an account',
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
