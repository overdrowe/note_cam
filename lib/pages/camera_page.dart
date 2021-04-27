import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:note_cam/singleton/save_image.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CameraCamera(onFile: (file) {
      SaveImage().savePhoto(file);
    });
  }
}
