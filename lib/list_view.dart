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
import 'internal/state/list_model.dart';
import 'main.dart';

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
  String query;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
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
        appBar: searchBar.build(context),
        drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              physics: const AlwaysScrollableScrollPhysics (),
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(''),
                  decoration: BoxDecoration(
                    color: MaterialColor(0xFF232941, todoColor01),
                  ),
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
                          child: Icon(Icons.settings),
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
              )
            ],
          ),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            child: FutureBuilder<List>(
              future: DataHelper.internal().getFilteredQuotes(query),
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
            )
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            buttonPressed();
          },
        ),
      ),
    );
  }

  _NListViewState() {
    controller.addListener(textChanged);
    searchBar = new SearchBar(
      inBar: true,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onSubmitted: onSubmitted,
      controller: controller,
      onCleared: () {
        print("cleared");
      },
      onClosed: () {
        print("closed");
      }
    );
  }



  void textChanged() {
    setState(() {
      query = controller.text;
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
    await _sendAndUpdate();
  }



  Future<void> _sendData() async {
    try {
      return Future.wait([
        HomeWidget.saveWidgetData<String>('title', "_titleController.text"),
        HomeWidget.saveWidgetData<String>('message'," _messageController.text"),
      ]);
    } on PlatformException catch (exception) {
      debugPrint('Error Sending Data. $exception');
    }
  }

  Future<void> _updateWidget() async {
    try {
      return HomeWidget.updateWidget(
          name: 'HomeWidgetExampleProvider', iOSName: 'HomeWidgetExample');
    } on PlatformException catch (exception) {
      debugPrint('Error Updating Widget. $exception');
    }
  }


  Future<void> _sendAndUpdate() async {
    await _sendData();
    await _updateWidget();
  }

  void _startBackgroundUpdate() {
    Workmanager.registerPeriodicTask('1', 'widgetBackgroundUpdate',
        frequency: Duration(minutes: 15));
  }

  void _stopBackgroundUpdate() {
    Workmanager.cancelByUniqueName('1');
  }













}