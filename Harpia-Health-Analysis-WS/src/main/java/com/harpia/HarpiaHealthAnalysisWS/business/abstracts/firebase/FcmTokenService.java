package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase;

import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmToken;

public interface FcmTokenService {

    FcmToken save(FcmToken fcmToken);

    FcmToken findByToken(String token);

    FcmToken findByPatientId(long patientId);
}