import 'package:flutter/cupertino.dart';

class ResponsiveDesign {
  MediaQueryData mediaQueryData;
  static double _screenWidth = 0;
  static double _screenHeight = 0;

  ResponsiveDesign({required this.mediaQueryData}) {
    _screenWidth = mediaQueryData.size.width;
    _screenHeight = mediaQueryData.size.height;
  }

  static double getScreenWidth() {
    if (!_IsDataNull(_screenWidth)) {
      if(_screenHeight>_screenWidth)
      return _screenWidth;
      return _screenHeight;
    }
    return -1;
  }

  static double getScreenHeight() {
    if (!_IsDataNull(_screenHeight)) {
      if(_screenHeight>_screenWidth)
        return _screenHeight;
        return _screenWidth;
    }
    return -1;

  }

  static bool _IsDataNull(double data) {
    if (data == 0) {
      print("--> $data IS NULL");
      return true;
    }
    return false;
  }
}
