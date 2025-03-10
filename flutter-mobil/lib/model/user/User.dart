import 'package:bloodcheck/exceptions/UnknowUserRoleIdException.dart';
import 'package:bloodcheck/model/user/Admin.dart';
import 'package:bloodcheck/model/user/Doctor.dart';
import 'package:bloodcheck/model/userrole/EnumUserRole.dart';

import 'Patient.dart';

abstract class User {
  late int _id;
  late int _roleId;
  late String _name;
  late String _lastname;
  late String _username;
  late String _password;
  late String _token;

  User(
      {required int id,
      required int roleId,
      required String name,
      required String lastname,
      required String username,
      required String password,
      required String token}) {
    _id = id;
    _roleId = roleId;
    _name = name;
    _lastname = lastname;
    _username = username;
    _password = password;
    _token = token;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    json=json["userDto"];
    int roleId = json["roleId"];
    if (roleId == EnumUserRole.ADMIN.roleId) {
      return Admin.fromJson(json);
    } else if (roleId == EnumUserRole.DOCTOR.roleId) {
      return Doctor.fromJson(json);
    } else if (roleId == EnumUserRole.PATIENT.roleId) {
      return Patient.fromJson(json);
    }
    throw UnknowUserRoleIdException(msg: "$roleId is an unknow User Role id");
  }

  factory User.fromJsonForLogin(Map<String, dynamic> json) {
    User user = User.fromJson(json);
    user.token = json["token"];
    return user;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get lastname => _lastname;

  set lastname(String value) {
    _lastname = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get roleId => _roleId;

  set roleId(int value) {
    _roleId = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
