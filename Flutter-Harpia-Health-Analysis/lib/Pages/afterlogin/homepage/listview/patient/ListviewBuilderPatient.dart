import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/httprequest/HttpRequestDoctor.dart';
import 'package:flutter_harpia_health_analysis/util/Utils.dart';
import '../../../../../core/ResponsiveDesign.dart';
import '../../../../../httprequest/HttpRequestPatient.dart';
import '../../../../../model/diesease/EnumDiabeticType.dart';
import '../../../../../model/user/Patient.dart';
import '../../../../../util/ProductColor.dart';
import '../../users/HomePagePatient.dart';

class ListviewBuilderPatient extends StatefulWidget {
  int doctorId;

  ListviewBuilderPatient([this.doctorId = -1]);

  @override
  State<ListviewBuilderPatient> createState() => _ListviewBuilderPatientState();
}

class _ListviewBuilderPatientState extends State<ListviewBuilderPatient> {
  bool isLoading = true;
  List<Patient> patientList = [];

  @override
  void initState() {
    super.initState();
    retrivePatientList();
  }

  void retrivePatientList() async {
    isLoading = true;
    setState(() {});
    var resp;
    if (widget.doctorId == -1) {
      resp = await HttpRequestPatient.getPatientList();
    } else {
      resp = await HttpRequestDoctor.getPatientListOfDoctorId(widget.doctorId);
    }
    setState(() {
      isLoading = false;
      patientList = resp;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*context
        .read<AppBarCubit>()
        .setTitleRoleNameWithPageListSize(patientList.length);*/
    return Scaffold(
        backgroundColor: ProductColor.bodyBackground,
        body: RefreshIndicator(
            onRefresh: () async {
              retrivePatientList();
            },
            child: isLoading
            ? Center(child: CircularProgressIndicator())
        : getBodyForPatientListView(patientList),));
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
    return Padding(
      padding: EdgeInsets.only(
        left: ResponsiveDesign.getScreenWidth() / 40,
        top: ResponsiveDesign.getScreenWidth() / 80,
        right: ResponsiveDesign.getScreenWidth() / 40,
      ),
      child: ListView.builder(
          itemCount: patientList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // print("Click Item : ${patientList[index]}");
                navigateToPatientChartPage(
                    context: context,
                    routePage: HomePagePatient(
                        patientId: patientList[index].id,
                        displayNamePatientPage:
                            "${patientList[index].name} ${patientList[index].lastname}"));
              },
              child: Card(
                color: CustomListViewItemColor.getBackgroundColor(
                    colorindex: 2, index: index),
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
                        right: ResponsiveDesign.getScreenWidth() / 25,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ListViewItemText(
                              isBold: false,
                              text:
                                  "${"${patientList[index].name} ${patientList[index].lastname}"}"),
                          const Spacer(),
                          SizedBox(
                              width: ResponsiveDesign.getScreenWidth() / 3.5,
                              child: ListViewItemText(
                                  isBold: true,
                                  text: EnumDiabeticType.getTypeName(
                                      patientList[index].diabeticTypeId))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ListViewItemText extends StatelessWidget {
  const ListViewItemText({super.key, required this.text, required this.isBold});

  final bool isBold;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ResponsiveDesign.getScreenWidth() / 35),
      child: Text(
        text,
        style: TextStyle(
          fontSize:ResponsiveDesign.getScreenHeight() / 50,
          // isBold
          //     ? ResponsiveDesign.getScreenHeight() / 50
          //     : ResponsiveDesign.getScreenHeight() / 47,
          fontWeight: isBold ? FontWeight.bold : null,
        ),
      ),
    );
  }
}

void navigateToPatientChartPage(
    {required BuildContext context, required routePage}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => routePage));
}
