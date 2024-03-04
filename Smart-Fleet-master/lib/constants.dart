import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';

FirebaseUser currentUser;

String currentUserId;
String orgName;

String driverIdToTrack;

QuerySnapshot liveLocationData;

int routecount;
int vehilecount;

QuerySnapshot liveTrackingData;

LocationData currentLocation;
