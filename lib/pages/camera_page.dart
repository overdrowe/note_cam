import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:note_cam/pages/creating_photo_page/creating_photo_page.dart';

class CameraPage extends StatelessWidget {
  Location location = new Location();

  late bool _serviceEnabled;

  late PermissionStatus _permissionGranted;

  late LocationData _locationData;

  @override
  Widget build(BuildContext context) {
    initLocation();
    return CameraCamera(onFile: (file) {
      createPhotoItem(file, context);
    });
  }

  Future<void> initLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> createPhotoItem(File file, BuildContext context) async {
    _locationData = await location.getLocation();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CreatingPhotoPage(file: file, locationData: _locationData)));
  }
}
