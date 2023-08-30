package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification;

import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import org.springframework.http.ResponseEntity;

import java.awt.*;

public interface FcmNotificationService {
    ResponseEntity<String> sendNotification(FcmMessage message);

}
