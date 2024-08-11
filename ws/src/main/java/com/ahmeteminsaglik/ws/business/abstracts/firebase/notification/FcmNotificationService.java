package com.ahmeteminsaglik.ws.business.abstracts.firebase.notification;

import com.ahmeteminsaglik.ws.model.firebase.FcmMessage;
import org.springframework.http.ResponseEntity;

import java.awt.*;

public interface FcmNotificationService {
    ResponseEntity<String> sendNotification(FcmMessage message);

}