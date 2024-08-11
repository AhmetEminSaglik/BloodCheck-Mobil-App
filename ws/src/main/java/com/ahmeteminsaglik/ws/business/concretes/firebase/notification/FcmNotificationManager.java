package com.ahmeteminsaglik.ws.business.concretes.firebase.notification;

import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmNotificationService;
import com.ahmeteminsaglik.ws.mapper.FcmToMessageMapper;
import com.ahmeteminsaglik.ws.model.firebase.FcmMessage;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;

@Service
public class FcmNotificationManager implements FcmNotificationService {
    private static CustomLog log = new CustomLog(FcmNotificationManager.class);
    private static String path = "src/main/resources/service-key.json";
    static boolean isFirebaseInitialized = false;

    public FcmNotificationManager() {
        init();
    }

    private void init() {
        try {
            if (!isFirebaseInitialized) {
                isFirebaseInitialized = true;
                FileInputStream serviceAccount =
                        new FileInputStream(path);

                FirebaseOptions options = new FirebaseOptions.Builder()
                        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                        .build();
                FirebaseApp.initializeApp(options);
            }
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }
    @Override
    public ResponseEntity<String> sendNotification(FcmMessage fcmMessage/*@RequestBody FcmMessage fcmMessage*/) {
         try {
            Message message = FcmToMessageMapper.map(fcmMessage);
            FirebaseMessaging.getInstance().send(message);
            return ResponseEntity.status(HttpStatus.OK).body("Success");
        } catch (FirebaseMessagingException e) {
            return ResponseEntity.status(HttpStatus.BAD_GATEWAY).body("Firebase Sending message has been occured an error.");
        }

    }
}
