import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';

class CustomText extends StatelessWidget {
  final String text1;
  final String text2;

  const CustomText({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ResponsiveDesign.getScreenHeight() / 18,
        decoration: BoxDecoration(
          color: ProductColor.white,
          border: Border.all(color: Colors.red, width: 2.5),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: ResponsiveDesign.getScreenWidth() / 15),
          child: Row(
            children: [
              _DesignedText(
                  text: text1, maxWidth: ResponsiveDesign.getScreenWidth() / 3),
              _DesignedText(
                text: ":",
                maxWidth: ResponsiveDesign.getScreenWidth() / 25,
              ),
              _DesignedText(
                text: text2,
                maxWidth: ResponsiveDesign.getScreenWidth() / 2.5,
              ),
            ],
          ),
        ));
  }
}

class _DesignedText extends StatelessWidget {
  final String text;
  final double maxWidth;

  const _DesignedText({required this.text, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      child: Text(
        text,
        style: TextStyle(
            fontSize: ResponsiveDesign.getScreenHeight() / 40,
            color: ProductColor.bodyBackgroundDark),
      ),
    );
  }
}
