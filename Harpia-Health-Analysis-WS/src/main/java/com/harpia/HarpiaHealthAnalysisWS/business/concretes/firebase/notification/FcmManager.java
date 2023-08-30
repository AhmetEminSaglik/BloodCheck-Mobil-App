package com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase.notification;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmMsgService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmNotificationService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmService;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.awt.*;

@Service
public class FcmManager implements FcmService {
    @Autowired
    FcmMsgService msgService;
    @Autowired
    FcmNotificationService notificationService;

    @Override
    public String generateTextWithHtmlColor(String notificationTitle, Color color) {
        return msgService.generateTextWithHtmlColor(notificationTitle, color);
    }

    @Override
    public ResponseEntity<String> sendNotification(FcmMessage message) {
        return notificationService.sendNotification(message);
    }
}
