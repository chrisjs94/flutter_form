import 'package:location/location.dart';

Future<LocationData> getCurrentLocation(Function callback) async {
  try{
    Location location = Location();
    bool serviceEnabled; PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled){
      serviceEnabled = await location.requestService();
      if (!serviceEnabled){
        throw Exception('Service is not enabled, please enable for continue...');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied){
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted){
        throw Exception('Permissions are not granted, please grant to app for use location service...');
      }
    }

    //Obtiene la posición actual
    LocationData currentLocation = await location.getLocation();
    print("Latitud: ${currentLocation.latitude}, Longitud: ${currentLocation.longitude}");

    callback(currentLocation);

    return currentLocation;
  }
  catch (e){
    print("Error al obtener la ubicacion: $e");
    rethrow;
  }
}