/*
import 'dart:ffi';

import 'package:flutter_harpia_health_analysis/exceptions/UnknowDiseaseTypeException.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/old-Diabetic.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/EnumDiabeticType.dart';

abstract class Disease {
  late int _id;
  late int _diseaseTypeId;
  late int _patientId;

  Disease(
      {required int id, required int diseaseTypeId, required int patientId}) {
    _id = id;
    _diseaseTypeId = diseaseTypeId;
    _patientId = patientId;
  }

  factory Disease.fromJson(Map<String, dynamic> json) {
    int diseaseTypeId = json["diseaseTypeId"];
    if (diseaseTypeId == EnumDiseaseType.DIABETIC.id) {
      return Diabetic.fromJson(json);
    }
    throw UnknowDiseaseTypeException(
        msg: "$diseaseTypeId is an unknow Disease Type id");
  }

  int get patientId => _patientId;

  set patientId(int value) {
    _patientId = value;
  }

  int get diseaseTypeId => _diseaseTypeId;

  set diseaseTypeId(int value) {
    _diseaseTypeId = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
*/
