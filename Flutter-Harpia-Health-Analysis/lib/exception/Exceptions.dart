class UnknowUserRoleIdException implements Exception {
  final String msg;

  UnknowUserRoleIdException({required this.msg});

  @override
  String toString() {
    return "UnknowUserRoleIdException: $msg";
  }
}
