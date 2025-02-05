package com.ahmeteminsaglik.ws.controller.timer;

import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmService;
import com.ahmeteminsaglik.ws.business.abstracts.timer.PatientTimerService;
import com.ahmeteminsaglik.ws.controller.firebase.FcmTokenController;
import com.ahmeteminsaglik.ws.model.enums.EnumFcmMessageReason;
import com.ahmeteminsaglik.ws.model.firebase.FcmData;
import com.ahmeteminsaglik.ws.model.firebase.FcmMessage;
import com.ahmeteminsaglik.ws.model.firebase.FcmNotification;
import com.ahmeteminsaglik.ws.model.timer.PatientTimer;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/timers")
@CrossOrigin
public class PatientTimerController {
    private static final Logger log = LoggerFactory.getLogger(PatientTimerController.class);

    //    @Autowired
    private final PatientTimerService service;
    //    @Autowired
//    FcmTokenService fcmTokenService;
//    @Autowired
    private final FcmTokenController fcmTokenController;
    //    @Autowired
    private final FcmService fcmService;

    @Autowired
    public PatientTimerController(PatientTimerService service, FcmTokenController fcmTokenController, FcmService fcmService) {
        this.service = service;
        this.fcmTokenController = fcmTokenController;
        this.fcmService = fcmService;
    }

    @PostMapping()
    public ResponseEntity<DataResult<PatientTimer>> savePatientTimer(@RequestBody PatientTimer patientTimer) {
        log.info("POST > savePatientTimer ");
        log.info("(Param) patientTimer: " + patientTimer);
        PatientTimer newPatientTimer = service.findByPatientId(patientTimer.getPatientId());
        log.info("Found patientTimer: " + newPatientTimer);
        String msg;
        DataResult<PatientTimer> dataResult;
        if (newPatientTimer == null) {
            newPatientTimer = service.save(patientTimer);
            msg = "Patient Timer is created.";
            dataResult = new SuccessDataResult<>(newPatientTimer, msg);
            log.info(dataResult.getMessage());
            return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
        } else {
            msg = "PatientTimer is not created. Because patient has already a patientTimer.";
            dataResult = new SuccessDataResult<>(null, msg);
            log.info(dataResult.getMessage());
            return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
        }
    }

    @PutMapping()
    public ResponseEntity<DataResult<PatientTimer>> updatePatientTimer(@RequestBody PatientTimer patientTimer) {
        log.info("PUT > updatePatientTimer ");
        log.info("(Param) patientTimer: " + patientTimer);
        PatientTimer newPatientTimer = service.findByPatientId(patientTimer.getPatientId());

        service.update(patientTimer);
        String msg = "Patient Timer is updated";
        sendFcmMessage(patientTimer.getPatientId());

        DataResult<PatientTimer> result = new SuccessDataResult<>(newPatientTimer, msg);
        log.info(msg);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @GetMapping("/patients/{id}")
    public ResponseEntity<DataResult<PatientTimer>> findPatientTimerByPatientId(@PathVariable long id) {
        log.info("PUT > findPatientTimerByPatientId ");
        log.info("(Param) id: " + id);
        PatientTimer timer = service.findByPatientId(id);
        String msg = "PatientTimer belongs to Patient ID " + id + " is retrieved.";
        DataResult<PatientTimer> result = new SuccessDataResult<>(timer, msg);
        log.info(msg);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @GetMapping
    public ResponseEntity<DataResult<List<PatientTimer>>> findAllPatientTimers() {
        log.info("PUT > findAllPatientTimers ");
        List<PatientTimer> list = service.findAll();
        String msg = "All patientTimers are retrieved (Size:" + list.size() + ").";
        DataResult<List<PatientTimer>> result = new SuccessDataResult<>(list, msg);
        log.info(msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    private void sendFcmMessage(long patientId) {
        log.info("> sendFcmMessage ");
        log.info("(Param) id: " + patientId);

        String msgTitle = "Updated Notification";
        String msgBody = "Patient Timer is Updated";
        log.info("patient Timer > sendFcmMessage ");
        FcmNotification notification = createNotification(msgTitle, msgBody);
        FcmData data = createData(msgTitle, msgBody, patientId, false);
        FcmMessage fcmMessage = createFcmMessage(patientId, notification, data);
        fcmService.sendNotification(fcmMessage);
        log.info("FcmMessage is send.");
  /*      try {
            FcmMessage fcmMessage = createFcmMessage(patientId, notification, data);
        fcmService.sendNotification(fcmMessage);
        }catch ( Exception e){
            log.error("Exception OCCURRED : "+e.getMessage());
        }*/

    }

    private FcmNotification createNotification(String msgTitle, String msgBody) {
        log.info("Notification will be created.");
        FcmNotification notification = new FcmNotification();
        notification.setTitle(msgTitle);
        notification.setBody(msgBody);
        log.info("Notification is created: " + notification);
        return notification;
    }

    private FcmData createData(String msgTitle, String msgBody, long patientId, boolean showNotification) {
        FcmData data = new FcmData();
        log.info("FcmData will be created.");
        data.setPatientId(patientId);
        data.setShowNotification(showNotification);
        data.setReasonSend(EnumFcmMessageReason.UPDATE_SENSOR_TIMER.getReason());
        data.setReasonCode(EnumFcmMessageReason.UPDATE_SENSOR_TIMER.getCode());
        data.setMsgTitle(msgTitle);
        data.setMsg(msgBody);
        log.info("FcmData is created.");
        return data;
    }

    private FcmMessage createFcmMessage(long patientId, FcmNotification notification, FcmData data) {
//        log.info("patient Timer > sendFcmMessage  > createFcmMessage Patient Id : " + patientId);
        FcmMessage fcmMessage = new FcmMessage();

//        fcmTokenController.
//        log.info(" TOKEN : Alicak " + fcmTokenService.findByUserId(patientId).getToken());
//        log.info(" fcmTokenService  " + fcmTokenService);
//        String token = fcmTokenService.findByUserId(patientId).getToken();
        log.info("FcmMessage will be created.");
        String token = Objects.requireNonNull(fcmTokenController.findTokenByUserId(patientId).getBody()).getData().getToken();
        fcmMessage.setTo(token);
        fcmMessage.setNotification(notification);
        fcmMessage.setData(data);
        log.info("FcmMessage is be created.");
        return fcmMessage;
    }
}
