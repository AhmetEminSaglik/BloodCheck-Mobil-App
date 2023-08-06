import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/AppBarCubit.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/listview/doctor/DoctorListFutureBuilder.dart';
import 'package:flutter_harpia_health_analysis/util/ProductColor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'HomePageDoctorList.dart';
import 'HomePagePatientList.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  var pageList = [DoctorListFutureBuilder(), const HomePagePatientList()];

  // var pageList = [ const HomePagePatientList(),const HomePageDoctorList()];

  int selectedIndex = 0;
  var cont = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      // body: pageList[selectedIndex],
      body: IndexedStack(
        children: pageList,
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userDoctor), label: "Doctor"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bed), label: "Patient"),
        ],
        // currentIndex: selectedIndex,
        onTap: (index) {
          // cont.jumpToPage(index);
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
