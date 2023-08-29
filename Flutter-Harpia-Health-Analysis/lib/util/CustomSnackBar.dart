import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

class CustomSnackBar {
  static SnackBar getSnackBar(String msg) {
    return SnackBar(
      content: Text(
        msg,
        style: TextStyle(
            color: ProductColor.white,
            fontSize: ResponsiveDesign.getScreenWidth() / 27),
      ),
      closeIconColor: ProductColor.white,
      showCloseIcon: true,
      backgroundColor: ProductColor.black,
      duration: Duration(seconds: 5),
    );
  }
}
