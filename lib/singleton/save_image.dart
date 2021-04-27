import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveImage {
  static final SaveImage _saveImage = SaveImage._internal();

  factory SaveImage() {
    return _saveImage;
  }

  SaveImage._internal();

  void savePhoto(File recordedImage) async {
      final result = await ImageGallerySaver.saveImage(recordedImage.readAsBytesSync());
      print(result);
  }
}
