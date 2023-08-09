class PatientTimer {
  int _hours = 0;
  int _minutes = 0;
  int _patientId = -1;

  int get hours => _hours;

  set hours(int value) {
    _hours = value;
  }

  int get minutes => _minutes;

  set minutes(int value) {
    _minutes = value;
  }

  int get patientId => _patientId;

  set patientId(int value) {
    _patientId = value;
  }

  @override
  String toString() {
    return 'PatientTimer{_hour: $_hours, _min: $_minutes, _patientId: $_patientId}';
  }
}
