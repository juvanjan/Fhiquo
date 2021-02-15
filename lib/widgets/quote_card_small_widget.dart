import 'package:fhiquo/gallery_view.dart';
import 'package:fhiquo/internal/data/quote.dart';
import 'package:fhiquo/internal/state/list_model.dart';
import 'package:flutter/material.dart';
import 'package:native_ads/native_ad_param.dart';
import 'package:native_ads/native_ad_view.dart';
import 'package:provider/provider.dart';


import '../edit_view.dart';
import '../main.dart';

class QuoteCardSmall extends StatefulWidget {
  final Quote quote;
  QuoteCardSmall({this.quote});

  @override
  _QuoteCardSmallState createState() => _QuoteCardSmallState();
}

class _QuoteCardSmallState extends State<QuoteCardSmall> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ListModel>(
      builder: (context, model, child) {
        return Card(
          color: isSelected(model) ? MaterialColor(0xFF232941, todoColor01) : MaterialColor(0xFFe6e9f6, todoColor01),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
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
            :
            InkWell(
            onTap: () {
              if (model.isNormalState())
                Navigator.push(context, MaterialPageRoute(builder: (context) => NGalleryView(initialQuote: widget.quote,)));
              else
                model.toggleSelectedId(widget.quote.id);
            },
            onLongPress: () {
              model.toggleSelectedId(widget.quote.id);
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
                            style: TextStyle(
                              color: isSelected(model) ? Colors.white : Colors.black
                            ),
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
                            color: isSelected(model) ? Colors.white : Colors.black
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              widget.quote.author,
                              style: TextStyle(
                                color: isSelected(model) ? Colors.white : Colors.black
                              ),
                            ),
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
                          color: isSelected(model) ? Colors.white : Colors.black
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(
                              widget.quote.origin,
                              style: TextStyle(
                                color: isSelected(model) ? Colors.white : Colors.black
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      },
    );
  }

  bool isSelected(ListModel model) {
    return !widget.quote.isAd && model.selectedIds.contains(widget.quote.id);
  }

}
