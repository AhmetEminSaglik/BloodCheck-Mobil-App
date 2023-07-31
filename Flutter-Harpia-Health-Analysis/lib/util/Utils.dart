import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

import '../model/EnumUserProp.dart';
import 'SharedPref.dart';

class SharedPrefUtils {
  static int getRoleId() {
    return SharedPref.sp.getInt(EnumUserProp.ROLE_ID.name);
  }
}

class CustomListViewItemColor {
  static Color getBackgroundColor(
      {required int colorindex, required int index}) {
    if (colorindex == 1) {
      return index % 2 == 0 ? Colors.cyanAccent : Colors.tealAccent;
    } else if (colorindex == 2) {
      // return index % 2 == 0 ? ProductColor.white : Colors.orangeAccent;
      return index % 2 == 0 ? ProductColor.white : ProductColor.dartWhite;
    } else if (colorindex == 3) {
      return index % 2 == 0 ? Colors.white54 : Colors.white70;
    } else if (colorindex == 4) {
      return index % 2 == 0 ? Colors.white : Colors.blueGrey;
    }
    return Colors.black;
  }
}



