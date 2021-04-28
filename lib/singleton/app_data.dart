import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class AppData{

  static final AppData _appData = AppData._internal();

  factory AppData() {
    return _appData;
  }

  AppData._internal();

  MaterialColor ? mainColor = Colors.red;
  List<File> photos = [];
  final photosStream = StreamController<File>();

}