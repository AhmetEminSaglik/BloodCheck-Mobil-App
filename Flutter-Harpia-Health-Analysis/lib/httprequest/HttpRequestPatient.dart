import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:http/http.dart' as http;

import '../business/factory/UserFactory.dart';
import '../model/user/Patient.dart';
import 'ResponseEntity.dart';

class HttpRequestPatient {
  static const String _classUrl = "/patients";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  Future<List<Patient>> getPatientList() async {
    Uri url = Uri.parse(_baseUrl);
    print("URL : $url");
    var resp = await http.get(url);
    debugPrint(resp.body);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Patient> patientList = UserFactory.createPatientList(respEntity.data);
    return patientList;
  }
}
