class BloodResult {
  late int _id;
  late int _patientId;
  late int _bloodSugar;
  late int _bloodPresure;
  late DateTime _createdAt;

  BloodResult(
      {required id,
      required patientId,
      required bloodSugar,
      required bloodPresure,
      required createdAt}){
    _id=id;
    _patientId=patientId;
    _bloodSugar=bloodSugar;
    _bloodPresure=bloodPresure;
    _createdAt=createdAt;

  }

  factory BloodResult.fromJson(Map<String, dynamic> json) {
    String createdTimeText=json["createdAt"] as String;
    DateTime createdDate=DateTime.parse(createdTimeText);
    return BloodResult(
        id: json["id"] as int,
        patientId: json["patientId"] as int,
        bloodPresure: json["bloodPressure"] as int,
        bloodSugar: json["bloodSugar"] as int,
        createdAt:createdDate);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'patientId': _patientId,
      'bloodSugar': _bloodSugar,
      'bloodPresure': _bloodPresure,
      'createdAt': _createdAt
    };
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  @override
  String toString() {
    return 'BloodResult{_id: $_id, _patientId: $_patientId, _bloodSugar: $_bloodSugar, _bloodPresure: $_bloodPresure, _createdAt: $_createdAt}';
  }

  int get patientId => _patientId;

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  int get bloodPresure => _bloodPresure;

  set bloodPresure(int value) {
    _bloodPresure = value;
  }

  int get bloodSugar => _bloodSugar;

  set bloodSugar(int value) {
    _bloodSugar = value;
  }

  set patientId(int value) {
    _patientId = value;
  }
}
