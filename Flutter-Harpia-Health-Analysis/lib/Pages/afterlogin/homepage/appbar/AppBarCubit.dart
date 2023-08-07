import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_harpia_health_analysis/Pages/afterlogin/homepage/appbar/MainAppBar.dart';

import '../../../../model/EnumUserProp.dart';
import '../../../../model/userrole/EnumUserRole.dart';
import '../../../../util/SharedPref.dart';
import '../../../../util/Utils.dart';
import 'AppBarAdmin.dart';
import 'AppBarDoctor.dart';
import 'AppBarPatient.dart';

class AppBarCubit extends Cubit<Widget> {
  Widget appBarTitleWidget = const Text("Empty Text");
  var backgroundColor = Colors.green;

  AppBarCubit() : super(const Text("Empty Text"));

  // AppBar appBar = AppBar(title: const Text("Empty AppBar"));

  // AppBarCubit() : super(AppBar(title: const Text("Empty AppBar")));

  void setTitle(Widget title) {
    appBarTitleWidget = AppBar(title: title);
    print('new title : $title');
    emit(appBarTitleWidget);
  }

  void setTitleRoleName() {
    int roleId = SharedPref.sp.getInt(EnumUserProp.ROLE_ID.name);
    String roleName = EnumUserRole.getRoleName(roleId);
    appBarTitleWidget = Text("$roleName Page");
    emit(appBarTitleWidget);
  }

  void setTitleRoleNameWithPageListSize(int listSize) {
    int roleId = SharedPrefUtils.getRoleId();
    String roleName = EnumUserRole.getRoleName(roleId);
    appBarTitleWidget = Row(
        children: [Text("$roleName Page"), const Spacer(), Text("$listSize")]);
    emit(appBarTitleWidget);
  }
// AppBarCubit() : super(getUserAppBar());

/* static AppBar getUserAppBar() {
    final int userRoleId = SharedPrefUtils.getRoleId();
    if (userRoleId == EnumUserRole.ADMIN.roleId) {
      return AppBarAdmin(title: const Text("Admin AppBar Empty"));
    } else if (userRoleId == EnumUserRole.DOCTOR.roleId) {
      return  AppBarDoctor(title: const Text("Admin AppBar Empty"));
      ();
    } else if (userRoleId == EnumUserRole.PATIENT.roleId) {
      return AppBarPatient();
    }
    return AppBar(
      title: Text("Unknow UserRoleType is login"),
    ); //const Text("Unknow UserRoleType is login");
  }*/
}
