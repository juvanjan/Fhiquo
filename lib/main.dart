
import 'package:fhiquo/edit_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MaterialApp(
    home: ListView(),
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

class ListView extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fhiquo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Rubik',
        primarySwatch: MaterialColor(0xFF232941, todoColor01),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: MaterialColor(0xFFd2d7ed, todoColor01),
        appBar: AppBar(
          title: Text('Fhiquo'),
            leading: Icon(
              Icons.menu,
            ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditView()),
                );
              },
            )
          ],
        ),
        body: Center(
          child: Text('List view is not yet implemented.'),
        ),
      ),
      //home: CameraScreen(),
    );
  }
}