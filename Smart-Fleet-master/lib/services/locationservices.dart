import 'package:location/location.dart';

class LocationMethods {
  getMyLocation() async {
    var location = new Location();
    return await location.getLocation();
  }
}
