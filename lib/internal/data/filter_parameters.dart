class FilterParameters {
  bool active;
  String searchPattern;
  String authorPattern;
  String originPattern;
  String tagsPattern;
  List<int> tags;

  FilterParameters() {
      tags = new List();
      active = false;
  }

  bool isFilterActive() {
      return active &&
          ((authorPattern != null && authorPattern.isNotEmpty) ||
          (originPattern != null && originPattern.isNotEmpty) ||
          (tags != null && tags.length != 0));
  }

  bool isSearchActive() {
    return (searchPattern != null && searchPattern.isNotEmpty);
  }
}
