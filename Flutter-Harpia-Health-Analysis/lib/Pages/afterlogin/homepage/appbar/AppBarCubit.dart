import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../model/userrole/EnumUserRole.dart';
import '../../../../util/CustomLog.dart';
import '../../../../util/SharedPrefUtils.dart';

class AppBarCubit extends Cubit<Widget> {
  Widget appBarTitleWidget = const Text("Empty Text");
  var backgroundColor = Colors.green;
  CustomLog log = CustomLog(className: "AppBarCubit");

  AppBarCubit() : super(const Text("Empty Text"));

  void setTitle(Widget title) {
    appBarTitleWidget = AppBar(title: title);
    log.info('new title : $title');
    emit(appBarTitleWidget);
  }

  void setTitleRoleName() {
    int roleId = SharedPrefUtils.getRoleId();
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
}
