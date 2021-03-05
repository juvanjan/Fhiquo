import 'package:fhiquo/gallery_view.dart';
import 'package:fhiquo/internal/data/data_helper.dart';
import 'package:fhiquo/internal/data/quote.dart';
import 'package:fhiquo/internal/helpers/common_helper.dart';
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
                          child: RichText(
                            text: TextSpan(
                              children: getTextSpan(widget.quote.body, model),
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
                            child: RichText(
                              text: TextSpan(
                                children: getTextSpan(widget.quote.author, model),
                              ),
                            )
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
                          child: RichText(
                            text: TextSpan(
                              children: getTextSpan(widget.quote.origin, model),
                            ),
                          )
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

  List<TextSpan> getTextSpan(String original, ListModel model) {
    String searchPattern = DataHelper().filterParameters.searchPattern;
    List<int> test  = CommonHelper.findOccurrencesOfSubstring(original, searchPattern);
    //List<int> test  = CommonHelper.findOccurrencesOfSubstring(original, DataHelper().filterParameters.searchPattern);
    List<TextSpan> spans = new List();

    if (test.length != 0) {
      spans.add(TextSpan(text: original.substring(0, test[0]), style: TextStyle(color: isSelected(model) ? Colors.white : Colors.black)));

      for(int i = 0; i < test.length; i++) {
        int index = test[i];
        int endIndex = test[i] + searchPattern.length;
        spans.add(TextSpan(text: original.substring(test[i], endIndex), style: TextStyle(color: isSelected(model) ? Colors.white : Colors.black, backgroundColor: isSelected(model) ?  MaterialColor(0xFFd2d7ed, todoColor01) :  MaterialColor(0xFFd2d7ed, todoColor01) )));
        if (endIndex != original.length - 1) {
          if (i + 1 != test.length) {
            spans.add(TextSpan(text: original.substring(endIndex, test[i + 1]), style: TextStyle(color: isSelected(model) ? Colors.white : Colors.black)));
          } else {
            spans.add(TextSpan(text: original.substring(endIndex, original.length), style:TextStyle(color: isSelected(model) ? Colors.white : Colors.black)));
          }
        }

      }
    } else {
      spans.add(TextSpan(text: original.substring(0, original.length), style: TextStyle(color: isSelected(model) ? Colors.white : Colors.black)));
    }

    return spans;
  }

  bool isSelected(ListModel model) {
    return !widget.quote.isAd && model.selectedIds.contains(widget.quote.id);
  }

}
