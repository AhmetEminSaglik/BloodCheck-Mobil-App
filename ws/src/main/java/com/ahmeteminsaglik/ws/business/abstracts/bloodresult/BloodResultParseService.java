package com.ahmeteminsaglik.ws.business.abstracts.bloodresult;

import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;

import java.util.List;

public interface BloodResultParseService {
    List<BloodResult> parseToDaily(List<BloodResult> list);

    List<BloodResult> parseToWeekly(List<BloodResult> list);

    List<BloodResult> parseToMonthly(List<BloodResult> list);
}
