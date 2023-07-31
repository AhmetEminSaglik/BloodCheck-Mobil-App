import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/util/Utils.dart';
import '../../../../../core/ResponsiveDesign.dart';
import '../../../../../model/diesease/EnumDiseaseType.dart';
import '../../../../../model/user/Patient.dart';
import '../../users/HomePagePatient.dart';

class ListviewBuilderPatient extends StatelessWidget {
  const ListviewBuilderPatient({
    super.key,
    required this.patientList,
  });

  final List<Patient> patientList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        body: getBodyForPatientListView(patientList));
  }
}

Widget getBodyForPatientListView(List<Patient> patientList) {
  if (patientList.isEmpty) {
    return Padding(
      padding: EdgeInsets.only(
          right: ResponsiveDesign.getScreenWidth() / 25,
          top: ResponsiveDesign.getScreenWidth() / 15,
          left: ResponsiveDesign.getScreenWidth() / 25),
      child: Text(
        "You dont have any patient yet.",
        style: TextStyle(
          fontSize: ResponsiveDesign.getScreenWidth() / 20,
        ),
      ),
    );
  } else {
    return ListView.builder(
        itemCount: patientList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // print("Click Item : ${patientList[index]}");
              navigateToPatientChartPage(
                  context: context,
                  routePage: HomePagePatient(
                      displayNamePatientPage:
                          "${patientList[index].name} ${patientList[index].lastname}"));
            },
            child: Card(
              color:
                  CustomListViewItemColor.getBackgroundColor(colorindex: 2, index: index),
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
        });
  }
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
        fontSize: ResponsiveDesign.getScreenHeight() / 43,
        fontWeight: isBold ? FontWeight.bold : null,
      ),
    );
  }
}

void navigateToPatientChartPage(
    {required BuildContext context, required routePage}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => routePage));
}
/*

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
*/
