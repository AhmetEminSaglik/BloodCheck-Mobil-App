import 'dart:ffi';

import 'package:flutter_harpia_health_analysis/model/diesease/Disease.dart';

class Diabetic extends Disease {
  late int _bloodSugar;
  late int _bloodPressure;
  late int _cholesterol;

  Diabetic(
      {required int id,
      required int diseaseTypeId,
      required int patientId,
      required int bloodSugar,
      required int bloodPressure,
      required int cholesterol})
      : super(id: id, diseaseTypeId: diseaseTypeId, patientId: patientId) {
    _bloodPressure = bloodPressure;
    _bloodSugar = bloodSugar;
    _cholesterol = cholesterol;
  }

  factory Diabetic.fromJson(Map<String, dynamic> json) {
    return Diabetic(
      id: json["id"] as int,
      diseaseTypeId: json["diseaseTypeId"] as int,
      patientId: json["patientId"] as int,
      bloodPressure: json["bloodPressure"] as int,
      bloodSugar: json["bloodSugar"] as int,
      cholesterol: json["cholesterol"] as int,
    );
  }

  @override
  String toString() {
    return 'Diabetic{' +
        'id=$id,' +
        ' diseaseTypeId=$diseaseTypeId,' +
        ' patientId=$patientId,' +
        ' bloodSugar: $_bloodSugar,' +
        ' bloodPressure: $_bloodPressure,' +
        ' cholesterol: $_cholesterol' +
        '}';
  }
}
