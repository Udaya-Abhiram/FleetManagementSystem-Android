import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartfleet/globals.dart' as globals;

class CurdMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future currentUserId() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  Future getUserProfile() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userId = user.uid;
    return await Firestore.instance
        .collection('profiles')
        .where("uid", isEqualTo: userId)
        .getDocuments();
  }

  Future<void> saveProfile(profileData) async {
    Firestore.instance.collection('profiles').add(profileData).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addVehicle(vehicleData) async {
    Firestore.instance.collection('vehicles').add(vehicleData).catchError((e) {
      print(e.toString());
    });
  }

  getVehicles() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userId = user.uid;
    return await Firestore.instance
        .collection('vehicles')
        .where("uid", isEqualTo: userId)
        .getDocuments();
  }

  assignDriverAndRoute(selectedVehicle, driverAndRoute) async {
    Firestore.instance
        .collection('vehicles')
        .document(selectedVehicle)
        .updateData(driverAndRoute)
        .catchError((e) {
      print(e);
    });
  }

  assignRoute(selectedVehicle, route) async {
    Firestore.instance
        .collection('vehicles')
        .document(selectedVehicle)
        .updateData(route)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addDriver(driverData) async {
    Firestore.instance.collection('drivers').add(driverData).catchError((e) {
      print(e.toString());
    });
  }

  getDrivers() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userId = user.uid;
    return await Firestore.instance
        .collection('profiles')
        .where("role", isEqualTo: "driver")
        .getDocuments();
  }

  getNotifications() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userId = user.uid;
    print(userId);

    var docu = await Firestore.instance
        .collection('profiles')
        .where("uid", isEqualTo: userId)
        .getDocuments();
    await docu.documents.forEach((result) {
      globals.org = result.documentID;
    });
    return Firestore.instance
        .collection('notification')
        .where("orgId", isEqualTo: globals.org)
        .getDocuments();
  }

  Future<void> addRoute(routeData) async {
    Firestore.instance.collection('routes').add(routeData).catchError((e) {
      print(e.toString());
    });
  }

  getRoutes() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userId = user.uid;
    return await Firestore.instance
        .collection('routes')
        .where("uid", isEqualTo: userId)
        .getDocuments();
  }
}
