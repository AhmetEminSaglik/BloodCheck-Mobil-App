package com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.FirebaseMessagingService;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.PushNotificationRequest;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.ErrorDataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class FirebaseMessagingManager implements FirebaseMessagingService {

    private static final Logger log = LoggerFactory.getLogger(FirebaseMessagingManager.class);

    @Autowired
    private FirebaseMessaging firebaseMessaging;

    @Override
    public ResponseEntity<DataResult<PushNotificationRequest>> sendNotificationByToken(PushNotificationRequest pushNotificationRequest) {
        log.info("------------------ > pushNotificationRequest : " + pushNotificationRequest);
        Notification notification = Notification
                .builder()
                .setTitle(pushNotificationRequest.getTitle())
                .setBody(pushNotificationRequest.getBody())
                .setImage(pushNotificationRequest.getImage())
                .build();
        log.info("------------------ > notification : " + notification);
        Message message = Message
                .builder()
                .setToken(pushNotificationRequest.getRecipientToken())
                .setNotification(notification)
                .putAllData(pushNotificationRequest.getData())
                .build();
        log.info("------------------ > message : " + message);
        try {
            firebaseMessaging.send(message);
            return ResponseEntity.status(HttpStatus.OK).body(new SuccessDataResult<>(pushNotificationRequest, "Notification is sent successfully"));
        } catch (Exception e) {
            log.error("ERROR OCCURED  : " + e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ErrorDataResult<>(pushNotificationRequest, "Notification is not sent. FAILED"));
    }
}
