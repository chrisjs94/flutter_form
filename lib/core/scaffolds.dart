
import 'package:flutter/material.dart';
import 'package:wp_search_bar/wp_search_bar.dart';

class Scaffolds{
  final BuildContext _context;
  
  Scaffolds(this._context);

  Widget homeScaffold({
    required String appBarTitle, 
    required Widget pageBody,
    required onSearchAction,
    required onFABPressed}){
    return WPSearchBar(
      appBarBackgroundColor: const Color(0xff1f2c34),
      listOfFilters: const {
          'name': {
            'name': 'name',
            'selected': false,
            'title': 'Nombres y Apellidos',
            'operation': 'CONTAINS',
            'icon': Icons.supervised_user_circle_rounded,
          },
          'description': {
            'name': 'description',
            'selected': false,
            'title': 'Descripción',
            'operation': 'CONTAINS',
            'icon': Icon(Icons.message),
          }
        },
      materialDesign: {
        'title': { 'text': appBarTitle },
        'loadingIndicator': Transform.scale(
          scale: 0.5,
          child: const CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
        'textField': const {
          'cursorColor': Colors.white,
          'style': TextStyle(color: Colors.white),
          'decoration': InputDecoration(
              hintText: "Buscar...",
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              )),
        },
      },
      onSearch: (filter, value, operation) {
        debugPrint(filter);
        onSearchAction(filter, value, operation);
      },
      body: pageBody,
      floatingActionButton: FloatingActionButton(
        onPressed: onFABPressed,
        child: const Icon(Icons.add)
      )
    );
  }

  Scaffold formScaffold({required String appBarTitle, required String backRoute, required Widget pageBody}){
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            onPressed: () => Navigator.popAndPushNamed(_context, backRoute), 
            icon: const Icon(Icons.camera)
          ),
          IconButton(
            onPressed: () => Navigator.popAndPushNamed(_context, backRoute), 
            icon: const Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: pageBody,
    );
  }

  Scaffold mapScaffold({required String appBarTitle, required Widget pageBody, required List<Widget> appBarActions}){
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: appBarActions,
      ),
      body: pageBody,
    );
  }
}