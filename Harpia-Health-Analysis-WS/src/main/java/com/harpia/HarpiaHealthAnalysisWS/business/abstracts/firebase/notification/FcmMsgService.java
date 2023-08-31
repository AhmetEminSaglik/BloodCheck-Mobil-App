package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification;

import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import org.springframework.http.ResponseEntity;

import java.awt.*;

public interface FcmMsgService {
    String generateTextWithHtmlColor(String notificationTitle, Color color);

    FcmMessage generateFcmMsg(String token, FcmNotification notification, FcmData data);
}

