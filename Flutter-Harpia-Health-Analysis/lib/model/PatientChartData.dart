import 'dart:ffi';

class PatientChartData {
  Long _patient_id;

  PatientChartData(this._patient_id);

  List _data = <double>[1, 2, 3.4, 2];

  Long get patient_id => _patient_id;

  set patient_id(Long value) {
    _patient_id = value;
  }

  List get data => _data;

  set data(List value) {
    _data = value;
  }
}
