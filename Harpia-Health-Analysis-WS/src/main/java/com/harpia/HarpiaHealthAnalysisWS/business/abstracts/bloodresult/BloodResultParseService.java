package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.bloodresult;

import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;

import java.util.List;

public interface BloodResultParseService {
    List<BloodResult> parseToDaily(List<BloodResult> list);

    List<BloodResult> parseToWeekly(List<BloodResult> list);

    List<BloodResult> parseToMonthly(List<BloodResult> list);
}
