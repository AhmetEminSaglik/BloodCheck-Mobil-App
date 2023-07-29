import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';

class HomePageDoctorContent extends StatefulWidget {
  const HomePageDoctorContent({Key? key}) : super(key: key);

  @override
  State<HomePageDoctorContent> createState() => _HomePageDoctorContentState();
}

class _HomePageDoctorContentState extends State<HomePageDoctorContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       ExampleListPlaceHolder(
            color: Colors.cyan, text: "Patient ListView"),
      ],
    );
  }
}

class ExampleListPlaceHolder extends StatelessWidget {
  final String text;
  final Color color;

  const ExampleListPlaceHolder({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ResponsiveDesign.getScreenWidth(),
        height: ResponsiveDesign.getScreenHeight() / 2,
        child: Container(
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 44),
                ),
              ],
            )));
  }
}
