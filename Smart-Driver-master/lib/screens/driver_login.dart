import 'package:flutter/material.dart';
// import 'package:smartdriver/constants.dart';

class DriverLogin extends StatefulWidget {
  @override
  _DriverLoginState createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {
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
                        onChanged: (val) {},
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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            elevation: 2,
                            height: 45,
                            child: Text(
                              'Send OTP',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              print('send otp');
                            },
                            color: Colors.red,
                            shape: StadiumBorder(),
                          ),
                          SizedBox(width: 10),
                          MaterialButton(
                            elevation: 2,
                            height: 45,
                            child: Text(
                              'New User',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signuppage');
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
}
