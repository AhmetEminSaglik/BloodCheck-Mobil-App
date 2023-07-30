import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_harpia_health_analysis/httprequest/BaseHttpRequest.dart';
import 'package:flutter_harpia_health_analysis/httprequest/ResponseEntity.dart';
import 'package:flutter_harpia_health_analysis/business/factory/UserFactory.dart';
import 'package:flutter_harpia_health_analysis/model/user/Doctor.dart';
import 'package:flutter_harpia_health_analysis/model/user/Patient.dart';
import 'package:flutter_harpia_health_analysis/util/HttpUtil.dart';
import 'package:http/http.dart' as http;

import '../model/user/User.dart';

class HttpRequestDoctor {
  static const String _classUrl = "/doctors";
  static final String _baseUrl = BaseHttpRequestConfig.baseUrl + _classUrl;

  Future<List<Patient>> getPatientListOfDoctorId(int id) async {
    Uri url = Uri.parse("$_baseUrl/$id/patients");
    print("URL : $url");
    //http://localhost:8080/api/1.0/doctors/7/patients
    var resp = await http.get(url);
    // debugPrint(resp.body);

    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Patient> patientList = UserFactory.createPatientList(respEntity.data);
    return patientList;
  }

  Future<List<Doctor>> getDoctorList() async {
    Uri url = Uri.parse(_baseUrl);
    print("URL : $url");
    var resp = await http.get(url);
    Map<String, dynamic> jsonData = json.decode(resp.body);
    var respEntity = ResponseEntity.fromJson(jsonData);
    List<Doctor> doctorList = UserFactory.createDoctorList(respEntity.data);
    return doctorList;
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
