import 'package:fhiquo/widgets/camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CameraView extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fhiquo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Rubik',
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CameraScreen(),
    );
  }
}