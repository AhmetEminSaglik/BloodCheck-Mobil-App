import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/LineChartEmpty.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/LineChartMonthly.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/LineChartWeekly.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/data/LineChartDataDaily.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/data/LineChartDataMonthly.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/linechart/data/LineChartDataWeekly.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestPatient.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/BloodResult.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimer.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimerWidget.dart';
import 'package:flutter_harpia_health_analysis/util/PatientTimerUtils.dart';
import '../../../../httprequest/HttpRequestBloodResult.dart';
import '../../../../httprequest/ResponseEntity.dart';
import '../../../../model/diesease/CheckboxBloodResult.dart';
import '../../../../model/diesease/EnumBloodResultContent.dart';
import '../../../../util/CustomAlertDialog.dart';
import '../../../../util/CustomSnackBar.dart';
import '../../../../util/PermissionUtils.dart';
import '../../../../util/ProductColor.dart';
import '../../../CustomWidgets/LineChartDaily.dart';
import '../../../CustomWidgets/CheckBoxVisibleBloodResultContent.dart';
import '../../../CustomWidgets/linechart/data/BaseLineChartData.dart';
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
  LineChartEmpty lineChartEmpty = LineChartEmpty();
  StatefulWidget? activatedLineChartWidget;
  late BaseLineChartPreData _baseLineChartPreData;
  bool visibleAppBar =
      PermissionUtils.letRunForAdmin() || PermissionUtils.letRunForDoctor();
  bool visiblePatientTimer = PermissionUtils.letRunForDoctor();
  bool isLoading = true;
  List<BloodResult> dailyBloodResultList = [];
  List<BloodResult> weeklyBloodResultList = [];
  List<BloodResult> monthlyBloodResultList = [];
  PatientTimer patientTimer = PatientTimer();

  // bool listDataIsEmpty = false;
  final CheckBoxVisibleBloodResultContent _checkBoxVisibleBloodResultContent =
      CheckBoxVisibleBloodResultContent();
  late BaseLineChartPreData _lineChartDataDaily;
  late BaseLineChartPreData _lineChartDataWeekly;
  late BaseLineChartPreData _lineChartDataMonthly;

  void updateActivatedLineChart(int selectedRadioValue) {
    print("ILK GIRIS : $selectedRadioValue}");
    switch (selectedRadioValue) {
      case 1:
        if (!assignEmptyLineChart(dailyBloodResultList)) {
          activatedLineChartWidget = LineChartDaily(
            baseLineChartPreData: _lineChartDataDaily,
            checkBoxVisibleBloodResultContent:
                _checkBoxVisibleBloodResultContent,
          );
        }
        // _baseLineChartPreData =
        //     LineChartDataDaily2(bloodResultList: dailyBloodResultList);
        //
        // print("DAILY  : $_baseLineChartPreData");
        // print("dailyBloodResultList : ${dailyBloodResultList.length}");

        break;
      case 2:
        if (!assignEmptyLineChart(weeklyBloodResultList)) {
          activatedLineChartWidget = LineChartWeekly(
            baseLineChartPreData: _lineChartDataWeekly,
            checkBoxVisibleBloodResultContent:
                _checkBoxVisibleBloodResultContent,
          );
        }
        break;
      case 3:
        if (!assignEmptyLineChart(monthlyBloodResultList)) {
          activatedLineChartWidget = LineChartMonthly(
              baseLineChartPreData: _lineChartDataMonthly,
              checkBoxVisibleBloodResultContent:
                  _checkBoxVisibleBloodResultContent);
        }
        break;
      case 4:
        activatedLineChartWidget = null;
        break;
    }
    setState(() {});
  }

  bool assignEmptyLineChart(List list) {
    if (list.isEmpty) {
      activatedLineChartWidget = lineChartEmpty;
      // listDataIsEmpty = true;
      return true;
    }
    return false;
  }

  // List<Widget> checkBoxBloodResultContents = [];

  @override
  void initState() {
    super.initState();
    retrieveBloodResultData();
    retrievePatientTimerData();
    activatedLineChartWidget = lineChartEmpty;
  }

  void retrievePatientTimerData() async {
    patientTimer =
        await HttpRequestPatient.retrievePatientTimer(widget.patientId);
  }

  void retrieveBloodResultData() async {
    // print("DATA RETRIEVED patient Id : ${widget.patientId}");
    dailyBloodResultList =
        await HttpRequestBloodResult.getDailyBloodResult(widget.patientId);
    weeklyBloodResultList =
        await HttpRequestBloodResult.getWeeklyBloodResult(widget.patientId);
    monthlyBloodResultList =
        await HttpRequestBloodResult.getMonthlyBloodResult(widget.patientId);

    _lineChartDataDaily= LineChartPreDataDaily(bloodResultList:dailyBloodResultList);
    _lineChartDataWeekly= LineChartPreDataWeekly(bloodResultList:weeklyBloodResultList);
    _lineChartDataMonthly= LineChartPreDataMonthly(bloodResultList:monthlyBloodResultList);
    print("DATA RETRIEVED dailyBloodResultList size :${dailyBloodResultList.length} ");
    print("DATA RETRIEVED weeklyBloodResultList size :${weeklyBloodResultList.length} ");
    print("DATA RETRIEVED monthlyBloodResultList size :${monthlyBloodResultList.length} ");

    setState(() {
      isLoading = false;
    });
    //
    // _customLineChartDataDaily =
    //     CustomLineChartDataDaily(bloodListData: dailyBloodResultList);
    //
    // _customLineChartDataWeekly =
    //     CustomLineChartDataWeekly(bloodListData: weeklyBloodResultList);
    // _customLineChartDataMonthly =
    //     CustomLineChartDataMonthly(bloodListData: monthlyBloodResultList);
    // print(
    //     "Data's retrieved agian : daily item ${dailyBloodResultList[0]} / ${dailyBloodResultList[dailyBloodResultList.length - 1]}");
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
      // backgroundColor:ProductColor.bodyBackground,
      backgroundColor:
          isLoading ? ProductColor.bodyBackground : ProductColor.white,
      body: RefreshIndicator(
          onRefresh: () async {
            retrieveBloodResultData();
            print("RefreshIndicator CALISTI");
          },
          child: /* isLoading
              ? Center(child: CircularProgressIndicator())
              : getBodyDoctorListview(doctorList),*/
              isLoading
                  // ? const LoadingScreenWidget()
                  ? const LoadingScreenWidget()
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            height: ResponsiveDesign.getScreenHeight() / 9,
                            color: ProductColor.bodyBackground,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SensorTimerText(patientTimer: patientTimer),
                                  SensorNextMeasurementText(
                                      dailyBloodResultList:
                                          dailyBloodResultList,
                                      patientTimer: patientTimer),
                                ],
                              ),
                            ),
                          ),

                          // SensorTimerText(patientTimer: patientTimer),
                          Container(
                            // color: Colors.redAccent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                                              .BLOOD_SUGAR
                                                              .name]!,
                                                  itemColor: ProductColor
                                                      .fLSpotColorBloodSugar,
                                                ),
                                                getCheckboxBloodResultItem(
                                                  bloodResultSubItemCheckbox:
                                                      _checkBoxVisibleBloodResultContent
                                                              .subItemMap[
                                                          EnumBloodResultContent
                                                              .CALCIUM.name]!,
                                                  itemColor: ProductColor
                                                      .fLSpotColorCalcium,
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
                                                      .BLOOD_PRESSURE
                                                      .name]!,
                                                  itemColor: ProductColor
                                                      .fLSpotColorBloodPressure,
                                                ),
                                                getCheckboxBloodResultItem(
                                                  bloodResultSubItemCheckbox:
                                                  _checkBoxVisibleBloodResultContent
                                                      .subItemMap[
                                                  EnumBloodResultContent
                                                      .MAGNESIUM.name]!,
                                                  itemColor: ProductColor
                                                      .fLSpotColorMagnesium,
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
                          // _getPatientTimerButton(),
                          _getPatientTimerButton(),
                          SizedBox(
                              width: ResponsiveDesign.getScreenWidth(),
                              height: ResponsiveDesign.getScreenHeight() / 2,
                              child: Container(
                                // width: 500,
                                // height: 500,
                                // color: Colors.red,
                                child: activatedLineChartWidget ??
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // getNotFoundRecordedDataText(),
                                        Text(
                                          "Here is not completed yet.",
                                          style: TextStyle(
                                              fontSize: ResponsiveDesign
                                                      .getScreenWidth() /
                                                  15),
                                        ),
                                        // const CircularProgressIndicator(),
                                      ],
                                    ),
                              )),
                        ],
                      ),
                    )),
    );
  }

  /* Text getNotFoundRecordedDataText() {
    if (listDataIsEmpty) {
      return Text("Not Found Any Recorded Data");
    }
    return Text("");
  }
*/
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
      retrievePatientTimerData();
      setState(() {});
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

