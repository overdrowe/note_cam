import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_cam/pages/camera_page.dart';
import 'package:note_cam/pages/home_page.dart';
import 'package:note_cam/singleton/app_data.dart';

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  with SingleTickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(initialIndex: 1, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "NoteCam",
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 0.4),
          )),
      bottomNavigationBar: ConvexAppBar(
        activeColor: Colors.black,
        color: Colors.black.withOpacity(0.4),
        controller: _tabController,
        backgroundColor: AppData().mainColor,
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.camera_alt),
          TabItem(icon: Icons.home),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CameraPage(),
          HomePage(),
        ],
      ),
    );
  }
}
