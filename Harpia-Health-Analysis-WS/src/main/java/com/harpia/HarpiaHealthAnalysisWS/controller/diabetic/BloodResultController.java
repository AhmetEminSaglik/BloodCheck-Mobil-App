package com.harpia.HarpiaHealthAnalysisWS.controller.diabetic;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic.BloodResultService;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/bloodresults")
public class BloodResultController {
    @Autowired
    BloodResultService service;

    @GetMapping
    public ResponseEntity<DataResult<BloodResult>> findAllBloodResult() {
        List<BloodResult> list = service.findAll();
        String msg = "All Blood Results are retrived";
        DataResult dataResult = new SuccessDataResult(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @PostMapping
    public ResponseEntity<DataResult<BloodResult>> saveBloodResult(BloodResult bloodResult) {
        bloodResult = service.save(bloodResult);
        String msg = "All Blood Results are retrived";
        DataResult dataResult = new SuccessDataResult(bloodResult, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }
    @GetMapping("/patient/{patientId}")
    public ResponseEntity<DataResult<BloodResult>> findPatientIdAllBloodResults(@PathVariable int patientId) {
        List<BloodResult> list = service.findAllBloodResultByPatientId(patientId);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrived";
        DataResult dataResult = new SuccessDataResult(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/minutes/{min}")
    public ResponseEntity<DataResult<BloodResult>> findPatientIdBloodResultRequestedMinutes(@PathVariable int patientId, @PathVariable int min) {
        LocalDateTime time = LocalDateTime.now().minusMinutes(min);
        List<BloodResult> list = service.findAllByPatientIdAndCreatedAtAfter(patientId, time);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrived";
        DataResult dataResult = new SuccessDataResult(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

}
