import 'package:flutter/material.dart';
import 'package:location/location.dart';

Future<LocationData> getLocation() async {
  try {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception(
            'Service is not enabled, please enable for continue...');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception(
            'Permissions are not granted, please grant to app for use location service...');
      }
    }

    //Obtiene la posición actual
    LocationData currentLocation = await location.getLocation();
    debugPrint(
        "Latitud: ${currentLocation.latitude}, Longitud: ${currentLocation.longitude}");

    return currentLocation;
  } catch (e) {
    debugPrint("Error al obtener la ubicacion: $e");
    rethrow;
  }
}
