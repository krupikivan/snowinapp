import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:snowin/src/pages/community/search_tabs_pages/provider/marker_provider.dart';

class UserMap extends StatefulWidget {
  const UserMap({Key key}) : super(key: key);

  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition getPos(Position pos) {
    LatLng ltn = pos == null
        ? LatLng(-40.1976935, -71.3211168)
        : LatLng(pos.latitude, pos.longitude);
    CameraPosition cam = CameraPosition(
      target: ltn,
      zoom: 16,
    );
    return cam;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final markers = Provider.of<MarkerProvider>(context);
    final userLocation = Provider.of<Position>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: userLocation != null
          ? GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: getPos(userLocation),
              markers: markers.getMapMarkers)
          : Text('Cargando mapa...'),
    );
  }
}
