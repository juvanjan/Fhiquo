import 'package:fhiquo/internal/data/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagWidget extends StatefulWidget {
  final int id;
  final String name;
  TagWidget(this.id, this.name);

  @override
  _TagWidgetState createState() => _TagWidgetState();

  static List<TagWidget> tempTagWidgets() {
    List<Tag> tags = Tag.tempTags2();

    var set = new List<TagWidget>();
    for (int i = 0; i < tags.length; i++) {
      set.add(new TagWidget(tags[i].id, tags[i].name));
    }

    return set;

  }
}

class _TagWidgetState extends State<TagWidget> {

  bool set = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: set ? Color(0xFF232941):  Color(0xFFe6e9f6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            set = ! set;
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          child: Text(
            widget.name,
            style: TextStyle(
              fontSize: 15,
              color: set ? Colors.white : Colors.black
            ),
          ),
        ),
      ),
    );
  }
}