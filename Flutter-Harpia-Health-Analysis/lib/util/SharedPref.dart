import 'package:flutter_harpia_health_analysis/model/EnumUserProp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user/User.dart';

class SharedPref {
  static var sp = null;

  static void setLoginDataUser(User user) async {
    await _initiliazeSharedPref();
    _printSP();
    _addDataToSP(user);
    _printSP();
  }

  static Future<void> _initiliazeSharedPref() async {
    if (sp == null) {
      sp = await SharedPreferences.getInstance();
    }
  }

  static void _addDataToSP(User user) {
    sp.setInt(EnumUserProp.ID.name, user.id);
    sp.setInt(EnumUserProp.ROLE_ID.name, user.roleId);
    sp.setString(EnumUserProp.USERNAME.name, user.username);
    sp.setString(EnumUserProp.PASSWORD.name, user.password);
    sp.setString(EnumUserProp.NAME.name, user.name);
    sp.setString(EnumUserProp.LASTNAME.name, user.lastname);
  }

  static void _printSP() {
    print("----------------------------------------");
    print("PRINT USER DATA : EnumUserProp.ID.name : ${EnumUserProp.ID.name}");

    int id = sp.getInt(EnumUserProp.ID.name) ?? -1;
    int roleId = sp.getInt(EnumUserProp.ROLE_ID.name) ?? -1;
    String username = sp.getString(EnumUserProp.USERNAME.name) ?? "NULL";
    String pass = sp.getString(EnumUserProp.PASSWORD.name) ?? "NULL";
    String name = sp.getString(EnumUserProp.NAME.name) ?? "NULL";
    String lastname = sp.getString(EnumUserProp.LASTNAME.name) ?? "NULL";
    print(
        "id : $id, roleId $roleId, name : $name, lastname :$lastname, username : $username, password $pass");
  }
}
