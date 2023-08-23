package com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.FcmService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.signup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class FcmManager implements FcmService {
    @Value("${fcm.server.key}")
    private String fcmServerKey;
    private static CustomLog log = new CustomLog(FcmManager.class);

    @Override
    public ResponseEntity<String> sendFcmNotification(FcmMessage message/*@RequestBody FcmMessage fcmMessage*/) {

        log.info("GELDI ");
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "key=" + fcmServerKey);
        headers.set("Content-Type", "application/json");

        HttpEntity<FcmMessage> entity = new HttpEntity<>(message, headers);

        ResponseEntity<String> response = restTemplate.postForEntity("https://fcm.googleapis.com/fcm/send", entity, String.class);

        log.info("Response : "+response);
        log.info(response.getStatusCode().toString());
        log.info(response.getBody());

        return response;
    }
}
