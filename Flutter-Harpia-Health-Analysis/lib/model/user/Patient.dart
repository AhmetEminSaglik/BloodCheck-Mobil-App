import 'dart:ffi';

import 'User.dart';

class Patient extends User {
  late int _diseaseTypeId;

  Patient(
      {required int id,
      required int roleId,
      required String name,
      required String lastname,
      required String username,
      required String password,
      required int diseaseTypeId})
      : super(
            id: id,
            roleId: roleId,
            name: name,
            lastname: lastname,
            username: username,
            password: password) {
    _diseaseTypeId = diseaseTypeId;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json["id"],
        roleId: json["roleId"] as int,
        name: json["name"] as String,
        lastname: json["lastname"] as String,
        username: json["username"] as String,
        password: json["password"] as String,
        diseaseTypeId: json["diseaseTypeId"] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roleId': roleId,
      'name': name,
      'lastname': lastname,
      'username': username,
      'password': password,
      'diseaseTypeId': _diseaseTypeId
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
        ", diseaseTypeId='$_diseaseTypeId'" +
        '}';
  }

  int get diseaseTypeId => _diseaseTypeId;

  set diseaseTypeId(int value) {
    _diseaseTypeId = value;
  }
}
