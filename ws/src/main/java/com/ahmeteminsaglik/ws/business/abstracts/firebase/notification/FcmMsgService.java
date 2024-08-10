package com.ahmeteminsaglik.ws.business.abstracts.firebase.notification;

import com.ahmeteminsaglik.ws.model.firebase.FcmData;
import com.ahmeteminsaglik.ws.model.firebase.FcmMessage;
import com.ahmeteminsaglik.ws.model.firebase.FcmNotification;
import org.springframework.http.ResponseEntity;

import java.awt.*;

public interface FcmMsgService {
    String generateTextWithHtmlColor(String notificationTitle, Color color);

    FcmMessage generateFcmMsg(String token, FcmNotification notification, FcmData data);
}

