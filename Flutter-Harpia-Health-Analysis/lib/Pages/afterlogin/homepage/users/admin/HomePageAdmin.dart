import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../listview/doctor/ListviewBuilderDoctor.dart';
import '../../listview/patient/ListviewBuilderPatient.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  var pageList = [ListviewBuilderDoctor(), ListviewBuilderPatient()];
  int selectedIndex = 0;
  var cont = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      // body: pageList[selectedIndex],
      body: IndexedStack(
        index: selectedIndex,
        children: pageList,
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
