import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:note_cam/models/courier_photo.dart';
import 'package:note_cam/pages/main_page.dart';
import 'package:note_cam/singleton/app_data.dart';
import 'package:note_cam/singleton/save_image.dart';

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class CreatingPhotoPage extends StatelessWidget {
  final File file;
  final LocationData locationData;
  final GlobalKey globalKey = new GlobalKey();

  CreatingPhotoPage({Key? key, required this.file, required this.locationData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Save photo",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 0.4),
          ),
          centerTitle: true,
        ),
        body: RepaintBoundary(
          key: globalKey,
          child: Stack(
            children: [
              Image.file(file,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height),
              Positioned(
                  left: 20,
                  bottom: 20,
                  child: Text(
                    locationData.latitude.toString() + '\n' + locationData.longitude.toString(),
                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _onSaveTaped(context);
          },
          label: Text(
            "Save",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(initTab: 0)));
    return true;
  }

  Future<bool> _onSaveTaped(BuildContext context) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(initTab: 0)));
    _takeScreenshot();
    return true;
  }

  void _takeScreenshot() async {
    RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = (await image.toByteData(format: ui.ImageByteFormat.png))!;
    Uint8List pngBytes = byteData.buffer.asUint8List();
    File imgFile = new File('$directory/screenshot.png');

    imgFile.writeAsBytes(pngBytes);
    _savePhoto(imgFile, pngBytes);
  }

// _savefile(File file) async {
//   await _askPermission();
//   final result = await ImageGallerySaver.saveImage(
//       Uint8List.fromList(await file.readAsBytes()));
//   print(result);
// }

// _askPermission() async {
//   Map<PermissionGroup, PermissionStatus> permissions =
//   await PermissionHandler().requestPermissions([PermissionGroup.photos]);
// }

  void _savePhoto(File file, Uint8List pngBytes) {
    AppData().photos.add(new CourierPhoto(photo: file, locationData: locationData));
    AppData().photosStream.add(file);
    SaveImage().savePhoto(pngBytes);
  }
}
