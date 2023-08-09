import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimer.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimerAlertBoxRespond.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimerWidget.dart';
import '../../../../httprequest/ResponseEntity.dart';
import '../../../../util/CustomAlertDialog.dart';
import '../../../../util/CustomSnackBar.dart';
import '../../../../util/PermissionUtils.dart';
import '../../../../util/ProductColor.dart';
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
  bool visibleAppBar =
      PermissionUtils.letRunForAdmin() || PermissionUtils.letRunForDoctor();
  bool visiblePatientTimer = PermissionUtils.letRunForDoctor();

  /*@override
  void initState() {
    super.initState();
    visibleAppBar =
        PermissionUtils.letRunForAdmin() || PermissionUtils.letRunForDoctor();
    visiblePatientTimer = PermissionUtils.letRunForDoctor();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: visibleAppBar ? getAppBar() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(width: 450, height: 300, child: LineChartDemo1()),
            SizedBox(width: 450, height: 300, child: LineChartDemo2()),
            _getPatientTimerButton(),
          ],
        ),
      ),
    );
  }

  Widget _getPatientTimerButton() {
    if (visiblePatientTimer) {
      return ElevatedButton(
          onPressed: () {
            showAlertDialogSetUpPatientTimer();
            /*
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PatientTimer()));
         */
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
