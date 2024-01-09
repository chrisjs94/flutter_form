import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../controls/mapbuilder.dart';
import '../ui/circularprogress.dart';

class SliverAppBarMapForm extends StatelessWidget {
  final Widget gallery; final dynamic onSaveButtonClick; final dynamic onMapButtonClick, onPickImageFromGalleryButtonClick,  onPickImageFromCameraButtonClick;
  final String appBarTitle; final Widget pageBody; final LocationData? currentLocation;
  
  const SliverAppBarMapForm({
    required this.appBarTitle,
    required this.gallery,
    required this.pageBody,
    required this.onPickImageFromGalleryButtonClick,
    required this.onPickImageFromCameraButtonClick,
    required this.onSaveButtonClick,
    required this.onMapButtonClick,
    this.currentLocation,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onSaveButtonClick,
        child: const Icon(Icons.save),
      ),
      body: currentLocation == null ? circularProgress('La aplicación está intentando obtener las coordenadas más actuales y precisas de su dispositivo, espere un momento por favor...') : 
      CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            floating: false,
            snap: false,
            pinned: true,
            actions: [
              IconButton(
                onPressed: onPickImageFromCameraButtonClick, icon: const Icon(Icons.camera_alt)
              ),
              IconButton(
                onPressed: onPickImageFromGalleryButtonClick, icon: const Icon(Icons.folder)
              ),
              IconButton(
                onPressed: onMapButtonClick, icon: const Icon(Icons.map)
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(appBarTitle, textScaleFactor: 0.8, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), 
              titlePadding: const EdgeInsetsDirectional.only(start: 50.0, bottom: 16.0),
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
              background: StaticMap(
                locationData: currentLocation as LocationData,
                zoom: 18.0
              )
            )
          ),
          
          gallery,
          
          SliverList(
            delegate: SliverChildListDelegate([
              pageBody
            ])
          )
        ],
      ),
    );
  }
}