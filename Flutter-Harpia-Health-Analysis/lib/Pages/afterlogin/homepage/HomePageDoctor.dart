import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/HomePagePatient.dart';
import 'package:flutter_harpia_health_analysis/core/ResponsiveDesign.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestPatient.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/EnumDiseaseType.dart';
import 'package:flutter_harpia_health_analysis/model/user/User.dart';
import 'package:flutter_harpia_health_analysis/util/SharedPref.dart';

import '../../../model/EnumUserProp.dart';
import '../../../model/user/Patient.dart';
import '../../../util/ProductColor.dart';

class HomePageDoctor extends StatefulWidget {
  const HomePageDoctor({Key? key}) : super(key: key);

  @override
  State<HomePageDoctor> createState() => _HomePageDoctorState();
}

class _HomePageDoctorState extends State<HomePageDoctor> {
  @override
  Widget build(BuildContext context) {
    return const PatientListFutureBuilderWidget();
    // const ExampleListPlaceHolder(
    //     color: Colors.cyan, text: "Patient ListView"),
  }
}

class ListviewBuilderPatient extends StatelessWidget {
  const ListviewBuilderPatient({
    super.key,
    required this.patientList,
  });

  final List<Patient> patientList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text("My Patient List"),
        ),
        backgroundColor: Colors.cyan,
        body: ListView.builder(
            itemCount: patientList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // print("Click Item : ${patientList[index]}");
                  navigateToPatientChartPage(context: context);
                },
                child: Card(
                  color: getListViewItemBackgroundColor(
                      colorindex: 1, index: index),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))
                      /*borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),*/
                      ),
                  child: Container(
                    height: ResponsiveDesign.getScreenHeight() / 11,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: ResponsiveDesign.getScreenWidth() / 25,
                          top: ResponsiveDesign.getScreenWidth() / 17,
                          right: ResponsiveDesign.getScreenWidth() / 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ListViewItemText(
                                isBold: false,
                                text:
                                    "${index + 1}-) ${"${patientList[index].name} ${patientList[index].lastname}"}"),
                            SizedBox(
                                width: ResponsiveDesign.getScreenWidth() / 5,
                                child: ListViewItemText(
                                    isBold: true,
                                    text: EnumDiseaseType.getDiseaseName(
                                        patientList[index].diseaseTypeId))),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}

Color getListViewItemBackgroundColor(
    {required int colorindex, required int index}) {
  if (colorindex == 1) {
    return index % 2 == 0 ? Colors.cyanAccent : Colors.tealAccent;
  } else if (colorindex == 2) {
    return index % 2 == 0 ? Colors.white : Colors.white70;
  } else if (colorindex == 3) {
    return index % 2 == 0 ? Colors.white54 : Colors.white70;
  } else if (colorindex == 4) {
    return index % 2 == 0 ? Colors.white : Colors.blueGrey;
  }
  return Colors.black;
}

void navigateToPatientChartPage({required BuildContext context}) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const HomePagePatient()));
}

class ListViewItemText extends StatelessWidget {
  const ListViewItemText({super.key, required this.text, required this.isBold});

  final bool isBold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: ResponsiveDesign.getScreenHeight() / 45,
        fontWeight: isBold ? FontWeight.bold : null,
      ),
    );
  }
}

class PatientListFutureBuilderWidget extends StatelessWidget {
  const PatientListFutureBuilderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Patient>>(
      future: getPatientList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('ERROR: ${snapshot.error}'),
          );
        } else {
          List<Patient> patientList = snapshot.data ?? [];
          return ListviewBuilderPatient(patientList: patientList);
        }
      },
    );
  }
}

class ExampleListPlaceHolder extends StatelessWidget {
  final String text;
  final Color color;

  const ExampleListPlaceHolder({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            // width: ResponsiveDesign.getScreenWidth(),
            // height: ResponsiveDesign.getScreenHeight() / 2,
            // color: Colors.BLACK,
            child: FutureBuilder<List<User>>(
                // mainAxisAlignment: MainAxisAlignment.center,
                future: getPatientList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Veri alınana kadar yükleniyor gösterelim
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Hata durumunda hata mesajını gösterelim
                    return Text('Hata: ${snapshot.error}');
                  } else {
                    // Veri geldiyse Column'u döndürelim
                    return Text(snapshot.data
                        .toString()); //snapshot.data ?? Container();
                  }
                })),
      ],
    );
  }
}

Future<List<Patient>> getPatientList() async {
  int id = SharedPref.sp.getInt(EnumUserProp.ID.name) ?? -1;
  var http = HttpRequestDoctor();
  List<Patient> patientList = await http.getPatientListOfDoctorId(id);
  return patientList;
}
