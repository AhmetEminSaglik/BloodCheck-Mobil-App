import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/users/HomePage.dart';

import '../../../../model/EnumUserProp.dart';
import '../../../../model/userrole/EnumUserRole.dart';
import '../../../../util/SharedPref.dart';
import '../../../../util/Utils.dart';
import '../users/HomePageDoctor.dart';
import '../users/HomePagePatient.dart';
import '../users/admin/HomePageAdmin.dart';

class DrawerCubit extends Cubit<Widget> {
  Widget _body = const Text("Empty Text Widget");

  DrawerCubit() : super(getUserPage());

  void updateBody(Widget newBody) {

    _body = newBody;
    emit(_body);
  }

  void resetBody() {
    _body = getUserPage();
    emit(_body);
  }

  static Widget getUserPage() {
    int userRoleId = SharedPrefUtils.getRoleId();
    if (userRoleId == EnumUserRole.ADMIN.roleId) {
      return const HomePageAdmin();
    } else if (userRoleId == EnumUserRole.DOCTOR.roleId) {
      int doctorId = SharedPref.sp.getInt(EnumUserProp.ID.name) ?? -1;
      return HomePageDoctor(id: doctorId);
    } else if (userRoleId == EnumUserRole.PATIENT.roleId) {
      return const HomePagePatient(displayNamePatientPage: "My Disease Chart");
    }
    return const Text("Unknow UserRoleType is login");
  }
}
