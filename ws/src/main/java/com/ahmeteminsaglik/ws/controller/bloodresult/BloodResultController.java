package com.ahmeteminsaglik.ws.controller.bloodresult;

import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultAssessmentService;
import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultParseService;
import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmService;
import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import com.ahmeteminsaglik.ws.utility.exception.response.InvalidRequestedBloodResultDateException;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
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
    @Autowired
    BloodResultParseService parseService;
    @Autowired
    BloodResultAssessmentService assessmentService;
    private static CustomLog log = new CustomLog(BloodResultController.class);
    @Autowired
    FcmService fcmService;

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
        String msg = "Blood Results is saved, Notification is send";
        assessmentService.assessToSendFcmMsg(bloodResult);
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
    public ResponseEntity<DataResult<List<BloodResult>>> findAllBloodResultByPatientIdRequestedMinutes(@PathVariable int patientId, @PathVariable int min) {
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
    public ResponseEntity<DataResult<List<BloodResult>>> retrieveDailyData(@PathVariable int patientId) {
        int oneDayTotalMinutes = 60 * 24;
        List<BloodResult> bloodResultList = findAllBloodResultByPatientIdRequestedMinutes(patientId, oneDayTotalMinutes).getBody().getData();
        bloodResultList = parseService.parseToDaily(bloodResultList);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrieved for DAILY data. Size of List is : " + bloodResultList.size() + '.';
        DataResult dataResult = new SuccessDataResult(bloodResultList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/weekly")
    public ResponseEntity<DataResult<List<BloodResult>>> retrieveWeeklyData(@PathVariable int patientId) {
        int oneWeekTotalMinutes = 60 * 24 * 7;
        List<BloodResult> bloodResultList = findAllBloodResultByPatientIdRequestedMinutes(patientId, oneWeekTotalMinutes).getBody().getData();
        bloodResultList = parseService.parseToWeekly(bloodResultList);

        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrieved for WEEKLY data. Size of List is : " + bloodResultList.size() + '.';
        DataResult dataResult = new SuccessDataResult(bloodResultList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/monthly")
    public ResponseEntity<DataResult<List<BloodResult>>> retrieveMonthlyData(@PathVariable int patientId) {
        int oneMonthTotalMinutes = 60 * 24 * 30;
        List<BloodResult> bloodResultList = findAllBloodResultByPatientIdRequestedMinutes(patientId, oneMonthTotalMinutes).getBody().getData();
        bloodResultList = parseService.parseToMonthly(bloodResultList);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrieved for MONTHLY data. Size of List is : " + bloodResultList.size() + '.';
        DataResult dataResult = new SuccessDataResult(bloodResultList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

}
