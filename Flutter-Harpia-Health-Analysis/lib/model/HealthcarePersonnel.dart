import 'package:flutter_harpia_health_analysis/model/User.dart';

class HealthcarePersonnel extends User {
  int? totalPatientNumber;

  HealthcarePersonnel(
      {required int id,
      required int roleId,
      required String name,
      required String lastname,
      required String username,
      required String password,
      required int totalPatientNumber})
      : super(
            id: id,
            roleId: roleId,
            name: name,
            lastname: lastname,
            username: username,
            password: password) {
    this.totalPatientNumber = totalPatientNumber;
  }

  factory HealthcarePersonnel.fromJson(Map<String, dynamic> json) {
    return HealthcarePersonnel(
        id: json["id"] as int,
        roleId: json["roleId"] as int,
        name: json["name"] as String,
        lastname: json["lastname"] as String,
        username: json["username"] as String,
        password: json["password"] as String,
        totalPatientNumber: json["totalPatientNumber"] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password,
      'totalPatientNumber': totalPatientNumber
    };
  }

  String toString() {
    return "HealthcarePersonnel{" +
        "id=$id" +
        ", roleId=$roleId" +
        ", name='$name'" +
        ", lastname='$lastname'" +
        ", username='$username'" +
        ", password='$password'" +
        "totalPatientNumber: '$totalPatientNumber'" +
        '}';
  }
}
