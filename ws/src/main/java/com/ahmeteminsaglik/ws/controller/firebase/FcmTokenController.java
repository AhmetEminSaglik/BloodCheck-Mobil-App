package com.ahmeteminsaglik.ws.controller.firebase;

import com.ahmeteminsaglik.ws.business.abstracts.firebase.token.FcmTokenService;
import com.ahmeteminsaglik.ws.model.firebase.FcmToken;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/firebase/token")
@CrossOrigin
public class FcmTokenController {
    private static final Logger log = LoggerFactory.getLogger(FcmTokenController.class);

    private final FcmTokenService service;

    @Autowired
    public FcmTokenController(FcmTokenService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<DataResult<FcmToken>> save(@RequestBody FcmToken newFcmToken) {
        log.info("POST > save ");
        log.info("(Param) fcmToken : " + newFcmToken);
        FcmToken fcmToken = service.findByUserIdAndToken(newFcmToken.getUserId(), newFcmToken.getToken());
        DataResult<FcmToken> dataResult;
        log.info("Found fcmToken : " );
        if (fcmToken == null || !fcmToken.equals(newFcmToken)) {
            fcmToken = service.save(newFcmToken);
            log.info("fcmToken is saved  : " );
            String msg = "FcmToken is saved.";
            dataResult = new SuccessDataResult<>(fcmToken, msg);
        } else {
            fcmToken.setToken(newFcmToken.getToken());
            service.save(fcmToken);
            log.info("fcmToken is updated  : " + newFcmToken);
            String msg = "FcmToken is updated.";
            dataResult = new SuccessDataResult<>(fcmToken, msg);
        }

        return ResponseEntity.status(HttpStatus.CREATED).body((dataResult));
    }

    @GetMapping("/user/{id}")
    public ResponseEntity<DataResult<FcmToken>> findTokenByUserId(@PathVariable long id) {
        log.info("GET > findTokenByUserId ");
        log.info("(Param) id: " + id);
        FcmToken fcmToken = service.findByUserId(id);
        String msg = "FcmToken is retrieved by patient ID=" + id;
        DataResult<FcmToken> dataResult = new SuccessDataResult<>(fcmToken, msg);
        log.info(msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @DeleteMapping
    public ResponseEntity<DataResult<FcmToken>> delete(@RequestBody FcmToken newFcmToken) {
        log.info("DELETE > delete ");
        log.info("(Param) newFcmToken: " + newFcmToken);
        FcmToken fcmToken = service.findByUserIdAndToken(newFcmToken.getUserId(), newFcmToken.getToken());
        String msg;
        if (fcmToken != null) {
            service.delete(fcmToken);
            msg = "FcmToken is deleted.";
        } else {
            msg = "Token is not found";
        }
        fcmToken = service.findByUserId(newFcmToken.getUserId());
        DataResult<FcmToken> dataResult = new SuccessDataResult<>(fcmToken, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }
}
