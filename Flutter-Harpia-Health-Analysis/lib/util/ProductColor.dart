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

  static const _darkBlue = Color(0xff18344a);
  static const _black = Color(0xFF29293A);
  static const _white = Colors.white;
  static const _green = Colors.green;
  static const _darkWhite = Colors.white70;
  static const _redAccent = Colors.redAccent;
  static const _bodyBackground = Colors.cyan;
  static const _bodyBackgroundLight = Color(0xffb4ead8);
  static const _alertBoxBackgroundColor = _bodyBackground;
  static const _appBarBackgroundColor = _redAccent;
  static const _fLSpotColorBloodSugar = Color(0xFFF3003B);
  static const _fLSpotColorBloodPressure = Color(0xFF900DB4);
  static const _fLSpotColorMagnesium = Color(0xFF2630DE);
  static const _fLSpotColorCalcium = Color(0xFF12EFCE);

  static get darkBlue => _darkBlue;

  static get black => _black;

  static get white => _white;

  static get darkWhite => _darkWhite;

  static get green => _green;

  static get redAccent => _redAccent;

  static get appBarBackgroundColor => _appBarBackgroundColor;

  static get bodyBackground => _bodyBackground;

  static get bodyBackgroundLight => _bodyBackgroundLight;

  static get alertBoxBackgroundColor => _alertBoxBackgroundColor;

  static get fLSpotColorBloodSugar => _fLSpotColorBloodSugar;

  static get fLSpotColorBloodPressure => _fLSpotColorBloodPressure;

  static get fLSpotColorCalcium => _fLSpotColorCalcium;

  static get fLSpotColorMagnesium => _fLSpotColorMagnesium;
}
