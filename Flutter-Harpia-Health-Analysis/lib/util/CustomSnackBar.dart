import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

class CustomSnackBar {
  // static ScaffoldMessenger getScaffoldMessenger(BuildContext context, String text) {
  //   return ScaffoldMessenger.of(context).showSnackBar(getSnackBar(text));
  //
  // }
  // static void showScaffoldMessage(
  //     {required BuildContext context, required String msg}) {
  //   ScaffoldMessenger.of(context)
  //       .showSnackBar(getSnackBar(msg));
  // }

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
