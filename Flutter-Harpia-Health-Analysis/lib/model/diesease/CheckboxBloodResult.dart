class CheckboxBloodResult {
  late String _name;
  late bool _showContent;

  CheckboxBloodResult({required String name, required bool showContent}) {
    _name = name;
    _showContent = showContent;
  }

  bool get showContent => _showContent;

  set showContent(bool value) {
    _showContent = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
