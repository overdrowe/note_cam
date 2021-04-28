import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_cam/singleton/app_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isWelcomeClosed = false;
  GlobalKey _key = new GlobalKey();

  List<Widget> _imageList = [
    FlutterLogo(),
    FlutterLogo(),
    FlutterLogo(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _welcomeMessage(),
        _photosList(),
      ],
    );
  }

  Widget _welcomeMessage() {
    return !isWelcomeClosed
        ? Dismissible(
            onDismissed: (direction) {
              setState(() {
                isWelcomeClosed = true;
              });
            },
            key: _key,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  padding: const EdgeInsets.fromLTRB(20, 20, 32, 20),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'Hello there! This is an application for capturing a photo and attaching product information to it for a '
                      'courier service.',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                    top: 12,
                    right: 12,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(Icons.cancel, color: Colors.black.withOpacity(0.5), size: 18),
                        ),
                        onTap: () {
                          setState(() {
                            isWelcomeClosed = true;
                          });
                        },
                      ),
                    )),
              ],
            )) // Просто виджет с текстом внутри
        : Container();
  }

  Widget _photosList() {
    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        decoration: BoxDecoration(
            color: !isWelcomeClosed ? Colors.red : Colors.white,
            borderRadius: isWelcomeClosed
                ? null
                : BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Current photos:',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                  stream: AppData().photosStream.stream,
                  builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                    if(snapshot.data != null) AppData().photos.add(snapshot.data!);
                    return GridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: [
                        ..._imageList,
                        ...AppData().photos.map((file) => Image.file(
                              file,
                              fit: BoxFit.cover,
                            )),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
