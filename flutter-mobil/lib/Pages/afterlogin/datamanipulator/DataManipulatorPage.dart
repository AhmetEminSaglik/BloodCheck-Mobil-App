import 'package:bloodcheck/Product/CustomButton.dart';
import 'package:bloodcheck/httprequest/HttpRequestDataManipulator.dart';
import 'package:bloodcheck/httprequest/ResponseEntity.dart';
import 'package:bloodcheck/util/CustomNotification.dart';
import 'package:flutter/material.dart';

class DataManipulatorPage extends StatefulWidget {
  const DataManipulatorPage({super.key});

  @override
  State<DataManipulatorPage> createState() => _DataManipulatorState();
}

class _DataManipulatorState extends State<DataManipulatorPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ListView(
        children: [
          Container(height: 30),
          _getBtnResetAllData(),
        ],
      ),
    );
  }

  _getBtnResetAllData() {
    return new CustomButton(
        action: () async {
          ResponseEntity response = await HttpRequestDataManipulator.resetAllData();
          CustomNotificationUtil.showNotification(
              "Reset All Data : ${response.success}", response.message);
        },
        text: "Reset All Data");
  }
}
