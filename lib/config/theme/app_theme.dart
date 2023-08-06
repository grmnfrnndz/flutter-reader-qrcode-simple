import 'package:flutter/material.dart';

List<Color> colorScheme = [
  Colors.blue,
  Colors.red,
  Colors.black,
  Colors.teal,
];


class AppTheme {

  final int colorSelected;
  final bool isDarKMode;

  AppTheme({this.colorSelected = 0, this.isDarKMode = false})
  : assert(colorSelected >=0, 'colorSelected must be greater or equals to zero'),
    assert(colorSelected <= colorScheme.length - 1, 'colorSelected must be less than or equal to ${colorScheme.length - 1}');

  ThemeData getTHeme() => ThemeData(
    useMaterial3: true,
    brightness: isDarKMode ? Brightness.dark : Brightness.light,
    colorSchemeSeed: colorScheme[colorSelected]
  );

}
