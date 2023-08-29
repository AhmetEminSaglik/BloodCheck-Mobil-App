package com.harpia.HarpiaHealthAnalysisWS.controller.timer;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.timer.PatientTimerService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.signup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
//@RequestMapping("/timers/doctors/patients")
@RequestMapping("/timers")
@CrossOrigin
public class PatientTimerController {
    private static CustomLog log = new CustomLog(PatientTimerController.class);

    @Autowired
    PatientTimerService service;

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
        }
        DataResult result = new SuccessDataResult(newPatientTimer, msg);
        log.info("RESULT : " + result);
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
}
