package com.ahmeteminsaglik.ws.model.bloodresult;

import com.ahmeteminsaglik.ws.model.enums.EnumBloodResultContent;

import java.util.HashMap;

public class BloodResultBound {
    //    final List<ItemRangeValue> list = new ArrayList<>();
    private final HashMap<String, ItemRangeValue> rangeMap = new HashMap<>();

    private final ItemRangeValue bloodSugarRange = new ItemRangeValue(20, 100);
    private final ItemRangeValue bloodPressureRange = new ItemRangeValue(20, 100);
    private final ItemRangeValue magnesiumRange = new ItemRangeValue(20, 100);
    private final ItemRangeValue calciumRange = new ItemRangeValue(20, 100);

    public BloodResultBound() {
        rangeMap.putIfAbsent(EnumBloodResultContent.BLOOD_SUGAR.getName(), bloodSugarRange);
        rangeMap.putIfAbsent(EnumBloodResultContent.BLOOD_PRESSURE.getName(), bloodPressureRange);
        rangeMap.putIfAbsent(EnumBloodResultContent.CALCIUM.getName(), calciumRange);
        rangeMap.putIfAbsent(EnumBloodResultContent.MAGNESIUM.getName(), magnesiumRange);
//        list.add(bloodSugar);
//        list.add(bloodPressure);
//        list.add(magnesium);
//        list.add(calcium);
    }



   public HashMap<String, ItemRangeValue> getRangeMap() {
        return rangeMap;
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
