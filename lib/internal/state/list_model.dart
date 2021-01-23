import 'dart:collection';

import 'package:flutter/material.dart';
import '../../list_view.dart';

class ListModel extends ChangeNotifier {
  int listSize;
  NListViewState state = NListViewState.Normal;
  final List<int> _selectedIds = [];
  UnmodifiableListView<int> get selectedIds => UnmodifiableListView(_selectedIds);

  void setListSize(int size) {
    listSize = size;
  }

  String getListSize() {
    return listSize == null ? '*' : listSize.toString();
  }

  void setState(NListViewState state) {
    this.state = state;
    notifyListeners();
  }

  void toggleSelectedId(int value) {
    if (isNormalState())
      setState(NListViewState.Action);

    if (_selectedIds.contains(value)) {
      _selectedIds.remove(value);
    } else {
      _selectedIds.add(value);
    }
    notifyListeners();
  }

  void cancelActionMode() {
    if (!isNormalState()) {
      _selectedIds.clear();
      setState(NListViewState.Normal);
    }
  }

  bool isNormalState() {
    return state == NListViewState.Normal;
  }


}