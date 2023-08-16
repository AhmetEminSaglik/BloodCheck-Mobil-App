package com.harpia.HarpiaHealthAnalysisWS.controller.diabetic;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.bloodresult.BloodResultParseService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic.BloodResultService;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.exception.response.InvalidRequestedBloodResultDateException;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.StreamingHttpOutputMessage;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/bloodresults")
public class BloodResultController {
    @Autowired
    BloodResultService service;
    @Autowired
    BloodResultParseService parseService;

    @GetMapping
    public ResponseEntity<DataResult<BloodResult>> findAllBloodResult() {
        List<BloodResult> list = service.findAllPatientByOrderByIdDesc();
        String msg = "All Blood Results are retrived. Size : " + list.size() + '.';
        DataResult dataResult = new SuccessDataResult(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @PostMapping
    public ResponseEntity<DataResult<BloodResult>> saveBloodResult(@RequestBody BloodResult bloodResult) {
        bloodResult = service.save(bloodResult);
        String msg = "Blood Results is saved";
        DataResult dataResult = new SuccessDataResult(bloodResult, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}")
    public ResponseEntity<DataResult<BloodResult>> findPatientIdAllBloodResults(@PathVariable int patientId) {
        List<BloodResult> list = service.findAllBloodResultByPatientId(patientId);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrived. Size : " + list.size() + '.';
        DataResult dataResult = new SuccessDataResult(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/minutes/{min}")
    public ResponseEntity<DataResult<BloodResult>> findPatientIdBloodResultRequestedMinutes(@PathVariable int patientId, @PathVariable int min) {
        int sixMonth = 60 * 24 * 30 * 6;
        if (min > sixMonth) {
            throw new InvalidRequestedBloodResultDateException(min);
        }
        LocalDateTime time = LocalDateTime.now().minusMinutes(min);
        List<BloodResult> list = service.findAllByPatientIdAndCreatedAtAfter(patientId, time);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrived. Size : " + list.size() + '.';
        DataResult dataResult = new SuccessDataResult(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/sixmonth")
    public ResponseEntity<DataResult<List<BloodResult>>> findSixMonthBloodResultData(@PathVariable int patientId) {
        int sixMonth = 60 * 24 * 30 * 6;
        LocalDateTime time = LocalDateTime.now().minusMinutes(sixMonth);
        List<BloodResult> list = service.findAllByPatientIdAndCreatedAtAfter(patientId, time);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrived for 6 months data. Size of List is : " + list.size() + '.';
        DataResult dataResult = new SuccessDataResult(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/daily")
    public ResponseEntity<DataResult<List<BloodResult>>> retriveDailyData(@PathVariable int patientId) {
        List<BloodResult> bloodResultList = findSixMonthBloodResultData(patientId).getBody().getData();
        bloodResultList = parseService.parseToDaily(bloodResultList);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrived for DAILY data. Size of List is : " + bloodResultList.size() + '.';
        DataResult dataResult = new SuccessDataResult(bloodResultList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/weekly")
    public ResponseEntity<DataResult<List<BloodResult>>> retriveWeeklyData(@PathVariable int patientId) {
        List<BloodResult> bloodResultList = findSixMonthBloodResultData(patientId).getBody().getData();
        bloodResultList = parseService.parseToWeekly(bloodResultList);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrived for WEEKLY data. Size of List is : " + bloodResultList.size() + '.';
        DataResult dataResult = new SuccessDataResult(bloodResultList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/monthly")
    public ResponseEntity<DataResult<List<BloodResult>>> retriveMonthlyData(@PathVariable int patientId) {
        List<BloodResult> bloodResultList = findSixMonthBloodResultData(patientId).getBody().getData();
        bloodResultList = parseService.parseToMonthly(bloodResultList);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrived for MONTHLY data. Size of List is : " + bloodResultList.size() + '.';
        DataResult dataResult = new SuccessDataResult(bloodResultList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

}
