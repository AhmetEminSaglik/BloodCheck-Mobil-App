import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

class ListViewUtilItemColor {
  static Color getBackgroundColor({required int index}) {
    return index % 2 == 0 ? ProductColor.white : ProductColor.darkWhite;
  }
}
