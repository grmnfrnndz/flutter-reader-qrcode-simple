

import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {

  int _selectedMenuOption = 0;

  int get selectedMenuOption => _selectedMenuOption;

  set selectedMenuOption(int selectedMenuOption) {
    _selectedMenuOption = selectedMenuOption;
    notifyListeners();
  }

}