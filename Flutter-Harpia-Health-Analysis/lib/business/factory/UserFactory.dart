import '../../model/user/Patient.dart';
import '../../model/user/User.dart';

class UserFactory {
  static User createUser(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  static List<User> createUserList(List<dynamic> json) {
    List<User> userList =
    json.map((data) => User.fromJson(data)).toList();
    return userList;
  }

  static List<Patient> createPatientList(List<dynamic> json) {
    List<Patient> patientList =
    json.map((data) => Patient.fromJson(data)).toList();
    return patientList;
  }
}

