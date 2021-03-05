import 'package:fhiquo/internal/data/data_helper.dart';
import 'package:fhiquo/internal/data/tag.dart';
import 'package:fhiquo/internal/state/filter_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum TagType {
  Normal,
  Filter
}

class TagWidget extends StatefulWidget {
  final int id;
  final String name;
  final bool set;
  final TagType type;

  TagWidget(this.id, this.name, this.set, this.type);

  @override
  _TagWidgetState createState() => _TagWidgetState();

}

class _TagWidgetState extends State<TagWidget> {

  bool set;

  @override
  void initState() {
    set = widget.set;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterModel>(
        builder: (context, model, child) {
          return Card(
              color: isSet(model) ? Color(0xFF232941) : Color(0xFFe6e9f6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    toggle(model);
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: 15,
                        color: isSet(model)
                            ? Colors.white
                            : Colors.black
                    ),
                  ),
                ),
              )
          );
        }
    );
  }

  bool isSet(FilterModel model) {
    if (widget.type == TagType.Filter) {
      return model.isSelected(widget.id);
    } else {
      return set;
    }
  }

  void toggle(FilterModel model) {
    if (widget.type == TagType.Filter) {
      model.toggleSelectedId(widget.id);
    } else {
      set = !set;
    }
  }
}