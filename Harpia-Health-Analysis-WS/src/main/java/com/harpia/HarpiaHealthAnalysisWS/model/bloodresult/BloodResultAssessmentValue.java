package com.harpia.HarpiaHealthAnalysisWS.model.bloodresult;

import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumBloodResultContent;

import java.util.HashMap;

public class BloodResultAssessmentValue {
    //    final List<ItemRangeValue> list = new ArrayList<>();
    private final HashMap<String, ItemRangeValue> map = new HashMap();

    public BloodResultAssessmentValue() {
        map.putIfAbsent(EnumBloodResultContent.BLOOD_SUGAR.name(), bloodSugarRange);
        map.putIfAbsent(EnumBloodResultContent.BLOOD_PRESSURE.name(), bloodPressureRange);
        map.putIfAbsent(EnumBloodResultContent.CALCIUM.name(), calciumRange);
        map.putIfAbsent(EnumBloodResultContent.MAGNESIUM.name(), magnesiumRange);
//        list.add(bloodSugar);
//        list.add(bloodPressure);
//        list.add(magnesium);
//        list.add(calcium);
    }

    private final ItemRangeValue bloodSugarRange = new ItemRangeValue(50, 150);
    private final ItemRangeValue bloodPressureRange = new ItemRangeValue(50, 150);
    private final ItemRangeValue magnesiumRange = new ItemRangeValue(50, 150);
    private final ItemRangeValue calciumRange = new ItemRangeValue(50, 150);

    public HashMap<String, ItemRangeValue> getMap() {
        return map;
    }

    public ItemRangeValue getBloodSugarRange() {
        return bloodSugarRange;
    }

    public ItemRangeValue getBloodPressureRange() {
        return bloodPressureRange;
    }

    public ItemRangeValue getMagnesiumRange() {
        return magnesiumRange;
    }

    public ItemRangeValue getCalciumRange() {
        return calciumRange;
    }
}
