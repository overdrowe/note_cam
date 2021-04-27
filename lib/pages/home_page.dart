import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          !isWelcomeClosed ? _welcomeMessage() : Container(),
        ],
      ),
    );
  }

  Widget _welcomeMessage() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 32, 20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              'Hello there! This is an application for capturing a photo and attaching product information to it for a '
              'courier service.',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ),
        Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              customBorder: CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.cancel, color: Colors.black.withOpacity(0.5), size: 18),
              ),
              onTap: () {
                setState(() {
                  isWelcomeClosed = true;
                });
              },
            )),
      ],
    );
  }
}
