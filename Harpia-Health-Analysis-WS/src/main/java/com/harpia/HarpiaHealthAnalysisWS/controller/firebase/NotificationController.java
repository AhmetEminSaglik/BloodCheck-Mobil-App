package com.harpia.HarpiaHealthAnalysisWS.controller.firebase;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.FirebaseMessagingService;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.PushNotificationRequest;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/notification")
public class NotificationController {

    @Autowired
    FirebaseMessagingService firebaseMessagingService;

    @PostMapping
    ResponseEntity<DataResult<PushNotificationRequest>> sendNotificationByToken(@RequestBody PushNotificationRequest pushNotificationRequest) {
        return firebaseMessagingService.sendNotificationByToken(pushNotificationRequest);
    }
}
