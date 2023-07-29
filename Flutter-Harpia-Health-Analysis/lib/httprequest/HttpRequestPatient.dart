import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/util/HttpUtil.dart';
import 'package:http/http.dart' as http;

class HttpRequestPatient {
  static final String _classUrl = "/doctor";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  Future<void> getPatientListOfDoctorId(int id) async {
    Uri url = Uri.parse(_baseUrl);
    var resp = await http.get(url);
    debugPrint(resp.body);
  }

// Future<http.Response> login(String username, String password) async {
//   Uri url = Uri.parse("$_baseUrl/user/login");
//   var requestData = {"username": username, "password": password};
// Map<String, dynamic> requestData = {
//   "username": username,
//   "password": password,
// };
// var resp = await http.post(url,
//     headers: HttpUtil.header, body: jsonEncode(requestData));
// return resp;
// }
// Future<void> getDiseaseListOfPatientid(Long id) async {
//   Uri uri = Uri.parse(_baseUrl + "/${id}");
//   var resp = await http.get(uri);
//   debugPrint(resp.body);
// }
}
