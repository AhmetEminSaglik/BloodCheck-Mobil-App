import 'package:bloodcheck/Product/CustomButton.dart';
import 'package:bloodcheck/httprequest/BaseHttpRequest.dart';
import 'package:bloodcheck/httprequest/HttpRequestDataManipulator.dart';
import 'package:bloodcheck/httprequest/ResponseEntity.dart';
import 'package:bloodcheck/util/CustomNotification.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DataManipulatorPage extends StatefulWidget {
  const DataManipulatorPage({super.key});

  @override
  State<DataManipulatorPage> createState() => _DataManipulatorState();
}

class _DataManipulatorState extends State<DataManipulatorPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          Container(height: 30),
          _getBtnResetAllData(),
          _getBtnGoWebUrlAddData(),
        ],
      ),
    );
  }

  _getBtnResetAllData() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: new CustomButton(
          action: () async {
            ResponseEntity response = await HttpRequestDataManipulator.resetAllData();
            CustomNotificationUtil.showNotification(
                "Reset All Data : ${response.success}", response.message);
          },
          text: "Reset All Data"),
    );
  }
  _getBtnGoWebUrlAddData() {
    return Padding(
      padding:const EdgeInsets.all(15.0),
      child: new CustomButton(
          action: _launchURL,
          text: "Go To Web Url"),
    );
  }


  void _launchURL() async {
    const url = '${BaseHttpRequestConfig.remoteIp}3000/blood-results/add';
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
