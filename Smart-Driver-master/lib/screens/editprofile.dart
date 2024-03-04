import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartdriver/services/curd.dart';
import 'package:smartdriver/constants.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _driverName;
  String _licenceId;
  String _phone;

  CurdMethods curdObj = new CurdMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Profile',
                      style: TextStyle(fontSize: 40, color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TextField(
                  onChanged: (val) {
                    _driverName = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (val) {
                    _licenceId = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Licence Id',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (val) {
                    _phone = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  elevation: 2,
                  height: 45,
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  onPressed: () async {
                    FirebaseUser user =
                        await FirebaseAuth.instance.currentUser();
                    var uid = user.uid;
                    driverName = this._driverName;
                    Map<String, String> profileData = {
                      'Name': this._driverName,
                      'licenceid': this._licenceId,
                      'phone': this._phone,
                      'uid': uid,
                      'role': 'driver',
                      'accepted': 'false',
                      'orgId': 'null'
                    };
                    curdObj.saveProfile(profileData).then((results) {
                      Navigator.of(context).pushReplacementNamed('/selectorg');
                      print('profile saved');
                    }).catchError((e) {
                      print(e.toString());
                    });
                  },
                  color: Colors.red,
                  shape: StadiumBorder(),
                ),
              ],
            ),
          )),
    );
  }
}
