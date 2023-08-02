import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/users/HomePageDoctor.dart';
import 'package:flutter_harpia_health_analysis/model/user/Doctor.dart';
import '../../../../../core/ResponsiveDesign.dart';
import '../../../../../util/Utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../appbar/AppBarCubit.dart';

class ListviewBuilderDoctor extends StatelessWidget {
  const ListviewBuilderDoctor({
    super.key,
    required this.doctorList,
  });

  final List<Doctor> doctorList;

  @override
  Widget build(BuildContext context) {
    context
        .read<AppBarCubit>()
        .setTitleRoleNameWithPageListSize(doctorList.length);
    return Scaffold(
        backgroundColor: Colors.cyan,
        body: getBodyForPatientListView(doctorList));
  }
}

Widget getBodyForPatientListView(List<Doctor> doctorList) {
  if (doctorList.isEmpty) {
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
        itemCount: doctorList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // print("Click Item : ${doctorList[index]}");
              navigateToPatientChartPage(
                  context: context,
                  routePage: HomePageDoctor(id: doctorList[index].id));
            },
            child: Card(
              color: CustomListViewItemColor.getBackgroundColor(
                  colorindex: 2, index: index),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
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
                                "${index + 1}-) ${"${doctorList[index].name} ${doctorList[index].lastname}"}"),
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
    return index % 2 == 0 ? ProductColor.white : ProductColor.dartWhite;
  } else if (colorindex == 3) {
    return index % 2 == 0 ? Colors.white54 : Colors.white70;
  } else if (colorindex == 4) {
    return index % 2 == 0 ? Colors.white : Colors.blueGrey;
  }
  return Colors.black;
}*/
