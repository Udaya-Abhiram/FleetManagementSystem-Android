import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriverSignup extends StatefulWidget {
  @override
  _DriverSignupState createState() => _DriverSignupState();
}

class _DriverSignupState extends State<DriverSignup> {
  String phoneNo, verificationId;

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
                          phoneNo = val;
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Colors.grey[100],
                          filled: true,
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // SizedBox(height: 10),
                      // TextField(
                      //   obscureText: true,
                      //   onChanged: (val) {},
                      //   decoration: InputDecoration(
                      //     hintText: 'Password',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     fillColor: Colors.grey[100],
                      //     filled: true,
                      //     prefixIcon: Icon(
                      //       Icons.vpn_key,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            elevation: 2,
                            height: 45,
                            child: Text(
                              'Signup',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              verifyPhone(phoneNo);
                            },
                            color: Colors.red,
                            shape: StadiumBorder(),
                          ),
                          SizedBox(width: 10),
                          MaterialButton(
                            elevation: 2,
                            height: 45,
                            child: Text(
                              'Old User',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/loginpage');
                            },
                            color: Colors.red,
                            shape: StadiumBorder(),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'NOTE',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                'Please contact your manager if you are new',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {};
    final PhoneVerificationFailed verificationFaild =
        (AuthException authException) {
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 500),
      verificationCompleted: verified,
      verificationFailed: verificationFaild,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
}
