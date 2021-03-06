import 'package:fhiquo/gallery_view.dart';
import 'package:fhiquo/internal/data/data_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../settings_view.dart';

enum state {
  Home,
  Gallery,
  Trash,
  Settings,
  About
}


class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
        width: 280,
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.all(0),
            physics: const AlwaysScrollableScrollPhysics (),
            children: <Widget>[

              Container(
                height: 200,
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                color: MaterialColor(0xFF232941, todoColor01),
                child: Stack(
                  children: [
                    Container(
                      color: MaterialColor(0xFF232941, todoColor01),
                      height: 200,
                      child: Image.asset('assets/thinker_wide_small.jpg',
                        fit: BoxFit.fitHeight),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.centerRight,
                      child: Image.asset('assets/phiquo_logo_name.png', width: 150),
                    ),

                  ],
                ),
              ),

              InkWell(
                onTap: () {

                },
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 14),
                        child: Icon(Icons.home,
                        color: MaterialColor(0xFF848484, todoColor01)),
                      ),
                      Flexible(
                        child: Text('Home',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                      )
                    ],
                  ),
                )
              ),

              InkWell(
                onTap: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NGalleryView()));
                },
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 14),
                        child: Icon(Icons.view_array,
                        color: MaterialColor(0xFF848484, todoColor01)),
                      ),
                      Flexible(
                        child: Text('Gallery',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                      )
                    ],
                  ),
                )
              ),

              InkWell(
                onTap: () {

                },
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 14),
                        child: Icon(Icons.delete,
                        color: MaterialColor(0xFF848484, todoColor01)),
                      ),
                      Flexible(
                        child: Text('Trash',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                    )
                  ],
                ),
              )
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              color: Colors.grey,
              height: 1,
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NSettingsView()));
              },
              child: Container(
                padding: EdgeInsets.all(14),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 14),
                      child: Icon(Icons.settings,
                        color: MaterialColor(0xFF848484, todoColor01)),
                    ),
                    Flexible(
                      child: Text('Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                    )
                  ],
                ),
              )
            ),

            InkWell(

              onTap: () {

              },
              child: Container(
                padding: EdgeInsets.all(14),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 14),
                      child: Icon(Icons.info,
                        color: MaterialColor(0xFF848484, todoColor01)),
                    ),
                    Flexible(
                      child: Text('About',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      )
    );
  }
}
