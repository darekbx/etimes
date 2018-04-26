import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class EntryCount {

  String _timesCountKey = "times_count_key";

  Future<int> addEntry() async {
    int actualCount = await loadState();
    actualCount = actualCount + 1;
    _saveState(actualCount);
    return actualCount;
  }

  Future<int> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    int actualCount = prefs.getInt(_timesCountKey);
    if (actualCount == null) {
      actualCount = 0;
    }
    return actualCount;
  }

  _saveState(int actualCount) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_timesCountKey, actualCount);
  }
}