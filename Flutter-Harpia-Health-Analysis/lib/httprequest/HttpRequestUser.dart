import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/httprequest/ResponseEntity.dart';
import 'package:flutter_harpia_health_analysis/util/HttpUtil.dart';
import 'package:http/http.dart' as http;

import '../model/user/User.dart';

class HttpRequestUser {
  static const String _classUrl = "/users";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  Future<void> getAllUserData() async {
    Uri url = Uri.parse(_baseUrl);
    // var resp = await http.get(url);
    // debugPrint(resp.body);
  }

  Future<http.Response> login(String username, String password) async {
    Uri url = Uri.parse("$_baseUrl/login");
    print("URL : ${url}");
    // var requestData = {"username": username, "password": password};
    Map<String, dynamic> requestData = {
      "username": username,
      "password": password,
    };
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    return resp;
  }


}
