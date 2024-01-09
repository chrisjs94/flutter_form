
import 'package:flutter/material.dart';

class Scaffolds{
  final BuildContext _context;
  
  Scaffolds(this._context);

  Scaffold homeScaffold({
    required String appBarTitle, 
    required Widget pageBody,
    required onFABPressed}){
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 8.0),
            Text(appBarTitle)
          ],
        )
      ),
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