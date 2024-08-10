package com.ahmeteminsaglik.ws.business.abstracts.bloodresult;

import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;

public interface BloodResultAssessmentService {

    void assessToSendFcmMsg(BloodResult bloodResult);
}
