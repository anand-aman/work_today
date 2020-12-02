import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationData {
  double glatitude;
  double glongitude;
  Position pos;
  String city;
  String postalCode;
  final Geolocator geolocator = Geolocator();
  Future<String> getCurrentlocation() async {
    try {
      pos = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      glongitude = pos.longitude;
      glatitude = pos.latitude;
      print(glatitude);
      print("latitude");
      return _getAddressFromLatLng();
    } catch (e) {
      print(e);
    }
  }

  Future<String> _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(glatitude, glongitude);

      Placemark place = p[0];
      city = "${place.locality}";
      postalCode = "${place.postalCode}";
      return city;
    } catch (e) {
      print(e);
    }
  }
}
