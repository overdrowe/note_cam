import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_cam/singleton/app_data.dart';
import 'package:note_cam/widgets/photo_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool isWelcomeClosed = false;

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
            key: UniqueKey(),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  padding: const EdgeInsets.fromLTRB(20, 20, 32, 20),
                  decoration: BoxDecoration(
                    color: AppData().mainColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      'Hello there! This is an application for capturing a photo and attaching product information to it for a '
                      'courier service.',
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
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
            color: !isWelcomeClosed ? AppData().mainColor : Colors.white,
            borderRadius: isWelcomeClosed
                ? null
                : BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                'Current photos:',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              StreamBuilder(
                  stream: AppData().photosStream.stream,
                  builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                    return GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.45,
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: [
                        ...AppData().photos.map((courierPhoto) => PhotoItem(photo: courierPhoto)),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
