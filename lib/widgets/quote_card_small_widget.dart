import 'package:flutter/material.dart';

import '../main.dart';

class QuoteCardSmall extends StatelessWidget {
  final String body;
  final String author;
  final String origin;
  QuoteCardSmall({this.body, this.author, this.origin});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MaterialColor(0xFFe6e9f6, todoColor01),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
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
                      body,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )
                  )
                ),
              ],
            ),
            Visibility(
              visible: author.isNotEmpty,
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
                      child: Text(author),
                    ),
                  ],
                ),
              )
            ),
            Visibility(
              visible: origin.isNotEmpty,
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.black
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Text(origin),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
