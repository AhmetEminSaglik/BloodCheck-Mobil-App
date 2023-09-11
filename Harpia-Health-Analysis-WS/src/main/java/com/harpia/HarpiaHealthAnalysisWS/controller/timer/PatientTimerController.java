package com.harpia.HarpiaHealthAnalysisWS.controller.timer;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmNotificationService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.token.FcmTokenService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.timer.PatientTimerService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase.notification.FcmManager;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/timers")
@CrossOrigin
public class PatientTimerController {
    private static CustomLog log = new CustomLog(PatientTimerController.class);

    @Autowired
    PatientTimerService service;
    @Autowired
    FcmTokenService fcmTokenService;
    @Autowired
    FcmService fcmService;

    @PostMapping()
    public ResponseEntity<DataResult<PatientTimer>> savePatientTimer(@RequestBody PatientTimer patientTimer) {
        PatientTimer newPatientTimer = service.findByPatientId(patientTimer.getPatientId());
        String msg;
        if (newPatientTimer == null) {
            newPatientTimer = service.save(patientTimer);
            msg = "Patient Timer is created";
        } else {
            newPatientTimer.setHours(patientTimer.getHours());
            newPatientTimer.setMinutes(patientTimer.getMinutes());
            newPatientTimer = service.save(newPatientTimer);
            msg = "Patient Timer is updated";
            sendFcmMessage(patientTimer.getPatientId());
        }
        DataResult result = new SuccessDataResult(newPatientTimer, msg);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @GetMapping("/patients/{id}")
    public ResponseEntity<DataResult<PatientTimer>> findPatientTimerByPatientId(@PathVariable long id) {
        PatientTimer timer = service.findByPatientId(id);
        String msg = "PatientTimer belongs to Patient ID " + id + " is retrived";
        DataResult result = new SuccessDataResult(timer, msg);
        return ResponseEntity.status(HttpStatus.CREATED).body(result);
    }

    @GetMapping
    public ResponseEntity<DataResult<List<PatientTimer>>> findAllPatientTimers() {
        List<PatientTimer> list = service.findAll();
        String msg = "All patientTimers are retrived";
        DataResult result = new SuccessDataResult(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    private void sendFcmMessage(long patientId) {
        String msgTitle = "Updated Notification";
        String msgBody = "Patient Timer is Updated";

        FcmNotification notification = createNotification(msgTitle, msgBody);
        FcmData data = createData(msgTitle, msgBody, patientId, true);
        FcmMessage fcmMessage = createFcmMessage(patientId, notification, data);

        fcmService.sendNotification(fcmMessage);
    }

    private FcmNotification createNotification(String msgTitle, String msgBody) {
        FcmNotification notification = new FcmNotification();
        notification.setTitle(msgTitle);
        notification.setBody(msgBody);
        return notification;
    }

    private FcmData createData(String msgTitle, String msgBody, long patientId, boolean showNotification) {
        FcmData data = new FcmData();
        data.setPatientId(patientId);
        data.setShowNotification(showNotification);
        data.setMsgTitle(msgTitle);
        data.setMsg(msgBody);
        return data;
    }

    private FcmMessage createFcmMessage(long patientId, FcmNotification notification, FcmData data) {
        FcmMessage fcmMessage = new FcmMessage();
        fcmMessage.setTo(fcmTokenService.findByUserId(patientId).getToken());
        fcmMessage.setNotification(notification);
        fcmMessage.setData(data);
        return fcmMessage;
    }
}
