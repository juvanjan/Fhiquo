import 'package:fhiquo/internal/data/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  final int id;
  final String name;
  TagWidget(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFe6e9f6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Text(
          name,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }


  static List<TagWidget> tempTagWidgets() {
    List<Tag> tags = Tag.tempTags();

    var set = new List<TagWidget>();
    for (int i = 0; i < tags.length; i++) {
      set.add(new TagWidget(tags[i].id, tags[i].name));
    }

    return set;

  }
}