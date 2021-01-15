
import 'package:fhiquo/edit_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'internal/data/quote.dart';

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


class NListView extends StatelessWidget {
  List<Quote> temporaryList = Quote.tempQuotes2();

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
                  MaterialPageRoute(builder: (context) => NEditView()),
                );
              },
            )
          ],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemBuilder: (context, position) {
                return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    temporaryList[position].body,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  )
                                )
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 18,
                                  color: Colors.black
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text(temporaryList[position].author,),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.black
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(temporaryList[position].origin,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  );
              },
              itemCount: temporaryList.length,
            ),
          ),
        ),
      ),
      //home: CameraScreen(),
    );
  }
}