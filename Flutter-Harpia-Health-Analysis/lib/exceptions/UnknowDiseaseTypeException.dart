class UnknowDiseaseTypeException implements Exception {
  final String msg;

  UnknowDiseaseTypeException({required this.msg});

  @override
  String toString() {
    return "Unknow-User-RoleId-Exception: $msg";
  }
}
