import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DataProvider extends ChangeNotifier {
  List<String> _items = [];

  List<String> get items => _items;

  DataProvider() {
    _loadItemsFromPrefs();
  }

  void addItem(String item) {
    _items.add(item);
    _saveItemsToPrefs();
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _saveItemsToPrefs();
    notifyListeners();
  }

  void _loadItemsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _items = prefs.getStringList('items') ?? [];
    notifyListeners();
  }

  void _saveItemsToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('items', _items);
  }
}