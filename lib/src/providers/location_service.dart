import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:snowin/src/repository/snowin_repository.dart';

class LocationService {
  Position _currentPosition;
  Location location = Location();
  Position get position => _currentPosition;

  StreamController<Position> _locationController = StreamController.broadcast();
  Stream<Position> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if (PermissionStatus.granted == granted) {
        location.onLocationChanged.listen((locationData) async {
          if (locationData != null) {
            _currentPosition = Position(
                speed: locationData.speed,
                latitude: locationData.latitude,
                longitude: locationData.longitude,
                altitude: locationData.altitude);
            _locationController.add(_currentPosition);
            print(
                "Posicion del usuario: Lat: ${locationData.latitude}, Lon: ${locationData.longitude}");
            SnowinRepository().posicion(_currentPosition);
          }
        });
      }
    });
  }

  // Future<Position> getLocation() async {
  //   try {
  //     var userLocation = await location.getLocation();
  //     _currentPosition = Position(
  //         latitude: userLocation.latitude,
  //         longitude: userLocation.longitude,
  //         altitude: userLocation.altitude);
  //     await MarkerProvider().getMyLocation(_currentPosition);
  //     print(
  //         "Posicion del usuario: Lat: ${userLocation.latitude}, Lon: ${userLocation.longitude}");
  //   } catch (e) {
  //     print('No se obtuvo la posicion');
  //   }
  //   return _currentPosition;
  // }

}
