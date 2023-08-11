package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase;

import com.harpia.HarpiaHealthAnalysisWS.model.firebase.PushNotificationRequest;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import org.springframework.http.ResponseEntity;

public interface FirebaseMessagingService {
    ResponseEntity<DataResult<PushNotificationRequest>> sendNotificationByToken(PushNotificationRequest pushNotificationRequest);
}
