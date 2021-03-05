class FilterParameters {
  bool active;
  String searchPattern;
  String authorPattern;
  String originPattern;
  String tagsPattern;
  Set<int> tags;

  FilterParameters() {
      tags = new Set();
      active = false;
      searchPattern = "";
      authorPattern = "";
      originPattern = "";
      tagsPattern = "";
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
