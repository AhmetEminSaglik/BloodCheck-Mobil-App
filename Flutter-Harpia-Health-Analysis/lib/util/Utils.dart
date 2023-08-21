import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

import '../model/EnumUserProp.dart';
import 'SharedPref.dart';

class SharedPrefUtils {
  static int getRoleId() {
    return SharedPref.sp.getInt(EnumUserProp.ROLE_ID.name);
  }

  static int getUserId() {
    return SharedPref.sp.getInt(EnumUserProp.ID.name);
  }
}

class CustomListViewItemColor {
  static Color getBackgroundColor({required int index}) {
    return index % 2 == 0 ? Colors.cyanAccent : Colors.tealAccent;
  }
}
