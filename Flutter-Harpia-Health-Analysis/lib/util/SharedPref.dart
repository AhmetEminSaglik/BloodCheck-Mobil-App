import 'package:flutter_harpia_health_analysis/model/enums/user/EnumUserProp.dart';
import 'package:flutter_harpia_health_analysis/model/firebase/FcmToken.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
import 'package:flutter_harpia_health_analysis/util/FcmTokenUtils.dart';
import 'package:flutter_harpia_health_analysis/util/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../httprequest/HttpRequestFirebase.dart';
import '../model/user/User.dart';

class SharedPref {
  static var _sp = null;

  static Future<void> setLoginDataUser(User user) async {
    await initiliazeSharedPref();
    _printSP();
    _addDataToSP(user);
    _printSP();
  }

  static Future<SharedPreferences> initiliazeSharedPref() async {
    if (_sp == null) {
      _sp = await SharedPreferences.getInstance();
    }
    return sp;
  }

  static void _addDataToSP(User user) {
    _sp.setInt(EnumUserProp.ID.name, user.id);
    _sp.setInt(EnumUserProp.ROLE_ID.name, user.roleId);
    _sp.setString(EnumUserProp.USERNAME.name, user.username);
    _sp.setString(EnumUserProp.PASSWORD.name, user.password);
    _sp.setString(EnumUserProp.NAME.name, user.name);
    _sp.setString(EnumUserProp.LASTNAME.name, user.lastname);

    if (SharedPrefUtils.getRoleId() == EnumUserRole.PATIENT.roleId) {
      FcmToken fcmToken = FcmToken(
          patientId: SharedPrefUtils.getUserId(),
          token: FcmTokenUtils.getToken());
      HttpRequestFirebase.saveToken(fcmToken);
    }
  }

  static void _printSP() {
    print("----------------------------------------");
    print("PRINT USER DATA : EnumUserProp.ID.name : ${EnumUserProp.ID.name}");

    int id = _sp.getInt(EnumUserProp.ID.name) ?? -1;
    int roleId = _sp.getInt(EnumUserProp.ROLE_ID.name) ?? -1;
    String username = _sp.getString(EnumUserProp.USERNAME.name) ?? "NULL";
    String pass = _sp.getString(EnumUserProp.PASSWORD.name) ?? "NULL";
    String name = _sp.getString(EnumUserProp.NAME.name) ?? "NULL";
    String lastname = _sp.getString(EnumUserProp.LASTNAME.name) ?? "NULL";
    print(
        "id : $id, roleId $roleId, name : $name, lastname :$lastname, username : $username, password $pass");
  }

  static get sp => _sp;
}
