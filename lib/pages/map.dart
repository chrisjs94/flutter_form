import 'package:flutter/material.dart';
import 'package:flutter_form/shared/constants.dart';
import 'package:flutter_form/widgets/mapwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../core/scaffolds.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LocationData locationData;
  MapType mapType = MapType.normal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    locationData = ModalRoute.of(context)!.settings.arguments as LocationData;

    return Scaffolds(context).mapScaffold(
        appBarTitle: 'Mapa Interactivo',
        appBarActions: [
          IconButton(
              onPressed: () => Navigator.pop(context, locationData),
              icon: const Icon(Icons.save))
        ],
        pageBody: Stack(
          children: [
            MapWidget(
              locationData: locationData,
              currentMapType: mapType,
              onChangedLocation: (locationData) =>
                  {this.locationData = locationData},
            ),
            Positioned(
                bottom: 5,
                left: 5,
                child: Container(
                    height: 50,
                    color: Colors.white24
                        .withOpacity(0.5), // Ajusta la opacidad aquí
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: DropdownButton<MapType>(
                              value: mapType,
                              onChanged: (MapType? newMapType) {
                                if (newMapType != null) {
                                  setState(() {
                                    mapType = newMapType;
                                  });
                                }
                              },
                              items: mapTypes),
                        )))),
          ],
        ));
  }
}
