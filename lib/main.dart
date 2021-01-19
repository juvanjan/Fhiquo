import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fhiquo/list_view.dart';

Future<void> main() async {
  runApp(MaterialApp(
    home: NListView(),
  ));
}

Map<int, Color> todoColor01 =
{
  50:Color.fromRGBO(255,0,0, 1),
  100:Color.fromRGBO(0,255,0, 1),
  200:Color.fromRGBO(0,0,255, 1),
  300:Color.fromRGBO(255,255,0, 1),
  400:Color.fromRGBO(255,0,255, 1),
  500:Color.fromRGBO(35,41,65, 1), //Floating action button
  600:Color.fromRGBO(128,128,0, 1),
  700:Color.fromRGBO(128,128,128, 1),
  800:Color.fromRGBO(128,0,128, 1),
  900:Color.fromRGBO(0,128,128, 1),
};