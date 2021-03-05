import 'package:fhiquo/internal/data/data_helper.dart';
import 'package:fhiquo/internal/data/quote.dart';
import 'package:fhiquo/widgets/tag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'camera_view.dart';
import 'main.dart';


enum Mode {
  Add,
  Edit
}

class NEditView extends StatefulWidget {
  final Mode mode;
  final Quote quote;
  NEditView({this.mode, this.quote});

  @override
  _NEditViewState createState() => _NEditViewState();
}

class _NEditViewState extends State<NEditView> {
  List<Widget> temporaryList = TagWidget.tempTagWidgets();

  TextEditingController  bodyController;
  TextEditingController  authorController;
  TextEditingController  originController;
  TextEditingController  commentController;

  @override
  void initState() {
    super.initState();
    switch(widget.mode) {

      case Mode.Edit:
        bodyController = new TextEditingController(text: widget.quote.body);
        authorController = new TextEditingController(text: widget.quote.author);
        originController = new TextEditingController(text: widget.quote.origin);
        commentController = new TextEditingController(text: widget.quote.comment);
        break;
      case Mode.Add:
      default:
        bodyController = new TextEditingController(text: '');
        authorController = new TextEditingController(text: '');
        originController = new TextEditingController(text: '');
        commentController = new TextEditingController(text: '');
        break;
    }

  }

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
                saveNewQuote(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18.0, 28.0, 28.0, 28.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 8, top: 8),
                      child: Icon(Icons.format_quote),
                    ),
                    Flexible(
                      child: Container(
                        child: Stack(
                          children: [
                            TextField(
                              controller: bodyController,
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
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 8),
                        child: Icon(Icons.person),
                      ),
                      Flexible(
                        child: Container(
                          child: Stack(
                            children: [
                              TextField(
                                controller: authorController,
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
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 8),
                        child: Icon(Icons.star),
                      ),
                      Flexible(
                        child: Container(
                          child: TextField(
                            controller: originController,
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
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 8),
                        child: Icon(Icons.sticky_note_2_outlined),
                      ),
                      Flexible(
                        child: Container(
                          child: TextField(
                            controller: commentController,
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


                Container(
                  margin: EdgeInsets.only(top: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 8, top: 8),
                        child: Icon(Icons.bookmark),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "search tag...",
                                  hintMaxLines: 5,
                                  hintStyle: TextStyle(color: Color(0xFFb9c0e3)),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  fillColor: Color(0xFFd2d7ed),
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(10.0),
                                  isDense: true,
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                minLines: 1,
                              ),
                            ),
                            Container(
                              color: Color(0xFFe6e9f6),
                              height: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),


                Container(
                  padding: EdgeInsets.only(left: 32, top: 12),
                  child: Wrap(
                    spacing: 3.0,
                    runSpacing: 2.0,
                    alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    children: temporaryList,
                  ),
                ),


              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {

          },
        ),
      ),
    );
  }

  String titleText() {
    return widget.mode == Mode.Add ? "Add quote" : "Edit quote";
  }

  saveNewQuote(BuildContext context) async {
    await DataHelper().insertQuote(Quote.createQuote(0, authorController.text, originController.text, bodyController.text, commentController.text, new List<int>()));
    Navigator.pop(context, true);
  }

}