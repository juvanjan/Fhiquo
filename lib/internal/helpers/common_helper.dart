class CommonHelper {

  static bool IsNullOrEmpty(String string) {
    return string == null || string.isEmpty;
  }

  static bool searchCompare(String originalText, String searchText) {
    if (originalText == null || searchText == null)
      return true;

    return parseStringForSearch(originalText).contains(parseStringForSearch(searchText));
  }

  static String parseStringForSearch(String text) {
      return text.toLowerCase().replaceAll("\\p{Punct}", "");
  }

  static List<int> findOccurrencesOfSubstring(String textString, String word) {
    List<int> indexes = new List();

    if (IsNullOrEmpty(textString) || IsNullOrEmpty(word))
      return indexes;

    String lowerCaseTextString = textString.toLowerCase();
    String lowerCaseWord = word.toLowerCase();
    int wordLength = 0;

    int index = 0;
    while(index != -1){
        index = lowerCaseTextString.indexOf(lowerCaseWord, index + wordLength);  // Slight improvement
        if (index != -1) {
            indexes.add(index);
        }
        wordLength = word.length;
    }
    return indexes;
  }

}