import 'package:fhiquo/gallery_view.dart';
import 'package:fhiquo/widgets/drawer.dart';
import 'package:fhiquo/widgets/tag_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';


import 'package:fhiquo/edit_view.dart';
import 'package:fhiquo/internal/data/data_helper.dart';
import 'package:fhiquo/settings_view.dart';
import 'package:fhiquo/widgets/quote_card_small_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'internal/data/quote.dart';
import 'internal/state/filter_model.dart';
import 'internal/state/list_model.dart';
import 'main.dart';
import 'widgets/draggable_sheet.dart';

enum NListViewState {
  Normal,
  Action
}

class NListView extends StatefulWidget {
  @override
  _NListViewState createState() => _NListViewState();
}

class _NListViewState extends State<NListView> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var searchTextController = new TextEditingController();
  var authorTextController = new TextEditingController();
  var originTextController = new TextEditingController();
  var tagsTextController = new TextEditingController();
  var _controller = SnappingSheetController();
  bool switchOn = false;

  @override
  void initState() {
    super.initState();
    authorTextController.addListener(authorTextChanged);
    originTextController.addListener(originTextChanged);
    tagsTextController.addListener(tagsTextChanged);
    HomeWidget.setAppGroupId('YOUR_GROUP_ID');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Rubik',
        primarySwatch: MaterialColor(0xFF232941, todoColor01),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Search bar theme START
        hintColor: Colors.white,
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white)
        ),
        disabledColor: MaterialColor(0xFFd2d7ed, todoColor01),
        cursorColor: Colors.white,
        // Search bar theme END
      ),
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: MaterialColor(0xFFd2d7ed, todoColor01),
        resizeToAvoidBottomInset: false,
        appBar: searchBar.build(context),
        drawer: AppDrawer(),
        body:  SnappingSheet(

          grabbingHeight: 40,
          snapPositions: [
            SnapPosition(positionFactor: 0.54),
            SnapPosition(positionFactor: 1.0),
          ],
          initSnapPosition: SnapPosition(positionFactor: 1.0),
          snappingSheetController: _controller,
          sheetAbove: SnappingSheetContent(
            child: Container(
              child:
                SingleChildScrollView(

                  child: Column(
                    children: [


                      Container(
                        margin: EdgeInsets.fromLTRB(14,8,14,0),
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
                                        contentPadding: const EdgeInsets.all(8.0),
                                        isDense: true,
                                      ),
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: authorTextController,
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.fromLTRB(14,8,14,0),
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
                                    contentPadding: const EdgeInsets.all(8.0),
                                    isDense: true,
                                  ),
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  minLines: 1,
                                  controller: originTextController,
                                ),
                              )
                            ),
                          ],
                        )
                      ),


                      Container(
                        margin: EdgeInsets.fromLTRB(14,8,14,0),
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
                                        contentPadding: const EdgeInsets.all(8.0),
                                        isDense: true,
                                      ),
                                      style: TextStyle(color: Colors.black),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      minLines: 1,
                                      controller: tagsTextController,
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
                        margin: EdgeInsets.fromLTRB(30, 4, 2, 2),
                        child: SizedBox(

                          height: 120,
                          child: SingleChildScrollView(
                            child: Container(
                              child: Consumer<FilterModel>(
                                builder: (context, model, child) {
                                  return FutureBuilder<List>(
                                    future: DataHelper().getFilteredTags(DataHelper().filterParameters.tagsPattern, DataHelper().filterParameters.tags, TagType.Filter),
                                    initialData: List<Widget>(),
                                    builder: (context, snapshot) {
                                      return snapshot.hasData ?
                                        Wrap(
                                          spacing: 3.0,
                                          runSpacing: 2.0,
                                          alignment: WrapAlignment.center,
                                          direction: Axis.horizontal,
                                          children: snapshot.data,
                                        )
                                        : Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );
                                  }
                                //padding: EdgeInsets.only(left: 32, top: 12),
                              ),
                            )
                          ),
                        )
                      ),
                    ],
                  ),
                ),

            ),
            heightBehavior: SnappingSheetHeight.fixed(),
          ),

          lockOverflowDrag: true,
          grabbing: Card(
            color: MaterialColor(0xFFd2d7ed, todoColor01),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            margin: EdgeInsets.all(0),
            elevation: 7,
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Filter:"),
                Container(

                  child:
                    IconButton(

                      icon: Icon(Icons.keyboard_arrow_up),
                      color: Colors.black,
                      onPressed: () {
                        if(_controller.snapPositions.last != _controller.currentSnapPosition) {
                          _controller.snapToPosition(_controller.snapPositions.last);
                        }
                        else {
                          _controller.snapToPosition(_controller.snapPositions.first);
                        }
                      },
                       alignment: Alignment.center,
                    ),
                ),

                Switch(
                    value: switchOn,
                    onChanged: _onSwitchChanged,
                    activeColor: MaterialColor(0xFF232941, todoColor01),
                ),
              ],
            )
          ),
          ),

          sheetBelow: SnappingSheetContent(
            child: Container(

              child: Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Consumer<FilterModel>(
                    builder: (context, model, child) {
                      return FutureBuilder<List>(
                        future: DataHelper().getFilteredQuotes(context),
                        initialData: List<Quote>(),
                        builder: (context, snapshot) {
                        return snapshot.hasData ?
                         ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, position) {
                              return new QuoteCardSmall(quote: snapshot.data[position]);
                            },
                          )
                          : Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    }
                  ),
                ),
              ),
            ),
            heightBehavior: SnappingSheetHeight.fit(),
          ),
        ),
      )
    );
  }

  _NListViewState() {
    searchTextController.addListener(searchTextChanged);
    searchBar = new SearchBar(
      inBar: true,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onSubmitted: onSubmitted,
      controller: searchTextController,
      onCleared: () {
      },
      onClosed: () {
      }
    );
  }

  void searchTextChanged() {
    setState(() {
        DataHelper().filterParameters.searchPattern = searchTextController.text;
    });
  }

  void authorTextChanged() {
    if (DataHelper().filterParameters.active) {
      setState(() {
        DataHelper().filterParameters.authorPattern = authorTextController.text;
      });
    } else {
      DataHelper().filterParameters.authorPattern = authorTextController.text;
    }
  }

  void originTextChanged() {
    if (DataHelper().filterParameters.active) {
      setState(() {
        DataHelper().filterParameters.originPattern = originTextController.text;
      });
    } else {
      DataHelper().filterParameters.originPattern = originTextController.text;
    }
  }

  void tagsTextChanged() {
    setState(() {
        DataHelper().filterParameters.tagsPattern = tagsTextController.text;
    });
  }

  void _onSwitchChanged(bool value) {
    setState(() {
      switchOn = value;
      DataHelper().filterParameters.active = value;
    });
  }



  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
      .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      centerTitle: false,
      title: Consumer<ListModel>(
        builder: (context, model, child) {
          return model.isNormalState() ? Text('') : Text('${model.selectedIds.length} / ${model.getListSize()}');
        },
      ),
      leading: Consumer<ListModel>(
        builder: (context, model, child) {
          return Visibility(
            visible: model.isNormalState(),
            child: IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
          );
        },
      ),
      actions: <Widget>[
        Consumer<ListModel>(
          builder: (context, model, child) {
            return Visibility(
              visible: model.isNormalState(),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NEditView(mode: Mode.Add, quote: null,))).then((value) {
                    if (value == true) {
                      setState(() {
                        // refresh page 1 here, you may want to reload your SharedPreferences here according to your needs
                      });
                    }
                  });
                },
              ),
            );
          },
        ),
        Consumer<ListModel>(
          builder: (context, model, child) {
            return Visibility(
              visible: model.isNormalState(),
              child: searchBar.getSearchAction(context),
            );
          },
        ),
        Consumer<ListModel>(
          builder: (context, model, child) {
            return Visibility(
              visible: !model.isNormalState(),
              child: IconButton(
                icon: Icon(
                  Icons.playlist_add_check,
                  color: Colors.white,
                ),
                onPressed: () {

                },
              ),
            );
          },
        ),
        Consumer<ListModel>(
          builder: (context, model, child) {
            return Visibility(
              visible: !model.isNormalState(),
              child: IconButton(
                icon: Icon(
                  Icons.format_line_spacing,
                  color: Colors.white,
                ),
                onPressed: () {

                },
              ),
            );
          },
        ),
        Consumer<ListModel>(
          builder: (context, model, child) {
            return Visibility(
              visible: !model.isNormalState(),
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  model.cancelActionMode();
                },
              ),
            );
          },
        ),
      ],
    );
  }


  void buttonPressed() async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => NGalleryView()));
  }

}