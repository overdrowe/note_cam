import 'package:flutter/material.dart';
import 'package:note_cam/models/courier_photo.dart';
import 'package:photo_view/photo_view.dart';

class PhotoItem extends StatelessWidget {

  final CourierPhoto photo;

  const PhotoItem({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Hero(
                tag: photo.photo.path,
                child: PhotoView(imageProvider:
                FileImage(photo.photo)))));
      },
      child: Hero(
        tag: photo.photo.path,
        child: Image.file(
          photo.photo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
