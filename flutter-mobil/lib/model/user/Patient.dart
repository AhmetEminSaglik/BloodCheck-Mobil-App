import 'User.dart';

class Patient extends User {
  late int _diabeticTypeId;
  late int _doctorId;

  Patient(
      {required int id,
      required int roleId,
      required String name,
      required String lastname,
      required String username,
      String password = "",
      String token = "",
      required int diabeticTypeId,
      required int doctorId})
      : super(
            id: id,
            roleId: roleId,
            name: name,
            lastname: lastname,
            username: username,
            password: password,
            token: token) {
    _diabeticTypeId = diabeticTypeId;
    _doctorId = doctorId;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json["id"],
        roleId: json["roleId"] as int,
        name: json["name"] as String,
        lastname: json["lastname"] as String,
        username: json["username"] as String,
        // password: json["password"] as String,
        diabeticTypeId: json["diabeticTypeId"] as int,
        doctorId: json["doctorId"] as int);
  }

  // factory Patient.fromJsonForLogin(Map<String, dynamic> json) {
  //   Patient patient = Patient.fromJson(json);
  //   User user=User.fromJsonForLogin(json);
  //   patient.token = user.token;
  //   return patient;
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password,
      'token': token,
      'diabeticTypeId': _diabeticTypeId,
      'doctorId': _doctorId,
    };
  }

  String toString() {
    return "Patient{" +
        "id=$id" +
        ", roleId=$roleId" +
        ", name='$name'" +
        ", lastname='$lastname'" +
        ", username='$username'" +
        ", password='$password'" +
        ", token='$token'" +
        ", doctorId='$_doctorId'" +
        ", diabeticTypeId='$_diabeticTypeId'" +
        '}';
  }

  int get doctorId => _doctorId;

  set doctorId(int value) {
    _doctorId = value;
  }

  int get diabeticTypeId => _diabeticTypeId;

  set diabeticTypeId(int value) {
    _diabeticTypeId = value;
  }
}
