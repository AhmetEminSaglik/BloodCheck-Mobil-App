import 'package:flutter/material.dart';

class ProductColor {
/*  static bool _darkThemeActivated = false;

  static void updateTheme({required bool darkThemeActivated}) {
    _darkThemeActivated = darkThemeActivated;
  }

  static get backgroundColor =>
      {_darkThemeActivated ? _productWhite : _productBlack};

  static get textColor =>
      {_darkThemeActivated ? _productWhite : _productBlack};*/

  static const _darkBlue = Color(0xFF18344a);
  static const _black = Color(0xFF29293A);
  static const _white = Colors.white;
  static const _green = Colors.green;
  static const _dartWhite = Colors.white70;

  static get darkBlue => _darkBlue;

  static get black => _black;

  static get white => _white;

  static get dartWhite => _dartWhite;

  static get green => _green;
}
