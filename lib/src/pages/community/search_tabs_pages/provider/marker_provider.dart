import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snowin/src/models/user.dart';

class MarkerProvider with ChangeNotifier {
  //marker info---------------------------------------
  final Set<Marker> _markers = <Marker>{};
  Set<Marker> get getMapMarkers => _markers;

  BitmapDescriptor _locPin;
  BitmapDescriptor _skyPinD; //Sky Disable
  BitmapDescriptor _snowPinE; //Snow Enable
  BitmapDescriptor _snowPinD; //Snow Disable
  BitmapDescriptor _skyPinE; //Ski Enable

  getPositions(Position pos, List<User> list) async {
    await _setIcons();
    _markers.add(Marker(
        markerId: MarkerId('locPin'),
        position: LatLng(pos.latitude, pos.longitude),
        icon: _locPin));
    list.forEach((element) {
      _markers.add(Marker(
          markerId: MarkerId('${element.id}'),
          position: LatLng(element.latitud, element.longitud),
          icon: _getIcon(element.actividad)));
    });
    notifyListeners();
  }

  BitmapDescriptor _getIcon(UserActivity actividad) {
    switch (actividad) {
      case UserActivity.SKY:
        return _skyPinE;
        break;
      case UserActivity.SNOWBOARD:
        return _snowPinE;
        break;
      default:
        return _snowPinE;
    }
  }

  Future _setIcons() async {
    final double ratio =
        TargetPlatform.android == TargetPlatform.android ? 2 : 1;
    _locPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: ratio),
        'assets/pin/locationPin.png');

    _skyPinD = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: ratio), 'assets/pin/skyPinD.png');

    _skyPinE = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: ratio), 'assets/pin/skyPinE.png');

    _snowPinD = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: ratio), 'assets/pin/snowPinD.png');

    _snowPinE = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: ratio), 'assets/pin/snowPinE.png');

    notifyListeners();
  }
}
