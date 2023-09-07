package com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase.notification;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmNotificationService;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class FcmNotificationManager implements FcmNotificationService {
    private String fcmServerKey = "AAAAJPFxWhM:APA91bHwYHY3e-WIRWyF3TTmRiuO5SUtBAHyipnZ-iO5-CdnVdKhWHT0JwQU4jrSWZHV3HNjJlGXCvDHHlYzawPdywtBfADhH5KNMDN1L19BFQR1L6MwlJzyKUTdhw62iFlH-vIgceLU";
    private static CustomLog log = new CustomLog(FcmNotificationManager.class);

    public FcmNotificationManager() {
        log.info("fcmServerKey : " + fcmServerKey);
    }

    @Override
    public ResponseEntity<String> sendNotification(FcmMessage message/*@RequestBody FcmMessage fcmMessage*/) {

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "key=" + fcmServerKey);
        headers.set("Content-Type", "application/json");
        log.warn("KEY = " + fcmServerKey);

        HttpEntity<FcmMessage> entity = new HttpEntity<>(message, headers);

        ResponseEntity<String> response = restTemplate.postForEntity("https://fcm.googleapis.com/fcm/send", entity, String.class);

        log.info("Response : " + response);
        log.info(response.getStatusCode().toString());
        log.info(response.getBody());

        return response;
    }

}
