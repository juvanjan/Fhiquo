import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'camera_view.dart';
import 'main.dart';

class EditView extends StatelessWidget {
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
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Add quote'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(18.0, 28.0, 28.0, 28.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.format_quote),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Stack(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: "quote / saying / passage / speech / writing / verse / poem / lyrics / conversation / ...",
                              hintMaxLines: 5,
                              hintStyle: TextStyle(color: Color(0xFFb9c0e3)),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              fillColor: Color(0xFFe6e9f6),
                              filled: true,
                              contentPadding: const EdgeInsets.all(10.0),
                              isDense: true,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 3,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                icon: new Icon(Icons.camera_alt, color: Colors.black),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CameraView()),
                                  );
                                },
                                alignment: Alignment.topRight,
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                ],
              ),


              Container(
                margin: EdgeInsets.only(top: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.person),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: Stack(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: "author / speaker / character / ...",
                                hintStyle: TextStyle(color: Color(0xFFb9c0e3)),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                fillColor: Color(0xFFe6e9f6),
                                filled: true,
                                contentPadding: const EdgeInsets.all(10.0),
                                isDense: true,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              alignment: Alignment.topRight,
                              child: InkWell(
                                child: Icon(Icons.add, size: 24.0, color: Colors.black),
                                onTap: null,
                              ),
                            )
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.star),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "source / book / event / movie / song / ...",
                            hintMaxLines: 5,
                            hintStyle: TextStyle(color: Color(0xFFb9c0e3)),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xFFe6e9f6),
                            filled: true,
                            contentPadding: const EdgeInsets.all(10.0),
                            isDense: true,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 1,
                        ),
                      )
                    ),
                  ],
                )
              ),

              Container(
                margin: EdgeInsets.only(top: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.sticky_note_2_outlined),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "notes / comments / additional information / ...",
                            hintMaxLines: 2,
                            hintStyle: TextStyle(color: Color(0xFFb9c0e3)),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color(0xFFe6e9f6),
                            filled: true,
                            contentPadding: const EdgeInsets.all(10.0),
                            isDense: true,
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 2,
                        ),
                      )
                    ),
                  ],
                )
              ),


            ],
          ),
        ),
      ),
    );
  }
}