import 'dart:async';
import 'package:flutter/material.dart';
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

  CameraPosition initPosition = CameraPosition(
    target: LatLng(-40.1976935, -71.3211168),
    zoom: 16,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final markers = Provider.of<MarkerProvider>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.5,
      child: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition: initPosition,
          markers: markers.getMapMarkers),
    );
  }
}
