import 'package:flutter_harpia_health_analysis/model/diesease/Disease.dart';

class DiseaseFactory {
  static List<Disease> createDiseaseList(List<dynamic> json) {
    List<Disease> diseaseList =
        json.map((data) => Disease.fromJson(data)).toList();
    return diseaseList;
  }
}
