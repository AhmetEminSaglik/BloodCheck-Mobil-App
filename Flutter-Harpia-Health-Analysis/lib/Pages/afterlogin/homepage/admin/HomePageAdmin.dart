import 'package:flutter/material.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/admin/HomePageDoctorList.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/admin/HomePagePatientList.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  var pageList = [const HomePageDoctorList(), const HomePagePatientList()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // return DoctorListFutureBuilder(doctorList: getDoctorList(), appBarTitle: "Doctor List");\
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("test"),
      //   backgroundColor: Colors.redAccent,
      // ),
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          // BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: "Doctor"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.userDoctor), label: "Doctor"),
          // BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.bed), label: "Patient"),
        ],
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex=index;
          });
        },
      ),
    );
    /*return DoctorListFutureBuilder(
        doctorList: getDoctorList(), appBarTitle: "Doctor List");*/
    /*return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: SingleChildScrollView(
              child: DoctorListFutureBuilder(
                  doctorList: getDoctorList(), appBarTitle: "Doctor List"),
            ),
          ),
          const SizedBox(height: 100),
          SizedBox(
            height: 200,
            child: PatientListFutureBuilder(
              patientList: getPatientList(),
              appBarTitle: "Patient List",
            ),
          )
        ],
      ),
    );*/
  }
}

/*Future<List<Patient>> getPatientList() async {
  var http = HttpRequestPatient();
  List<Patient> patientList = await http.getPatientList();
  print('patient list size : ${patientList.length}');
  return patientList;
}*/

/*Future<List<Doctor>> getDoctorList() async {
  var http = HttpRequestDoctor();
  List<Doctor> doctorList = await http.getDoctorList();
  print('doctorList  size : ${doctorList.length}');
  return doctorList;
}*/
