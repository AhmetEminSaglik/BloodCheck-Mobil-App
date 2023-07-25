import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpRequest {
  static String _localhost = "http://10.0.2.2:";
  static String _port = "8080";
  static String _apiVersion = "/api/1.0";
  static String _baseUrl = _localhost + _port + _apiVersion;

  Future<void> getAllUserData() async {
    Uri url = Uri.parse("$_baseUrl/users");
    var resp = await http.get(url);
    debugPrint(resp.body);
  }
}
