import 'package:fhiquo/internal/data/data_helper.dart';
import 'package:fhiquo/internal/data/quote.dart';
import 'package:fhiquo/widgets/tag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:native_ads/native_ad_param.dart';
import 'package:native_ads/native_ad_view.dart';


class QuoteCardLarge extends StatefulWidget {
  final Quote quote;
  QuoteCardLarge({this.quote});

  @override
  _QuoteCardLargeState createState() => _QuoteCardLargeState();
}

class _QuoteCardLargeState extends State<QuoteCardLarge> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(34.0, 44.0, 44.0, 44.0),
      child: widget.quote.isAd
            ?
            SizedBox(
              width: double.infinity,
              height: 120,
              child: NativeAdView(
                onParentViewCreated: (_) {
                },
                androidParam: AndroidParam()
                  ..placementId = "ca-app-pub-3940256099942544/2247696110" // test
                  ..packageName = "fhiquo.poc"
                  ..layoutName = "ad_unified_list"
                  ..attributionText = "AD",
                /*
                iosParam: IOSParam()
                  ..placementId = "ca-app-pub-3940256099942544/3986624511" // test
                  ..bundleId = "{{YOUR_IOS_APP_BUNDLE_ID}}"
                  ..layoutName = "{{YOUR_CREATED_LAYOUT_FILE_NAME}}"
                  ..attributionText = "SPONSORED",
                onAdImpression: () => print("onAdImpression!!!"),
                               */
                onAdClicked: () => print("onAdClicked!!!"),
                onAdFailedToLoad: (Map<String, dynamic> error) => print("onAdFailedToLoad!!! $error"),
              ),
            )
          :Container(
          child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Icon(Icons.format_quote),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8,2,2,2),
                    child: Text( widget.quote.body,
                      style: TextStyle(
                        fontSize: 16
                      ),
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
                    child: Icon(Icons.person),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8,2,2,2),
                      child: Text(widget.quote.author,
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
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
                    child: Icon(Icons.star),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8,2,2,2),
                      child: Text(widget.quote.origin,
                        style: TextStyle(
                          fontSize: 16
                        ),
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
                    child: Icon(Icons.sticky_note_2_outlined),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8,2,2,2),
                      child: Text(widget.quote.comment,
                        style: TextStyle(
                          fontSize: 16
                        ),
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
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(Icons.bookmark),
                  ),
                  Flexible(
                    child: Container(
                      child: FutureBuilder<List>(
                              future: DataHelper().getFilteredTags("", widget.quote.tags, TagType.Normal),
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
                            )
                    ),
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
                    child: Icon(Icons.info),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8,2,2,2),
                      child: Text(getInfoString(),
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                    )
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  getInfoString() {
    DateFormat formatter = DateFormat('dd MMM yyyy');
    return "Created: " +  formatter.format(widget.quote.dateCreated) + "\n" +
    "Edited: " + formatter.format(widget.quote.lastEdited);
  }
}
