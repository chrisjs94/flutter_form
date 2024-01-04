import 'package:flutter/material.dart';
import 'package:flutter_form/controls/mapbuilder.dart';
import 'package:flutter_form/ui/circularprogress.dart';
import 'package:location/location.dart';

class Scaffolds{
  final BuildContext _context;
  
  Scaffolds(this._context);

  Scaffold homeScaffold({
    required String appBarTitle, 
    required Widget pageBody,
    required onFABPressed}){
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: pageBody,
      floatingActionButton: FloatingActionButton(
        onPressed: onFABPressed,
        child: const Icon(Icons.add)
      ),
    );
  }

  Scaffold formScaffold({required String appBarTitle, required String backRoute, required Widget pageBody}){
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            onPressed: () => Navigator.popAndPushNamed(_context, backRoute), 
            icon: const Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: pageBody,
    );
  }

  Scaffold formScaffoldWithSliverAppBar({
    required String appBarTitle,
    required Widget pageBody,
    required LocationData? currentLocation,
    required onSaveButtonClick}){
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(_context).size.height * 0.6,
            floating: false,
            snap: false,
            pinned: true,
            actions: [
              const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 28.0,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1547721064-da6cfb341d50'),
                  ),
                ),
              IconButton(
                onPressed: onSaveButtonClick, 
                icon: const Icon(Icons.save)
              )
            ],
            flexibleSpace: ClipRRect(
              //borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
              child: FlexibleSpaceBar(
                title: Text(appBarTitle, textScaleFactor: 0.8, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                titlePadding: const EdgeInsetsDirectional.only(start: 50.0, bottom: 16.0),
                collapseMode: CollapseMode.parallax,
                centerTitle: false,
                background: Container(
                  child: currentLocation == null ? circularProgress() : MapBuilder().buildMap(currentLocation, 18.0)
                )
              ),
            )
          ),
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