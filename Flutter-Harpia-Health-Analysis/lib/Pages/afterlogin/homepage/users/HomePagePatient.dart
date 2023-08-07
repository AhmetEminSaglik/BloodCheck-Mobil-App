import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/CustomWidgets/LineChartDemo1.dart';
import '../../../../util/PermissionUtils.dart';
import '../../../../util/ProductColor.dart';
import '../../../CustomWidgets/LineChartDemo2.dart';
import '../appbar/AppBarCubit.dart';

class HomePagePatient extends StatefulWidget {
  final String displayNamePatientPage;

  const HomePagePatient({super.key, required this.displayNamePatientPage});

  @override
  State<HomePagePatient> createState() => _HomePagePatientState();
}

class _HomePagePatientState extends State<HomePagePatient> {
  bool visibleAppBar = false;

  @override
  void initState() {
    super.initState();
    visibleAppBar =
        PermissionUtils.letRunForAdmin() || PermissionUtils.letRunForDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: visibleAppBar ? getAppBar() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: 450, height: 300, child: LineChartDemo1()),
            SizedBox(width: 450, height: 300, child: LineChartDemo2()),
          ],
        ),
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
