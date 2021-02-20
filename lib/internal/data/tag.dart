import 'dart:convert';

import 'data_contract.dart';

Tag clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Tag.fromMap(jsonData);
}

String clientToJson(Tag data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Tag{
  int id;
  String name;

  Tag({
    this.id,
    this.name
  });

  factory Tag.fromMap(Map<String, dynamic> json) => new Tag(
    id: json[DataContract.TAGS_COLUMN_NAME_ID],
    name: json[DataContract.TAGS_COLUMN_NAME_NAME]
  );

  Map<String, dynamic> toMap() => {
    DataContract.TAGS_COLUMN_NAME_ID: id,
    DataContract.TAGS_COLUMN_NAME_NAME: name,
  };

  static Tag createTag(int id, String name) {
    var tag = new Tag();
    tag.id = id;
    tag.name = name;
    return tag;
  }

  Tag deepClone(){
    return Tag.createTag(id, name);
  }

  static List<Tag> tempTags() {

    var set = new List<Tag>();

    Tag tag1 = Tag.createTag(0, "ADVICE");
    Tag tag2 = Tag.createTag(1, "WISDOM");
    Tag tag3 = Tag.createTag(2, "INSPIRATION");
    Tag tag4 = Tag.createTag(3, "PHILOSOPHY");
    Tag tag5 = Tag.createTag(4, "POETRY");
    Tag tag6 = Tag.createTag(5, "DREAMS");

    set.add(tag1);
    set.add(tag2);
    set.add(tag3);
    set.add(tag4);
    set.add(tag5);
    set.add(tag6);

    return set;
  }

    static List<Tag> tempTags2() {

    var set = new List<Tag>();

    set.add(Tag.createTag(0, "ADVICE"));
    set.add(Tag.createTag(1, "WISDOM"));
    set.add(Tag.createTag(2, "INSPIRATION"));
    set.add(Tag.createTag(3, "PHILOSOPHY"));
    set.add(Tag.createTag(4, "POETRY"));
    set.add(Tag.createTag(5, "DREAMS"));
    set.add(Tag.createTag(6, "DREAMS"));
    set.add(Tag.createTag(7, "DREAMS"));
    set.add(Tag.createTag(8, "DREAMS"));
    set.add(Tag.createTag(9, "DREAMS"));
    set.add(Tag.createTag(10, "DREAMS"));
    set.add(Tag.createTag(11, "DREAMS"));
    set.add(Tag.createTag(12, "DREAMS"));
    set.add(Tag.createTag(13, "DREAMS"));
    set.add(Tag.createTag(14, "DREAMS"));
    set.add(Tag.createTag(15, "DREAMS"));

    return set;
  }

}
