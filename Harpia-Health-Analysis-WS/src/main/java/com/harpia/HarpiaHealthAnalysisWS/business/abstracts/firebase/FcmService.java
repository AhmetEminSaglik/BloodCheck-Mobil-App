package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase;

import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import org.springframework.http.ResponseEntity;

public interface FcmService {
    ResponseEntity<String> sendFcmNotification(FcmMessage message);
}
