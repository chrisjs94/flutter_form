import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../shared/constants.dart';

class MapWidget extends StatefulWidget {
  LocationData locationData; MapType currentMapType;
  final dynamic onChangedLocation;

  MapWidget({
    required this.locationData,
    required this.currentMapType,
    required this.onChangedLocation, 
    super.key
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  late LatLng _markerPosition;

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  @override
  void initState() {
    super.initState();

    _markerPosition = LatLng(widget.locationData.latitude ?? defaultLatitude, widget.locationData.longitude ?? defaultLongitude);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      key: widget.key,
      myLocationEnabled: true,
      compassEnabled: true,
      mapToolbarEnabled: true,
      onMapCreated: _onMapCreated,
      mapType: widget.currentMapType,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.locationData.latitude ?? defaultLatitude, widget.locationData.longitude ?? defaultLongitude),
        zoom: 15.0,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('draggable-marker'),
          position: _markerPosition,
          draggable: true,
          onDragEnd: _onMarkerDragEnd,
        ),
      },
    );
  }

  Future<void> _onMarkerDragEnd(LatLng position) async {
    _markerPosition = position;
    widget.locationData = LocationData.fromMap({
      "latitude": position.latitude,
      "longitude": position.longitude,
    });

    widget.onChangedLocation(widget.locationData);

    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: await controller.getZoomLevel()
        )
      ));
  }
}