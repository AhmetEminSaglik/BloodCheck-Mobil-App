/*
package com.harpia.HarpiaHealthAnalysisWS.controller.firebase;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

//@RestController
//@RequestMapping("/fcm")
public class FcmController {

    @Value("${fcm.server.key}")
    private String fcmServerKey;


//    @GetMapping("/send")
    public ResponseEntity<String> sendFcmNotification(FcmMessage message*/
/*@RequestBody FcmMessage fcmMessage*//*
) {

//        FcmData fcmData = new FcmData();
//        fcmData.setDl("DL data is set in Spring Boot");
//        fcmData.setUrl("URL data is set in Spring Boot");

//        FcmNotification fcmNotification = new FcmNotification();
//        fcmNotification.setBody("HERE IS BODY");
//        fcmNotification.setTitle("HERE IS TITLE");

//        FcmMessage fcmMessage = new FcmMessage();
//        fcmMessage.setToken("fICNe8hdRs-rNQXANmxOww:APA91bE9pFBPkdYHFqe6z1BIu5CQMH1gKxp_N1AC9qhoahhjdJ3ViY7aAfBD-6XWWT24eW-wG9rajRQPN57RK5MRASVhErirQQ2gT_tVYv4mrdwbvC-M1ChqFS2JVIyfBTtIVUmPhlyo");
//        fcmMessage.setNotification(fcmNotification);
//        fcmMessage.setData(fcmData);
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "key=" + fcmServerKey);
        headers.set("Content-Type", "application/json");

        HttpEntity<FcmMessage> entity = new HttpEntity<>(message, headers);

        ResponseEntity<String> response = restTemplate.postForEntity("https://fcm.googleapis.com/fcm/send", entity, String.class);

        return response;
    }

}
*/
