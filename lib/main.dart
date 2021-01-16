
import 'package:fhiquo/edit_view.dart';
import 'package:fhiquo/internal/data/data_helper.dart';
import 'package:fhiquo/widgets/quote_card_small_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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


class NListView extends StatefulWidget {
  @override
  _NListViewState createState() => _NListViewState();
}

class _NListViewState extends State<NListView> {

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
                Navigator.push(context, MaterialPageRoute(builder: (context) => NEditView())).then((value) {
                  if (value == true) {
                    setState(() {
                      // refresh page 1 here, you may want to reload your SharedPreferences here according to your needs
                    });
                  }
                });
              },
            )
          ],
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(8),
            child: FutureBuilder<List>(
              future: DataHelper.internal().readQuotes(),
              initialData: List<Quote>(),
              builder: (context, snapshot) {
              return snapshot.hasData ?
               ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder: (context, position) {
                    return new QuoteCardSmall(body: snapshot.data[position].body, author: snapshot.data[position].author, origin: snapshot.data[position].origin);
                  },
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
}