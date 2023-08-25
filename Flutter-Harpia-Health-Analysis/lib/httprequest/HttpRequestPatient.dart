import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/model/specialitem/doctor/PatientTimer.dart';
import 'package:http/http.dart' as http;

import '../business/factory/UserFactory.dart';
import '../model/user/Patient.dart';
import '../util/HttpUtil.dart';
import 'ResponseEntity.dart';

class HttpRequestPatient {
  static const String _classUrl = "/patients";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  static Future<List<Patient>> getPatientList() async {
    Uri url = Uri.parse(_baseUrl);
    print("URL : $url");
    var resp = await http.get(url);
    debugPrint(resp.body);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Patient> patientList = UserFactory.createPatientList(respEntity.data);
    return patientList;
  }

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

  static Future<PatientTimer> retrievePatientTimer(int patientId) async {
    Uri url = Uri.parse("${BaseHttpRequestConfig.baseUrl}/timers$_classUrl/$patientId");
    print("URL : $url");
    var resp = await http.get(url);
    debugPrint(resp.body);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    PatientTimer patientTimer = PatientTimer.fromJson(respEntity.data);
    print("RETRIEVED Patient Timer : $patientTimer");
    return patientTimer;
  }
}
