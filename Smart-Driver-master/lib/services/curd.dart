import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartdriver/constants.dart';

class CurdMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future getUserProfile() async {
    return await Firestore.instance
        .collection('profiles')
        .where("uid", isEqualTo: currentUserId)
        .getDocuments();
  }

  Future getVehicleData() async {
    return await Firestore.instance
        .collection('vehicles')
        .document(vehicleId)
        .get();
  }

  Future getRouteData() async {
    return await Firestore.instance
        .collection('routes')
        .document(routeId)
        .get();
  }

  Future<void> saveProfile(profileData) async {
    Firestore.instance.collection('profiles').add(profileData).catchError((e) {
      print(e.toString());
    });
  }
}
