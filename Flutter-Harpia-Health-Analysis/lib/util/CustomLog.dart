import 'dart:developer';

class CustomLog {
  late final String _className;

  CustomLog({required className}) {
    _className = className;
  }

  info(String text) {
    log("INFO --> $text", name: _className);
  }
  error(String text) {
    log("ERROR --> $text", name: _className);
  }
}
