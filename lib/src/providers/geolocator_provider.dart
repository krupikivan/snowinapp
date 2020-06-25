import 'package:geolocator/geolocator.dart';

class GeolocatorProvider {
  Position currentPosition;

  getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      currentPosition = position;
    }).catchError((e) {
      print(e);
    });
  }
}
