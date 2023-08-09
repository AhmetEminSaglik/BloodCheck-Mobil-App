import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimer.dart';

class PatientTimerAlertBoxRespond {
  late bool _result;
  late PatientTimer _patientTimer;

/*  PatientTimerAlertBoxRespond({required result}) {
    _result = _result;
  }*/

  PatientTimerAlertBoxRespond({required result, required patientTimer}) {
    _result = result;
    _patientTimer = patientTimer;
  }

  bool get result => _result;

  set result(bool value) {
    _result = value;
  }

  PatientTimer get patientTimer => _patientTimer;

  set patientTimer(PatientTimer value) {
    _patientTimer = value;
  }
}
