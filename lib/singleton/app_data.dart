import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_cam/models/courier_photo.dart';

class AppData{

  static final AppData _appData = AppData._internal();

  factory AppData() {
    return _appData;
  }

  AppData._internal();

  MaterialColor ? mainColor = Colors.amber;
  List<CourierPhoto> photos = [];
  final StreamController<File> photosStream = StreamController<File>.broadcast();
}