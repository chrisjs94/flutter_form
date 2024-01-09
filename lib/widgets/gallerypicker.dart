import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryImages extends StatelessWidget {
  final List<XFile> images; final dynamic onDeleted;
  const GalleryImages({
    required this.images,
    required this.onDeleted,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Número de columnas en la cuadrícula
        crossAxisSpacing: 5.0, // Espaciado horizontal entre elementos
        mainAxisSpacing: 5.0, // Espaciado vertical entre elementos
        childAspectRatio: 1.0
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Card(
            color: Colors.grey[200],
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.file(
                        File(images[index].path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        onDeleted(index);
                      },
                    ),
                  ],
                  
                ),
              )
            ),
          );
        },
        childCount: images.length,
      ),
    );
  }
}