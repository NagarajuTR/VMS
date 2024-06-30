import 'package:flutter/material.dart';

class BottomNavIndex with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex({required int selectedIndex}) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }
}
