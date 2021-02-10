import 'package:fhiquo/internal/data/data_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fhiquo/list_view.dart';
import 'package:home_widget/home_widget.dart';

import 'package:native_ads/native_ads.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'internal/data/quote.dart';
import 'internal/state/list_model.dart';


void callbackDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    debugPrint("Native called background task: $taskName");

    final now = DateTime.now();

    Quote quote = await DataHelper.internal().getRandomQuote();
    return Future.wait<bool>([

      HomeWidget.saveWidgetData('body', "FROM APP"),
      HomeWidget.saveWidgetData('author', "FROM APP"),
      HomeWidget.saveWidgetData('updated', '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} ${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}'),
      HomeWidget.updateWidget( name: 'QuoteAppWidget', iOSName: 'HomeWidgetExample'),
    ]).then((value) {
      return !value.contains(false);
    });
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(callbackDispatcher, isInDebugMode: false).then((value) =>_startBackgroundUpdate());
  NativeAds.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ListModel(),
      child: MaterialApp(
        home: NListView(),
      )
    )
  );
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

void _startBackgroundUpdate() {
  Workmanager.registerPeriodicTask('3', 'widgetBackgroundUpdate', frequency: Duration(minutes: 15), tag: "fhiquo");
}
