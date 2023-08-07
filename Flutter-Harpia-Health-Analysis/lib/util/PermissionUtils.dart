import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';
import 'package:flutter_harpia_health_analysis/util/Utils.dart';

class PermissionUtils {
  static bool letRunForAdmin() {
    if (EnumUserRole.ADMIN.roleId == SharedPrefUtils.getRoleId()) {
      return true;
    }
    return false;
  }

  static bool letRunForDoctor() {
    if (EnumUserRole.DOCTOR.roleId == SharedPrefUtils.getRoleId()) {
      return true;
    }
    return false;
  }
}
