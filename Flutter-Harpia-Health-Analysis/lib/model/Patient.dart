import 'package:flutter_harpia_health_analysis/model/User.dart';

class Patient extends User {
  late int _diabeticType;

  Patient(
      {required int id,
      required int roleId,
      required String name,
      required String lastname,
      required String username,
      required String password,
      required int diabeticType})
      : super(
            id: id,
            roleId: roleId,
            name: name,
            lastname: lastname,
            username: username,
            password: password) {
    _diabeticType = diabeticType;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json["id"] as int,
        roleId: json["roleId"] as int,
        name: json["name"] as String,
        lastname: json["lastname"] as String,
        username: json["username"] as String,
        password: json["password"] as String,
        diabeticType: json["diabeticType"] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password,
      'diabeticType': diabeticType
    };
  }


  int get diabeticType => _diabeticType;

  set diabeticType(int value) {
    _diabeticType = value;
  }

  String toString() {
    return "Patient{" +
        "id=$id" +
        ", roleId=$roleId" +
        ", name='$name'" +
        ", lastname='$lastname'" +
        ", username='$username'" +
        ", password='$password'" +
        "diabeticType: '$diabeticType'" +
        '}';
  }
}
