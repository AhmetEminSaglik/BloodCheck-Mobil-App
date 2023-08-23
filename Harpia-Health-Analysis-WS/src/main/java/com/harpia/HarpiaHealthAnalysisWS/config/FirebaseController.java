/*
package com.harpia.HarpiaHealthAnalysisWS.config;

import com.google.firebase.messaging.FirebaseMessagingException;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.signup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.controller.user.PatientController;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/send-notification")
public class FcmTokenController {
    private static CustomLog log = new CustomLog(FcmTokenController.class);

    @Autowired
    FirebaseMessagingService firebaseService;
    @Autowired
    PatientController patientController;

    @GetMapping
    public String sendNotification(*/
/*@RequestBody Note note,
            @RequestParam String token @RequestParam String token*//*
) throws FirebaseMessagingException {
//        Map<String,Patient> map = new HashMap<>();
//        map.put("patient",getPatient());
//        Note note = new Note();
//        note.setData(map);
//        note.setContent("Patient Content");
//        note.setSubject("Patient Subject");
//        note.setImage("https://fastly.picsum.photos/id/911/200/300.jpg?hmac=WJrS4QZru3pp2Z3K9wqapHxHCNFU-XPF2tY7gviRMoQ");
        log.info("Firebase geldi");
        Note note = new Note();
        note.setSubject("some subject");
        note.setContent("Some long content");
        note.setImage("https://fastly.picsum.photos/id/911/200/300.jpg?hmac=WJrS4QZru3pp2Z3K9wqapHxHCNFU-XPF2tY7gviRMoQ");
        Map<String, String> data = new HashMap();
        data.put("key1", "Value 1");
        data.put("key2", "Value 2");
        data.put("key3", "Value 3");
        data.put("key4", "Value 4");
        note.setData(data);
        String token = "Content-Type: application/json";
        return firebaseService.sendNotification(note, "cjsjLdw4RHCptIV8jsdJpt:APA91bFtDRt1bwpWEOF86srS9jnN_G8eR_N30kl73YTgiatGxCXAPZnHXLLCe_JGZbMq0gZRKR2B5wGLqRQ6Ew1kQbvPS61KqK04Ve92yD_UcBI6YtzV_50tVISV-MU203qlhcdKYbHr");
    }

    private Patient getPatient() {
        List<Patient> patientList = patientController.getPatientList().getBody().getData();
        return patientList.stream().findFirst().get();
    }
}
*/
