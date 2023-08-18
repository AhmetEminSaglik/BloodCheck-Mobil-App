import 'package:flutter_harpia_health_analysis/model/diesease/CheckboxBloodResult.dart';
import 'package:flutter_harpia_health_analysis/model/diesease/EnumBloodResultContent.dart';

class CheckBoxVisibleBloodResultContent {
  List<CheckboxBloodResult> list = [];

  CheckBoxVisibleBloodResultContent() {
    list.add(CheckboxBloodResult(
        name: EnumBloodResultContent.BLOOD_SUGAR.name, showContent: false));
    list.add(CheckboxBloodResult(
        name: EnumBloodResultContent.BLOOD_PRESSURE.name, showContent: false));
    list.add(CheckboxBloodResult(
        name: EnumBloodResultContent.CALCIUM.name, showContent: true));
    list.add(CheckboxBloodResult(
        name: EnumBloodResultContent.MAGNESIUM.name, showContent: true));
  }
}
