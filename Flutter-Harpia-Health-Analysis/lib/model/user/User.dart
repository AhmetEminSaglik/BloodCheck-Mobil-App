import 'dart:ffi';

import 'package:flutter_harpia_health_analysis/exception/Exceptions.dart';
import 'package:flutter_harpia_health_analysis/model/user/Admin.dart';
import 'package:flutter_harpia_health_analysis/model/user/Doctor.dart';
import 'package:flutter_harpia_health_analysis/model/userrole/EnumUserRole.dart';

import 'Patient.dart';

abstract class User {
  late Long _id;
  late int _roleId;
  late String _name;
  late String _lastname;
  late String _username;
  late String _password;

  User(
      {required Long id,
      required int roleId,
      required String name,
      required String lastname,
      required String username,
      required String password}) {
    _id = id;
    _roleId = roleId;
    _name = name;
    _lastname = lastname;
    _username = username;
    _password = password;
  }

  factory User.fromJson(Map<String, dynamic> json) {
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

  Long get id => _id;

  set id(Long value) {
    _id = value;
  }
}
