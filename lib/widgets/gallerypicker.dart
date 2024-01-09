import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryImages extends StatelessWidget {
  final List<XFile> images;
  const GalleryImages({
    required this.images, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            child: Image.file(
              File(images[index].path),
              fit: BoxFit.cover,
            ),
          );
        },
        childCount: images.length,
      ),
    );
  }
}