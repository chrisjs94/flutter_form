import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const int dbVersion = 3;
const String dbName = 'records_database.db';

const double defaultLatitude = 0.0;
const double defaultLongitude = 0.0;

const List<DropdownMenuItem<MapType>> mapTypes = [
    DropdownMenuItem<MapType>(
      value: MapType.normal,
      child: Text('Normal'),
    ),
    DropdownMenuItem<MapType>(
      value: MapType.satellite,
      child: Text('Satélite'),
    ),
    DropdownMenuItem<MapType>(
      value: MapType.hybrid,
      child: Text('Híbrido'),
    ),
    DropdownMenuItem<MapType>(
      value: MapType.terrain,
      child: Text('Terreno'),
    )
];