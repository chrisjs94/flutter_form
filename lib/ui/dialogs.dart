import 'package:flutter/material.dart';

class Dialogs{
  late final BuildContext _context;

  Dialogs(this._context);

  Future<void> showAlert(String title, Widget body){
    return showDialog(
      context: _context, 
      builder: (BuildContext buildContext){
        return AlertDialog(
          title: Text(title),
          content: body,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(buildContext).pop();
            }, 
            child: const Text('Aceptar'))
        ]);
      });
  }

  showSnackBar(String content){
    ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
      content: Text(content),
    ));
  }
}