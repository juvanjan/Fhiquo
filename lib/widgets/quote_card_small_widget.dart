import 'package:fhiquo/internal/data/quote.dart';
import 'package:flutter/material.dart';
import 'package:native_ads/native_ad_param.dart';
import 'package:native_ads/native_ad_view.dart';


import '../edit_view.dart';
import '../main.dart';

class QuoteCardSmall extends StatefulWidget {
  final Quote quote;
  QuoteCardSmall({this.quote});

  @override
  _QuoteCardSmallState createState() => _QuoteCardSmallState();
}

class _QuoteCardSmallState extends State<QuoteCardSmall> {

  static const adUnitID = "ca-app-pub-3940256099942544/8135179316";

    @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: MaterialColor(0xFFe6e9f6, todoColor01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: widget.quote.isAd
        ?
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: 320,
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
          ),
        )
        :
        InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NEditView(mode: Mode.Edit, quote: widget.quote,)));
        },
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
                        widget.quote.body,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      )
                    )
                  ),
                ],
              ),
              Visibility(
                visible: widget.quote.author.isNotEmpty,
                child:Padding(
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
                        child: Text(widget.quote.author),
                      ),
                    ],
                  ),
                )
              ),
              Visibility(
                visible: widget.quote.origin.isNotEmpty,
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.black
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(widget.quote.origin),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
