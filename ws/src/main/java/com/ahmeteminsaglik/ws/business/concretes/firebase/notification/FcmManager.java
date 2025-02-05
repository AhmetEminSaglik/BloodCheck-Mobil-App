package com.ahmeteminsaglik.ws.business.concretes.firebase.notification;

import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmMsgService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmNotificationService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmService;
import com.ahmeteminsaglik.ws.model.firebase.FcmData;
import com.ahmeteminsaglik.ws.model.firebase.FcmMessage;
import com.ahmeteminsaglik.ws.model.firebase.FcmNotification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.awt.*;

@Service
public class FcmManager implements FcmService {
    private final FcmMsgService msgService;
    private final FcmNotificationService notificationService;

    @Autowired
    public FcmManager(FcmMsgService msgService, FcmNotificationService notificationService) {
        this.msgService = msgService;
        this.notificationService = notificationService;
    }

    @Override
    public String generateTextWithHtmlColor(String notificationTitle, Color color) {
        return msgService.generateTextWithHtmlColor(notificationTitle, color);
    }

    @Override
    public FcmMessage generateFcmMsg(String token, FcmNotification notification, FcmData data) {
        return msgService.generateFcmMsg(token, notification, data);
    }

    @Override
    public ResponseEntity<String> sendNotification(FcmMessage message) {
        return notificationService.sendNotification(message);
    }
}
