import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


const double _defaultLatitude = 0.0;
const double _defaultLongitude = 0.0;
Completer<GoogleMapController> mapControllerCompleter = Completer();

Widget buildMap(LocationData locationData, double zoom){
  var latLng = LatLng(locationData.latitude ?? _defaultLatitude, locationData.longitude ?? _defaultLongitude);
  
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