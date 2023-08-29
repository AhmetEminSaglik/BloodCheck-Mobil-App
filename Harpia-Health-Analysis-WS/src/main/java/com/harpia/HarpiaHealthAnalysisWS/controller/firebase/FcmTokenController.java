package com.harpia.HarpiaHealthAnalysisWS.controller.firebase;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.FcmTokenService;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmToken;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/firebase/token")
public class FcmTokenController {
    @Autowired
    FcmTokenService service;
    private static CustomLog log = new CustomLog(FcmTokenController.class);

    @PostMapping
    public ResponseEntity<DataResult<FcmToken>> save(@RequestBody FcmToken newFcmToken) {
        FcmToken fcmToken = service.findByPatientId(newFcmToken.getPatientId());
        DataResult dataResult;
        if (fcmToken == null) {
            log.info("SAVE REQUEST TOKEN : " + newFcmToken);
            fcmToken = service.save(newFcmToken);
            String msg = "FcmToken is saved.";
            dataResult = new SuccessDataResult(fcmToken, msg);
        } else {
            fcmToken.setToken(newFcmToken.getToken());
            log.info("UPDATE REQUEST TOKEN : " + fcmToken);
            service.save(fcmToken);
            String msg = "FcmToken is updated.";
            dataResult = new SuccessDataResult(fcmToken, msg);

        }

        return ResponseEntity.status(HttpStatus.CREATED).body((dataResult));
    }

    @GetMapping("/patient/{id}")
    public ResponseEntity<DataResult<FcmToken>> findTokenByPatientId(@PathVariable long id) {
        FcmToken fcmToken = service.findByPatientId(id);
        String msg = "FcmToken is retrived by patient ID=" + id;
        DataResult dataResult = new SuccessDataResult(fcmToken, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

}
