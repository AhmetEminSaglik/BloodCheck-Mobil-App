import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimer.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimerAlertBoxRespond.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';
import '../model/specialitem/doctor/PatientTimerWidget.dart';

class CustomAlertDialog {
  static AlertDialog getAlertDialogUserSignUp(
      {required BuildContext context,
      required String title,
      required String subTitle,
      required String msg,
      required int roleId,
      required bool success}) {
    return AlertDialog(
      title: Text("${EnumUserRole.getRoleName(roleId)} $title",
          textAlign: TextAlign.center),
      content: SizedBox(
        height: ResponsiveDesign.getScreenHeight() / 8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(subTitle,
                  style: TextStyle(
                      fontSize: ResponsiveDesign.getScreenWidth() / 20,
                      color: success ? Colors.green : Colors.red)),
              SizedBox(height: ResponsiveDesign.getScreenHeight() / 20),
              Text(msg,
                  style: TextStyle(
                      fontSize: ResponsiveDesign.getScreenWidth() / 22))
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Ok",
              style:
                  TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 20),
            )),
      ],
    );
  }

  static AlertDialog getAlertDialogSetUpPatientTimer(
      {required PatientTimerWidget patientTimerWidget,
      required BuildContext context}) {
    return AlertDialog(
      backgroundColor: ProductColor.alertBoxBackgroundColor,
      title: Text("Setup Patient Timer",
          style: TextStyle(color: ProductColor.white)),
      content: SizedBox(
        height: ResponsiveDesign.getScreenHeight() / 6,
        child: patientTimerWidget,
      ),
      actions: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(PatientTimerAlertBoxRespond(
                      result: false, patientTimer: PatientTimer()));
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: ResponsiveDesign.getScreenWidth() / 20,
                      color: ProductColor.white),
                )),
            Spacer(),
            TextButton(
                onPressed: () {
                  print("donecek deger : ${patientTimerWidget.patientTimer}");
                  Navigator.of(context).pop(PatientTimerAlertBoxRespond(
                      result: true,
                      patientTimer: patientTimerWidget.patientTimer));
                  //Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                      fontSize: ResponsiveDesign.getScreenWidth() / 20,
                      color: ProductColor.white),
                )),
          ],
        )
      ],
    );
  }

  static AlertDialog getAlertDialogValidateProcess({
    required BuildContext context,
    required String title,
    // required String subTitle,
    required String selectedItemName,
    required String msg,
    required int roleId,
  }) {
    return AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: SizedBox(
        height: ResponsiveDesign.getScreenHeight() / 8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /*Text(subTitle,
                  style: TextStyle(
                      fontSize: ResponsiveDesign.getScreenWidth() / 20,
                      color: Colors.deepOrange)),*/
              SizedBox(height: ResponsiveDesign.getScreenHeight() / 20),
              Text(msg,
                  style: TextStyle(
                      fontSize: ResponsiveDesign.getScreenWidth() / 22)),
              Text(selectedItemName,
                  style: TextStyle(
                      fontSize: ResponsiveDesign.getScreenWidth() / 19,
                      color: Colors.redAccent)),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      fontSize: ResponsiveDesign.getScreenWidth() / 20),
                )),
            Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  //Navigator.pop(context);
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontSize: ResponsiveDesign.getScreenWidth() / 20),
                )),
          ],
        )
      ],
    );
  }
}
