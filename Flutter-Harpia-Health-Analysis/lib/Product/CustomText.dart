import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

class CustomText extends StatelessWidget {
  final String text1;
  final String text2;
  Color textColor = ProductColor.white;
  Color backgroundColor = ProductColor.bodyBackgroundDark;
  // Color textColor = ProductColor.bodyBackgroundDark;
  // Color backgroundColor = ProductColor.white;
  double fontSize = ResponsiveDesign.getScreenHeight() / 40;

  CustomText(
      {super.key,
      required this.text1,
      required this.text2,
      textColor,
      fontSize,
      backgroundColor}) {
    // textColor != null ? this.textColor = textColor : null;
    fontSize != null ? this.fontSize = fontSize : null;
    backgroundColor != null ? this.backgroundColor = backgroundColor : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ResponsiveDesign.getScreenHeight() / 18,
        decoration: BoxDecoration(
            color: backgroundColor,
            // border: Border.all(color: Colors.red, width: 2.5),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding:
              EdgeInsets.only(left: ResponsiveDesign.getScreenWidth() / 15),
          child: Row(
            children: [
              _DesignedText(
                text: text1,
                maxWidth: ResponsiveDesign.getScreenWidth() / 3,
                fontSize: fontSize,
                textColor: textColor,
              ),
              _DesignedText(
                text: ":",
                maxWidth: ResponsiveDesign.getScreenWidth() / 25,
                fontSize: fontSize,
                textColor: textColor,
              ),
              _DesignedText(
                text: text2,
                maxWidth: ResponsiveDesign.getScreenWidth() / 2.5,
                fontSize: fontSize,
                textColor: textColor,
              ),
            ],
          ),
        ));
  }
}

class _DesignedText extends StatelessWidget {
  final String text;
  final double maxWidth;
  final double fontSize;
  final Color textColor;

  const _DesignedText(
      {required this.text,
      required this.maxWidth,
      required this.fontSize,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }
}
