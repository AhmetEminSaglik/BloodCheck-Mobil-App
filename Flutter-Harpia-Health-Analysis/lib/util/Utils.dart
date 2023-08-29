import '../model/enums/user/EnumUserProp.dart';
import 'SharedPref.dart';

class SharedPrefUtils {
  static int getRoleId() {
    return SharedPref.sp.getInt(EnumUserProp.ROLE_ID.name);
  }

  static int getUserId() {
    return SharedPref.sp.getInt(EnumUserProp.ID.name);
  }
}
