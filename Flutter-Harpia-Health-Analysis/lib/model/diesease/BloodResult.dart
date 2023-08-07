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
      required createdAt});

  factory BloodResult.fromJson(Map<String, dynamic> json) {
    return BloodResult(
        id: json["id"] as int,
        patientId: json["patientId"] as int,
        bloodPresure: json["bloodPresure"] as int,
        bloodSugar: json["bloodSugar"] as int,
        createdAt: json["createdAt"] as DateTime);
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

  @override
  String toString() {
    return 'BloodResult{_id: $_id, _patientId: $_patientId, _bloodSugar: $_bloodSugar, _bloodPresure: $_bloodPresure, _createdAt: $_createdAt}';
  }
}
