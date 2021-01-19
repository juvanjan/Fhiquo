import 'package:fhiquo/internal/data/quote.dart';
import 'package:flutter/material.dart';

import '../edit_view.dart';
import '../main.dart';

class QuoteCardSmall extends StatelessWidget {
  final Quote quote;

  QuoteCardSmall({this.quote});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MaterialColor(0xFFe6e9f6, todoColor01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NEditView(mode: Mode.Edit, quote: quote,)));
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
                        quote.body,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      )
                    )
                  ),
                ],
              ),
              Visibility(
                visible: quote.author.isNotEmpty,
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
                        child: Text(quote.author),
                      ),
                    ],
                  ),
                )
              ),
              Visibility(
                visible: quote.origin.isNotEmpty,
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.black
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(quote.origin),
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
