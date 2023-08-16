import 'package:flutter_harpia_health_analysis/model/diesease/BloodResultCheckbox.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/EnumBloodResultContent.dart';

class VisibleBloodResultContent {
  List<BloodResultCheckbox> list = [];

  VisibleBloodResultContent() {
    list.add(BloodResultCheckbox(
        name: EnumBloodResultContent.BLOOD_SUGAR.name, showContent: false));
    list.add(BloodResultCheckbox(
        name: EnumBloodResultContent.BLOOD_PRESSURE.name, showContent: false));
    list.add(BloodResultCheckbox(
        name: EnumBloodResultContent.CALCIUM.name, showContent: true));
    list.add(BloodResultCheckbox(
        name: EnumBloodResultContent.MAGNESIUM.name, showContent: true));
  }
}
