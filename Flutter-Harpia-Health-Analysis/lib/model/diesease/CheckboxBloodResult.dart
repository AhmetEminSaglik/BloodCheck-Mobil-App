class CheckboxBloodResultSubItem {
  late String _name;
  late bool _showContent;

  CheckboxBloodResultSubItem({required String name, required bool showContent}) {
    _name = name;
    _showContent = showContent;
  }

  bool get showContent => _showContent;

  set showContent(bool value) {
    print("CheckboxBloodResultSubItem > showcontent : $showContent");
    _showContent = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
