import 'package:flutter/material.dart';

Stack circularProgress([String message = 'Cargando...']){
  return Stack(
    children: [
      // Fondo del CircularProgressIndicator
      Center(
        child: Container(
          color: Colors.black.withOpacity(0.9), // Ajusta la opacidad según tus preferencias
        ),
      ),
      // CircularProgressIndicator centrado
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Un momento por favor',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            const CircularProgressIndicator(),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            )
          ],
        ),
      )
    ]
  );
}