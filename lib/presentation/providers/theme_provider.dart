import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {

  int _colorSelected = 1;
  bool _isDarkMode = true;


  int get colorSelected => _colorSelected;

  set colorSelected(int colorSelected) {
    _colorSelected = colorSelected;
    notifyListeners();
  }

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    notifyListeners();
  }

}