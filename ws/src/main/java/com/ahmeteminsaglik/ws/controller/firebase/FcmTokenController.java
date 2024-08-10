package com.ahmeteminsaglik.ws.controller.firebase;

import com.ahmeteminsaglik.ws.business.abstracts.firebase.token.FcmTokenService;
import com.ahmeteminsaglik.ws.model.firebase.FcmMessage;
import com.ahmeteminsaglik.ws.model.firebase.FcmToken;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
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
        FcmToken fcmToken = service.findByUserId(newFcmToken.getUserId());
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
        FcmToken fcmToken = service.findByUserId(id);
        String msg = "FcmToken is retrived by patient ID=" + id;
        DataResult dataResult = new SuccessDataResult(fcmToken, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

//    @PostMapping()
//    public  ResponseEntity<DataResult<FcmMessage>> sendFcmMessage(@RequestBody FcmMessage fcmMessage,@RequestParam long patientId){
//
//    }


}
