import 'dart:developer';
class CustomLog {
  late final String _className;

  CustomLog({required className}) {
    _className = className;
  }

  todo(String text) {
    log("TODO --> $text", name: _className,);
  }

  info(String text) {
    log("INFO --> $text", name: _className);
  }

  error(String msg) {
    log("", error: "ERROR --> $msg", name: _className);
  }
}
