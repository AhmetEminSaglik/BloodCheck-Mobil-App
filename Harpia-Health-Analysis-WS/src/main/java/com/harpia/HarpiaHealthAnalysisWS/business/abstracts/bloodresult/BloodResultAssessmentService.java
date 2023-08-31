package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.bloodresult;

import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;

public interface BloodResultAssessmentService {

    void assessToSendFcmMsg(BloodResult bloodResult);
}
