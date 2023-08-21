import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/CustomLineChartDataWeekly.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/LineChartDemo1.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/LineChartWeekly.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/BloodResult.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimer.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimerWidget.dart';
import '../../../../httprequest/HttpRequestBloodResult.dart';
import '../../../../httprequest/ResponseEntity.dart';
import '../../../../model/diesease/CheckboxBloodResult.dart';
import '../../../../model/diesease/EnumBloodResultContent.dart';
import '../../../../util/CustomAlertDialog.dart';
import '../../../../util/CustomSnackBar.dart';
import '../../../../util/PermissionUtils.dart';
import '../../../../util/ProductColor.dart';
import '../../../CustomWidgets/CustomLineChartDataDaily.dart';
import '../../../CustomWidgets/LineChartDaily.dart';
import '../../../CustomWidgets/CheckBoxVisibleBloodResultContent.dart';
import '../../../CustomWidgets/LineChartDemo2.dart';
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
  StatefulWidget? activatedLineChartWidget;

  void updateActivatedLineChart(int selectedRadioValue) {
    switch (selectedRadioValue) {
      case 1:
        activatedLineChartWidget = LineChartDaily(
          customLineChartData: _customLineChartDataDaily,
          checkBoxVisibleBloodResultContent: _checkBoxVisibleBloodResultContent,
        );
        break;
      case 2:
        activatedLineChartWidget = LineChartWeekly(
          customLineChartData: _customLineChartDataWeekly,
          checkBoxVisibleBloodResultContent: _checkBoxVisibleBloodResultContent,
        );
        break;
      case 3:
        activatedLineChartWidget = null;
        break;
      case 4:
        activatedLineChartWidget = null;
        break;
    }
    setState(() {});
  }

  bool visibleAppBar =
      PermissionUtils.letRunForAdmin() || PermissionUtils.letRunForDoctor();
  bool visiblePatientTimer = PermissionUtils.letRunForDoctor();
  bool isLoading = true;

  // List<bool> isVisibleBloodResultSubItems=[];
  // IsVisibleBloodResultSubItem visibleSubItem = IsVisibleBloodResultSubItem();
  List<BloodResult> dailyBloodResultList = [];
  List<BloodResult> weeklyBloodResultList = [];
  List<BloodResult> monthlyBloodResultList = [];
  CheckBoxVisibleBloodResultContent _checkBoxVisibleBloodResultContent =
      CheckBoxVisibleBloodResultContent();
  late CustomLineChartDataDaily _customLineChartDataDaily;
  late CustomLineChartDataWeekly _customLineChartDataWeekly;

  // List<Widget> checkBoxBloodResultContents = [];

  @override
  void initState() {
    super.initState();
    retrieveBloodResultData();
  }

/*
  void fillCheckboxContents() {
    for (int i = 0; i < _checkBoxVisibleBloodResultContent.list.length; i++) {
      checkBoxBloodResultContents.add(getCheckboxBloodResultItem(
          bloodResultCheckbox: _checkBoxVisibleBloodResultContent.list[i]));
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
    _customLineChartDataDaily =
        CustomLineChartDataDaily(bloodListData: dailyBloodResultList);
    // _customLineChartDataDaily.bottomTitle.forEach((element) {});

    _customLineChartDataWeekly =
        CustomLineChartDataWeekly(bloodListData: weeklyBloodResultList);
    // _customLineChartDataWeekly.bottomTitle.forEach((element) {});

    updateActivatedLineChart(1);
  }

  bool showBloodSugar = true;
  bool showBloodPressure = false;
  int radioValue = 1;

  @override
  Widget build(BuildContext context) {
    // print(
    //     "---------> tekradan calisti :  VisibleItems : $_checkBoxVisibleBloodResultContent}");
    return Scaffold(
      appBar: visibleAppBar ? getAppBar() : null,
      backgroundColor:
          isLoading ? ProductColor.bodyBackground : ProductColor.white,
      body: isLoading
          // ? const LoadingScreenWidget()
          ? const LoadingScreenWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
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
                                        getCheckboxBloodResultItem(
                                          bloodResultSubItemCheckbox:
                                              _checkBoxVisibleBloodResultContent
                                                      .subItemMap[
                                                  EnumBloodResultContent
                                                      .BLOOD_SUGAR.name]!,
                                          itemColor: ProductColor
                                              .fLSpotColorBloodSugar,
                                        ),
                                        getCheckboxBloodResultItem(
                                          bloodResultSubItemCheckbox:
                                              _checkBoxVisibleBloodResultContent
                                                      .subItemMap[
                                                  EnumBloodResultContent
                                                      .CALCIUM.name]!,
                                          itemColor:
                                              ProductColor.fLSpotColorCalcium,
                                        ),
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Column(children: checkBoxBloodResultContents,), I dont understand why checkbox is not working in this way.
                                        getCheckboxBloodResultItem(
                                          bloodResultSubItemCheckbox:
                                              _checkBoxVisibleBloodResultContent
                                                      .subItemMap[
                                                  EnumBloodResultContent
                                                      .BLOOD_PRESSURE.name]!,
                                          itemColor: ProductColor
                                              .fLSpotColorBloodPressure,
                                        ),
                                        getCheckboxBloodResultItem(
                                          bloodResultSubItemCheckbox:
                                              _checkBoxVisibleBloodResultContent
                                                      .subItemMap[
                                                  EnumBloodResultContent
                                                      .MAGNESIUM.name]!,
                                          itemColor:
                                              ProductColor.fLSpotColorMagnesium,
                                        ),
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
                  SizedBox(
                      width: ResponsiveDesign.getScreenWidth(),
                      height: ResponsiveDesign.getScreenHeight() / 2.5,
                      child: activatedLineChartWidget),
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
            radioValue = value!;
            updateActivatedLineChart(radioValue);
          },
        ),
      ),
    );
  }

  Widget getCheckboxBloodResultItem({
    required CheckboxBloodResultSubItem bloodResultSubItemCheckbox,
    required Color itemColor,
  }) {
    return SizedBox(
      width: ResponsiveDesign.getScreenWidth() / 2,
      child: CheckboxListTile(
          activeColor: itemColor,
          title: Text(
            bloodResultSubItemCheckbox.name,
            style: TextStyle(
                fontSize: ResponsiveDesign.getScreenWidth() / 22,
                color: itemColor),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: bloodResultSubItemCheckbox.showContent,
          onChanged: (bool? condition) {
            bloodResultSubItemCheckbox.showContent = condition!;
            updateActivatedLineChart(radioValue);
          }),
    );
  }

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

class VisibleBloodResultSubItems {}

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
