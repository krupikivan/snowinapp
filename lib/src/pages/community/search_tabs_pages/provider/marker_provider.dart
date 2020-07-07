import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerProvider with ChangeNotifier {
  //marker info---------------------------------------
  final Set<Marker> _markers = <Marker>{};
  Set<Marker> get getMapMarkers => _markers;

  BitmapDescriptor _locPin;
  BitmapDescriptor _bitPin1;
  BitmapDescriptor _bitPin2;

  // MarkerProvider.init() {
  //   _getMarkers();
  // }

  getMarkers(Position userPos) async {
    await _setIcons();
    _markers.add(Marker(
        markerId: MarkerId('locPin'),
        position: LatLng(userPos.latitude, userPos.longitude),
        icon: _locPin));
  }

  Future _setIcons() async {
    final double ratio =
        TargetPlatform.android == TargetPlatform.android ? 2 : 1;
    _locPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: ratio),
        'assets/pin/locationPin.png');

    _bitPin1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: ratio), 'assets/pin/skyPinD.png');

    _bitPin2 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: ratio), 'assets/pin/snowPinE.png');

    notifyListeners();
  }
}
