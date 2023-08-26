class BottomSideTitle {
  late int _index;
  late String _text;

  BottomSideTitle({required int index, required String text}) {
    _index = index;
    _text = text;
  }

  String get text => _text;

  int get index => _index;
}
