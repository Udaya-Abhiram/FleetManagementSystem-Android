import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartfleet/services/curd.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _orgName;
  String _orgType = 'Organization type';
  String _city;
  String _state;
  var _logoUrl;

  File _image;

  CurdMethods curdObj = new CurdMethods();

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
    }

    Future uploadPic(BuildContext context) async {
      String filename = basename(_image.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(filename);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      // _logoUrl = await firebaseStorageRef.getDownloadURL();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Profile pic saved..!')));
    }

    return Scaffold(
      backgroundColor: Colors.green[100],
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
                      style: TextStyle(fontSize: 40, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                TextField(
                  onChanged: (val) {
                    _orgName = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Organization Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    DropdownButton(
                      value: _orgType,
                      icon: Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      underline: Container(
                        height: 5,
                        color: Colors.grey,
                      ),
                      onChanged: (String newVal) {
                        setState(() {
                          _orgType = newVal;
                        });
                      },
                      items: <String>[
                        'Organization type',
                        'school',
                        'college',
                        'hospital',
                        'travel',
                        'software'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (val) {
                    _city = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'City',
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
                    _state = val;
                  },
                  decoration: InputDecoration(
                    hintText: 'State',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: (_image != null)
                            ? FileImage(_image)
                            : AssetImage('assets/images/yourlogohere.png'),
                        height: 100,
                      ),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.upload),
                          onPressed: () {
                            getImage();
                          }),
                      IconButton(
                          icon: FaIcon(FontAwesomeIcons.save),
                          onPressed: () {
                            uploadPic(context);
                          })
                    ]),*/
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
                    Map<String, String> profileData = {
                      'orgName': this._orgName,
                      'orgType': this._orgType,
                      'city': this._city,
                      'state': this._state,
                      'uid': uid,
                      'role': 'org',
                      'logoUrl':
                          'https://cdn.pixabay.com/photo/2018/04/18/18/56/user-3331257__340.png',
                    };
                    curdObj.saveProfile(profileData).then((results) {
                      Navigator.of(context).pushReplacementNamed('/homepage');
                      print('profile saved');
                    }).catchError((e) {
                      print(e.toString());
                    });
                  },
                  color: Colors.green,
                  shape: StadiumBorder(),
                ),
              ],
            ),
          )),
    );
  }
}
