import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

String driverName;
String orgId;
String vehicleId;
String routeId;
String driverPhoneNumber;
String driverLicence;
String accepted;

String liveLocationId;

DocumentSnapshot vehicleData;
DocumentSnapshot routeData;
QuerySnapshot orgData;

FirebaseUser currentUser;
String currentUserId;
String orgName;

LocationData currentLocation;
Location fromLocation;
Location toLocation;
