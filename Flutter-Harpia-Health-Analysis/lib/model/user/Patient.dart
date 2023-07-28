import 'dart:ffi';

import 'User.dart';

class Patient extends User {
  Patient(
      {required int id,
      required int roleId,
      required String name,
      required String lastname,
      required String username,
      required String password})
      : super(
            id: id,
            roleId: roleId,
            name: name,
            lastname: lastname,
            username: username,
            password: password);

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json["id"],
        roleId: json["roleId"] as int,
        name: json["name"] as String,
        lastname: json["lastname"] as String,
        username: json["username"] as String,
        password: json["password"] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password
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
        '}';
  }
}
