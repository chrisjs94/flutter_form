import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form/shared/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class StaticMap extends StatelessWidget{
  
  final Completer<GoogleMapController> mapControllerCompleter = Completer();
  final LocationData locationData; final double zoom;

  StaticMap({
    required this.locationData,
    required this.zoom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var latLng = LatLng(locationData.latitude ?? defaultLatitude, locationData.longitude ?? defaultLongitude);
    
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        mapControllerCompleter.complete(controller);
      },
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: latLng,
        zoom: zoom
      ),
      markers: {
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: latLng,
          infoWindow: const InfoWindow(
            title: 'Ubicación actual'
          )
        )
      },
    );
  }
}