import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:fhiquo/internal/data/data_helper.dart';

import 'main.dart';

class NSettingsView extends StatelessWidget {
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
          title: Text('Settings'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(Icons.sd_card),
                      ),
                      Flexible(
                        child: Text(
                          'DATABASE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  importDatabase();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(56, 0, 16, 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Import',
                            style: TextStyle(
                              fontSize: 20
                            )
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Add quotes to your collection from a file',
                            style: TextStyle(
                              fontSize: 12
                            )
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              ),

              InkWell(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(56, 0, 16, 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Export',
                            style: TextStyle(
                              fontSize: 20
                            )
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Save the content of your database into a file',
                            style: TextStyle(
                              fontSize: 12
                            )
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              ),

              Container(
                height: 3,
                color: MaterialColor(0xFF232941, todoColor01),
              ),
            ],
          ),
        ),
      ),
    );
  }

  importDatabase() async {
    final params = OpenFileDialogParams(
      dialogType: OpenFileDialogType.document,
      allowedUtiTypes: ["db"]
    );
    final filePath = await FlutterFileDialog.pickFile(params: params);
    await DataHelper().importDatabase(filePath);
  }

}