class SensorNextMeasurementText extends StatelessWidget {
  const SensorNextMeasurementText({
    super.key,
    required this.dailyBloodResultList,
    required this.patientTimer,
  });

  final List<BloodResult> dailyBloodResultList;
  final PatientTimer patientTimer;

  String _getStringDataToShow() {
    if (dailyBloodResultList.length > 0) {
      return "Next Time : ${PatientTimerUtils.calculateSensorNextMeasurementTime(lastCreatedAt: dailyBloodResultList[0].createdAt, patientTimer: patientTimer)}";
    }
    return "Not found record Blood Result";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveDesign.getScreenWidth() / 10,
        right: ResponsiveDesign.getScreenWidth() / 10,
        // top: ResponsiveDesign.getScreenHeight() / 50,
      ),
      child: Container(
        width: ResponsiveDesign.getScreenWidth(),
        height: ResponsiveDesign.getScreenHeight() / 25,
        // color: ProductColor.white,
        child: Center(
          child: Text(
              /*"Next Time : ${PatientTimerUtils.calculateSensorNextMeasurementTime(lastCreatedAt: dailyBloodResultList[0].createdAt, patientTimer: patientTimer)}"*/
              _getStringDataToShow(),
              style: TextStyle(
                  fontSize: ResponsiveDesign.getScreenWidth() / 20,
                  // color: ProductColor.bodyBackground,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class SensorTimerText extends StatelessWidget {
  const SensorTimerText({
    super.key,
    required this.patientTimer,
  });

  final PatientTimer patientTimer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveDesign.getScreenWidth() / 10,
        right: ResponsiveDesign.getScreenWidth() / 10,
        top: ResponsiveDesign.getScreenHeight() / 50,
      ),
      child: Container(
        width: ResponsiveDesign.getScreenWidth(),
        height: ResponsiveDesign.getScreenHeight() / 25,
        // color: ProductColor.white,
        child: Center(
          child: Text(
              "Sensor Timer : ${PatientTimerUtils.getReadableFormat(patientTimer)}",
              style: TextStyle(
                  fontSize: ResponsiveDesign.getScreenWidth() / 20,
                  // color: ProductColor.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

/*class NextMeasurementTimeOfSensor extends StatelessWidget {
  const NextMeasurementTimeOfSensor({
    super.key,
    required this.patientTimer,
  });

  final PatientTimer patientTimer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveDesign.getScreenWidth() / 10,
        right: ResponsiveDesign.getScreenWidth() / 10,
        top: ResponsiveDesign.getScreenHeight() / 50,
      ),
      child: Container(
        width: ResponsiveDesign.getScreenWidth(),
        height: ResponsiveDesign.getScreenHeight() / 15,
        // color: ProductColor.white,
        child: Center(
          child: Text(
              "Sensor Timer : ${PatientTimerUtils.getReadableFormat(patientTimer)}",
              style: TextStyle(
                  fontSize: ResponsiveDesign.getScreenWidth() / 12,
                  color: ProductColor.bodyBackground,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}*/

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
