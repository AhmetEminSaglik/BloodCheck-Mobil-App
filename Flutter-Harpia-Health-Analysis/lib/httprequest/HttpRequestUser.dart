import 'dart:convert';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/util/HttpUtil.dart';
import 'package:http/http.dart' as http;

import '../util/CustomLog.dart';

class HttpRequestUser {
  static const String _classUrl = "/users";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;
  static CustomLog log = CustomLog(className: "HttpRequestUser");

  Future<http.Response> login(String username, String password) async {
    Uri url = Uri.parse("$_baseUrl/login");
    log.info("URL : $url");
    Map<String, dynamic> requestData = {
      "username": username,
      "password": password,
    };
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }
}
