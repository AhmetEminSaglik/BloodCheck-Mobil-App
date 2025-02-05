import 'dart:convert';

import 'package:bloodcheck/exceptions/BadCredentialsException.dart';
import 'package:bloodcheck/httprequest/BaseHttpRequest.dart';
import 'package:bloodcheck/util/HttpUtil.dart';
import 'package:bloodcheck/util/SharedPrefUtils.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class HttpRequestLogin {
  // static const String _classUrl = "/users";
  // static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl;
  static var log = Logger(printer: PrettyPrinter(colors: false));

  Future<http.Response> login(String username, String password) async {
    Uri url = Uri.parse("$_baseUrl/login");
    log.i("URL : $url");

    Map<String, dynamic> requestData = {
      "username": username,
      "password": password,
    };
    // SharedPrefUtils.clearToken();
    var resp = await http.post(url,
        headers: HttpUtil.getHeaders(SharedPrefUtils.getToken()),
        body: jsonEncode(requestData));

    if (resp.statusCode == 400) {
      throw BadCredentialsException();
    }
    return resp;
  }
}
