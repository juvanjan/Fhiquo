import 'package:fhiquo/settings_view.dart';
import 'package:fhiquo/widgets/quote_card_large_widget.dart';
import 'package:fhiquo/widgets/quote_card_small_widget.dart';
import 'package:fhiquo/widgets/tag_widget.dart';
import 'package:flutter/material.dart';

import 'edit_view.dart';
import 'internal/data/data_helper.dart';
import 'internal/data/quote.dart';
import 'main.dart';

class NGalleryView extends StatefulWidget {
  final Quote initialQuote;

  const NGalleryView({Key key, this.initialQuote}) : super(key: key);

  @override
  _NGalleryViewState createState() => _NGalleryViewState();
}

class _NGalleryViewState extends State<NGalleryView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Quote current;
  PageController controller;

  @override
  void initState() {
    super.initState();
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
        appBar: AppBar(
          leading: IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          title: Text(''),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NEditView(mode: Mode.Edit, quote: current,)));
              },
            )
          ],
        ),
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
            padding: EdgeInsets.all(0),
            child: FutureBuilder<List>(
              future: DataHelper().getFilteredQuotes(context),
              initialData: List<Quote>(),
              builder: (context, snapshot) {
              return snapshot.hasData ?
                PageView.builder(
                  controller:  PageController(initialPage: getInitialPage(snapshot.data)),
                  itemBuilder: (context, position) {
                    current = snapshot.data[position];
                    return new QuoteCardLarge(quote: snapshot.data[position]);
                  },
                  itemCount: snapshot.data.length, // Can be null
                )
                : Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ),
        ),
      ),
    );
  }

  getInitialPage(List<Quote> quotes) {
    if (widget.initialQuote != null)
      return quotes.indexOf(quotes.where((element) => element.id == widget.initialQuote.id).first);
    else
      return 0;
  }
}
