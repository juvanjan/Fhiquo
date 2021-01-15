
class Tag{
  int id;
  String name;

  Tag() {
      id = -1;
      name = "invisible_tag";
  }

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

}
