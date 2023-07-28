import 'dart:ffi';

import '../user/Patient.dart';

class Disease {
  late Long _id;
  late int _diseaseTypeId;
  late Patient _patient;

  Disease(
      {required Long id,
      required int diseaseTypeId,
      required Patient patient}) {
    this._id = id;
    this._diseaseTypeId = diseaseTypeId;
    this._patient = patient;
  }

  factory fromJson(Map<String, dynamic> json) {
    return Disease(
        id: json["id"] as Long,
        diseaseTypeId: json["diseaseTypeId"] as int,
        patient: Patient.fromJson(json));
  }
}
