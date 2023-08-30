package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification;

import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import org.springframework.http.ResponseEntity;

import java.awt.*;

public interface FcmMsgService {
    String generateTextWithHtmlColor(String notificationTitle, Color color);
}

