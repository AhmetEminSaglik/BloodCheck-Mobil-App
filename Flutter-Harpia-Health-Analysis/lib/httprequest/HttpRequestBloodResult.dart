import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_harpia_health_analysis/business/factory/BloodResultFactory.dart';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/BloodResult.dart';
import 'package:http/http.dart' as http;

import '../model/user/Patient.dart';
import '../util/HttpUtil.dart';
import 'ResponseEntity.dart';

class HttpRequestBloodResult {
  static const String _classUrl = "/bloodresults";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  static Future<List<BloodResult>> _sendBloodResultRequestToUrl(Uri url) async {
    debugPrint("URL : $url");
    var resp = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<BloodResult> bloodResultList =
        BloodResultFactory.createBloodResultList(respEntity.data);
    return bloodResultList;
  }

  static Future<List<BloodResult>> getDailyBloodResult(int patientId) async {
    Uri url = Uri.parse("$_baseUrl/patient/$patientId/daily");
    return _sendBloodResultRequestToUrl(url);
  }

  static Future<List<BloodResult>> getWeeklyBloodResult(int patientId) async {
    Uri url = Uri.parse("$_baseUrl/patient/$patientId/weekly");
    return _sendBloodResultRequestToUrl(url);
  }

  static Future<List<BloodResult>> getMonthlyBloodResult(int patientId) async {
    Uri url = Uri.parse("$_baseUrl/patient/$patientId/monthly");
    return _sendBloodResultRequestToUrl(url);
  }
  /*static Future<List<BloodResult>> getBloodResultDataOfPatientId(int patientId) async {
    Uri url = Uri.parse("$_baseUrl/patient/$patientId");
    print("URL : $url");
    var resp = await http.get(url);
    // log(resp.body);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<BloodResult> bloodResultList =
    BloodResultFactory.createBloodResultList(respEntity.data);
    return bloodResultList;
  }*/

  Future<http.Response> signUp(Patient user) async {
    Uri url = Uri.parse(_baseUrl);
    print("URL : $url");
    Map<String, dynamic> requestData = user.toJson();
    print("to json  $requestData");
    var resp = await http.post(url,
        headers: HttpUtil.header, body: jsonEncode(requestData));
    print('requestData : $requestData');
    print('resp : $resp');
    print('resp.body : ${resp.body}');
    return resp;
  }
}
