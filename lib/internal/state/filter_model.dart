import 'package:fhiquo/internal/data/data_helper.dart';
import 'package:flutter/cupertino.dart';

class FilterModel extends ChangeNotifier {
  bool isSelected(int index) {
    return DataHelper().filterParameters.tags.contains(index);
  }

  void toggleSelectedId(int value) {
    if (DataHelper().filterParameters.tags.contains(value)) {
      DataHelper().filterParameters.tags.remove(value);
    } else {
      DataHelper().filterParameters.tags.add(value);
    }
    notifyListeners();
  }
}