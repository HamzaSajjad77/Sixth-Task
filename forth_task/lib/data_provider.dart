import 'package:flutter/material.dart';
import 'package:forth_task/api_services.dart';

class DataProvider with ChangeNotifier {
  List<dynamic> _data = [];
  bool _isLoading = true;

  List<dynamic> get data => _data;
  bool get isLoading => _isLoading;

  DataProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      ApiService apiService = ApiService();
      _data = await apiService.fetchPosts();
    } catch (e) {
      _data = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}