import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/BloodResult.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimer.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimerWidget.dart';
import '../../../../httprequest/HttpRequestBloodResult.dart';
import '../../../../httprequest/ResponseEntity.dart';
import '../../../../model/diesease/BloodResultCheckbox.dart';
import '../../../../util/CustomAlertDialog.dart';
import '../../../../util/CustomSnackBar.dart';
import '../../../../util/PermissionUtils.dart';
import '../../../../util/ProductColor.dart';
import '../../../CustomWidgets/LineChartDemo1.dart';
import '../../../CustomWidgets/LineChartDemo2.dart';
import '../../../CustomWidgets/LineChartDemo3.dart';
import '../../../CustomWidgets/VisibleBloodResultContent.dart';
import '../appbar/AppBarCubit.dart';

class HomePagePatient extends StatefulWidget {
  final String displayNamePatientPage;
  final int patientId;

  const HomePagePatient(
      {super.key,
      required this.displayNamePatientPage,
      required this.patientId});

  @override
  State<HomePagePatient> createState() => _HomePagePatientState();
}

class _HomePagePatientState extends State<HomePagePatient> {
  bool visibleAppBar =
      PermissionUtils.letRunForAdmin() || PermissionUtils.letRunForDoctor();
  bool visiblePatientTimer = PermissionUtils.letRunForDoctor();
  bool isLoading = true;
  List<BloodResult> dailyBloodResultList = [];
  List<BloodResult> weeklyBloodResultList = [];
  List<BloodResult> monthlyBloodResultList = [];
  VisibleBloodResultContent visibleBloodResultContent =
      VisibleBloodResultContent();

  // List<Widget> checkBoxBloodResultContents = [];

  @override
  void initState() {
    super.initState();
    retrieveBloodResultData();
    // fillCheckboxContents();
  }

/*
  void fillCheckboxContents() {
    for (int i = 0; i < visibleBloodResultContent.list.length; i++) {
      checkBoxBloodResultContents.add(getBloodResultCheckboxItem(
          bloodResultCheckbox: visibleBloodResultContent.list[i]));
    }
  }*/

  void retrieveBloodResultData() async {
    dailyBloodResultList =
        await HttpRequestBloodResult.getDailyBloodResult(widget.patientId);
    weeklyBloodResultList =
        await HttpRequestBloodResult.getWeeklyBloodResult(widget.patientId);
    monthlyBloodResultList =
        await HttpRequestBloodResult.getMonthlyBloodResult(widget.patientId);
    setState(() {
      isLoading = false;
    });
  }

  bool showBloodSugar = true;
  bool showBloodPressure = false;
  int radioValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: visibleAppBar ? getAppBar() : null,
      backgroundColor:
          isLoading ? ProductColor.bodyBackground : ProductColor.white,
      body: isLoading
          ? const LoadingScreenWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      width: ResponsiveDesign.getScreenWidth(),
                      height: ResponsiveDesign.getScreenHeight() / 3,
                      child: LineChartDaily()),
                  Container(
                    // color: Colors.redAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                getBloodResultRadioButtonTime(
                                    name: "Daily", itemValue: 1),
                                getBloodResultRadioButtonTime(
                                    name: "Monthly", itemValue: 3),
                              ],
                            ),
                            Column(
                              children: [
                                getBloodResultRadioButtonTime(
                                    name: "Weekly", itemValue: 2),
                                getBloodResultRadioButtonTime(
                                    name: "6 Month", itemValue: 4),
                              ],
                            )
                          ],
                        ),
                        Container(
                            // color: Colors.cyan,
                            width: ResponsiveDesign.getScreenWidth(),
                            child: Center(
                              child: Row(
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Column(children: checkBoxBloodResultContents,), I dont understand why checkbox is not working in this way.
                                        getBloodResultCheckboxItem(
                                            bloodResultCheckbox:
                                                visibleBloodResultContent
                                                    .list[0]),
                                        getBloodResultCheckboxItem(
                                            bloodResultCheckbox:
                                                visibleBloodResultContent
                                                    .list[2]),
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Column(children: checkBoxBloodResultContents,), I dont understand why checkbox is not working in this way.
                                        getBloodResultCheckboxItem(
                                            bloodResultCheckbox:
                                                visibleBloodResultContent
                                                    .list[1]),
                                        getBloodResultCheckboxItem(
                                            bloodResultCheckbox:
                                                visibleBloodResultContent
                                                    .list[3]),
                                      ]),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  // SizedBox(width: 450, height: 300, child: LineChartDemo1()),
                  // SizedBox(width: 450, height: 300, child: LineChartDemo2()),
                  _getPatientTimerButton(),
                ],
              ),
            ),
    );
  }

  Padding getBloodResultRadioButtonTime(
      {required String name, required int itemValue}) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveDesign.getScreenWidth() / 100),
      child: SizedBox(
        width: ResponsiveDesign.getScreenWidth() * 2 / 5,
        child: RadioListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            name,
            style: TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 20),
          ),
          value: itemValue,
          groupValue: radioValue,
          contentPadding: EdgeInsets.symmetric(
            horizontal: ResponsiveDesign.getScreenWidth() / 100,
          ),
          onChanged: (int? value) {
            setState(() {
              radioValue = value!;
            });
            print("$name is selected");
          },
        ),
      ),
    );
  }

  Widget getBloodResultCheckboxItem(
      {required BloodResultCheckbox bloodResultCheckbox}) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 2,
      child: CheckboxListTile(
          title: Text(
            bloodResultCheckbox.name,
            style: TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 22),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: bloodResultCheckbox.showContent,
          onChanged: (bool? condition) {
            print(
                "SetState Calisti : ${bloodResultCheckbox.name} VALUE : $condition");
            bloodResultCheckbox.showContent = condition!;
            setState(() {
              print(" ${bloodResultCheckbox.name}} : CONDITION : $condition");
            });
          }),
    );
  }

