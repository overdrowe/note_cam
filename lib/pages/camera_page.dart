import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:note_cam/models/courier_photo.dart';
import 'package:note_cam/singleton/app_data.dart';
import 'package:note_cam/singleton/save_image.dart';

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CameraCamera(onFile: (file) {
      createPhotoItem(file);
      AppData().photosStream.add(file);
      SaveImage().savePhoto(file);
    });
  }

  Future<void> createPhotoItem(File file) async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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

    _locationData = await location.getLocation();

    AppData().photos.add(new CourierPhoto(photo: file, locationData: _locationData));
  }
}
