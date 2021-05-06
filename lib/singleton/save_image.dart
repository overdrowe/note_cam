import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveImage {
  static final SaveImage _saveImage = SaveImage._internal();

  factory SaveImage() {
    return _saveImage;
  }

  SaveImage._internal();

  void savePhoto(Uint8List pngBytes) async {
      // final result = await ImageGallerySaver.saveImage(recordedImage.readAsBytesSync());
      final result = await ImageGallerySaver.saveImage(pngBytes);
      print(result);
  }
}