/*  SizedBox getBloodResultItemCheckbox(
      {required String name, required bool value}) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 2,
      child: CheckboxListTile(
          title: Text(
            name,
            style: TextStyle(fontSize: ResponsiveDesign.getScreenWidth() / 20),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: value,
          onChanged: (bool? condition) {
            print("SetState Calisti : $name  VALUE : $value");
              showBloodSugar = condition!;
            setState(() {
            print(" $name : CONDITION : $condition");
            });
          }),
    );
  }*/

  Widget _getPatientTimerButton() {
    if (visiblePatientTimer) {
      return ElevatedButton(
          onPressed: () {
            showAlertDialogSetUpPatientTimer();
          },
          child: Text("Set Patient Timer"));
    } else {
      return SizedBox.shrink();
    }
  }

  void showAlertDialogSetUpPatientTimer() async {
    PatientTimer timer = PatientTimer();
    // PatientTimerAlertBoxRespond response = PatientTimerAlertBoxRespond(
    //     result: false, patientTimer: PatientTimer());
    var resp = await showDialog(
        context: context,
        builder: (builder) => CustomAlertDialog.getAlertDialogSetUpPatientTimer(
              patientTimerWidget: PatientTimerWidget(),
              context: context,
            ));
    // if (resp is PatientTimerAlertBoxRespond) {
    //   print("resp.result ${resp.result}");
    if (resp != null && resp.result) {
      print("patientId : ${widget.patientId}");
      resp.patientTimer.patientId = widget.patientId;
      sendRequestToSavePatientTimer(resp.patientTimer);
    } else {
      String msg = "Patient Timer setup is cancelled";
      print(msg);
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.getSnackBar(msg));
    }
    // }
/*print("resp $resp");
    resp((value) => {
      print("result  $value")*/ /*
          response = value,
          if (response.result)
            {
              response.patientTimer.patientId = widget.patientId,
              sendRequestToSavePatientTimer(respAlertDialog.patientTimer),
            }
       */ /* });*/
  }

  void sendRequestToSavePatientTimer(PatientTimer patientTimer) async {
    // print("savelenecekd data : $patientTimer");
    var resp = await HttpRequestDoctor.savePatientTimer(patientTimer);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    String msg;
    if (respEntity.success) {
      msg = "Timer is updated Successfully.";
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.getSnackBar(msg));
    } else {
      msg = "FAILED :\n${respEntity.message}";
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar.getSnackBar(msg));
    }
  }
}

class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please Wait",
            style: TextStyle(
                fontSize: ResponsiveDesign.getScreenWidth() / 12,
                color: ProductColor.white),
          ),
          const CircularProgressIndicator()
        ],
      ),
    );
  }
}

AppBar getAppBar() {
  return AppBar(
    backgroundColor: ProductColor.appBarBackgroundColor,
    title: BlocBuilder<AppBarCubit, Widget>(builder: (builder, titleWidget) {
      return titleWidget;
    }),
  );
}
/*Future<void> printDiseaseList() async {
  var http = HttpRequestDisease();
  // print('patient Id :');
  if ((SharedPref.sp.getInt(EnumUserProp.ID.name) ??
      -1) == EnumUserRole.PATIENT) {
    var patientId = SharedPref.sp.getInt(EnumUserProp.ID.name) ?? -1;
    print('patient Id : $patientId');

    List<Disease> list = await http
        .getDiseaseListOfPatientid(patientId); //.then((value) => {list = value}
    list.forEach((e) {
      print("disease : $e");
    });
  }
}*/
