import 'package:flutter/material.dart';
import 'package:note_cam/pages/main_page.dart';
import 'package:note_cam/singleton/app_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppData().mainColor,
      ),
      home: MainPage(),
    );
  }
}