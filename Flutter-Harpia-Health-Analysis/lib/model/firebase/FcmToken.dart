class FcmToken {
  late int _id;
  late int _patientId;
  late String _token;

  FcmToken({required patientId, required token}) {
    _patientId = patientId;
    _token = token;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get patientId => _patientId;

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  set patientId(int value) {
    _patientId = value;
  }

  @override
  String toString() {
    return 'Token{_id: $_id, _patientId: $_patientId, _token: $_token}';
  }
}
