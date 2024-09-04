package com.ahmeteminsaglik.ws.controller.bloodresult;

import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultAssessmentService;
import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultParseService;
import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmService;
import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;
import com.ahmeteminsaglik.ws.model.bloodresult.BloodResultBound;
import com.ahmeteminsaglik.ws.model.bloodresult.ItemRangeValue;
import com.ahmeteminsaglik.ws.utility.CustomUTCTime;
import com.ahmeteminsaglik.ws.utility.exception.response.InvalidRequestedBloodResultDateException;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/bloodresults")
@CrossOrigin
public class BloodResultController {
    private static final Logger log = LoggerFactory.getLogger(BloodResultController.class);

    @Autowired
    BloodResultService service;
    @Autowired
    BloodResultParseService parseService;
    @Autowired
    BloodResultAssessmentService assessmentService;
    @Autowired
    FcmService fcmService;

    @GetMapping
    public ResponseEntity<DataResult<List<BloodResult>>> findAllBloodResult() {
        log.info("GET > findAllBloodResult");
        List<BloodResult> list = service.findAllPatientByOrderByIdDesc();
        log.info("Retrieved BloodResults list size : " + list.size());
        String msg = "All Blood Results are retrieved. Size : " + list.size() + '.';
        DataResult<List<BloodResult>> dataResult = new SuccessDataResult<>(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @PostMapping
    public ResponseEntity<DataResult<BloodResult>> saveBloodResult(@RequestBody BloodResult bloodResult) {
        log.info("POST > saveBloodResult");
        log.info("(Param) Blood Result data : bloodResult");
        bloodResult = service.save(bloodResult);
        String msg = "Blood Results is saved, Notification is send";
        assessmentService.assessToSendFcmMsg(bloodResult);
        log.info(msg);
        DataResult<BloodResult> dataResult = new SuccessDataResult<>(bloodResult, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}")
    public ResponseEntity<DataResult<List<BloodResult>>> findPatientIdAllBloodResults(@PathVariable int patientId) {
        log.info("GET > saveBloodResult");
        log.info("(Param) Patient Id : " + patientId);
        List<BloodResult> list = service.findAllBloodResultByPatientId(patientId);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrieved. Size : " + list.size() + '.';
        log.info(msg);
        DataResult<List<BloodResult>> dataResult = new SuccessDataResult<>(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/minutes/{min}")
    public ResponseEntity<DataResult<List<BloodResult>>> findAllBloodResultByPatientIdRequestedMinutes(@PathVariable int patientId, @PathVariable int min) {
        log.info("GET > findAllBloodResultByPatientIdRequestedMinutes");
        log.info("(Param) Patient Id : " + patientId + " | min :" + min);
        int sixMonth = 60 * 24 * 30 * 6;
        if (min > sixMonth) {
            throw new InvalidRequestedBloodResultDateException(min);
        }
//        LocalDateTime time = CustomUTCTime.getUTCTime().minusMinutes(min);
        LocalDateTime time = CustomUTCTime.getUTCTime().minusMinutes(min);
        List<BloodResult> list = service.findAllByPatientIdAndCreatedAtAfter(patientId, time);
//        LocalDateTime tenDaysAgo = now.minusDays(10);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrieved. Size : " + list.size() + '.';
        log.info(msg);
        DataResult<List<BloodResult>> dataResult = new SuccessDataResult<>(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/sixmonth")
    public ResponseEntity<DataResult<List<BloodResult>>> findSixMonthBloodResultData(@PathVariable int patientId) {
        log.info("GET > findSixMonthBloodResultData");
        log.info("(Param) Patient Id : " + patientId);
        int sixMonth = 60 * 24 * 30 * 6;
        LocalDateTime time = CustomUTCTime.getUTCTime().minusMinutes(sixMonth);
        List<BloodResult> list = service.findAllByPatientIdAndCreatedAtAfter(patientId, time);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrieved for 6 months data. Size of List is : " + list.size() + '.';
        log.info(msg);
        DataResult<List<BloodResult>> dataResult = new SuccessDataResult<>(list, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/daily")
    public ResponseEntity<DataResult<List<BloodResult>>> retrieveDailyData(@PathVariable int patientId) {
        log.info("GET > retrieveDailyData");
        log.info("(Param) Patient Id : " + patientId);
        int oneDayTotalMinutes = 60 * 24;
        List<BloodResult> bloodResultList = findAllBloodResultByPatientIdRequestedMinutes(patientId, oneDayTotalMinutes).getBody().getData();
        bloodResultList = parseService.parseToDaily(bloodResultList);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrieved for DAILY data. Size of List is : " + bloodResultList.size() + '.';
        System.out.println("donecek bloodresult data :");
        for (BloodResult bloodResult : bloodResultList) {
            System.out.println(bloodResult);
        }
        log.info(msg);
        DataResult<List<BloodResult>> dataResult = new SuccessDataResult<>(bloodResultList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/weekly")
    public ResponseEntity<DataResult<List<BloodResult>>> retrieveWeeklyData(@PathVariable int patientId) {
        log.info("GET > retrieveWeeklyData");
        log.info("(Param) Patient Id : " + patientId);
        int oneWeekTotalMinutes = 60 * 24 * 7;
        List<BloodResult> bloodResultList = findAllBloodResultByPatientIdRequestedMinutes(patientId, oneWeekTotalMinutes).getBody().getData();
        bloodResultList = parseService.parseToWeekly(bloodResultList);

        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrieved for WEEKLY data. Size of List is : " + bloodResultList.size() + '.';
        DataResult<List<BloodResult>> dataResult = new SuccessDataResult<>(bloodResultList, msg);
        log.info(msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/patient/{patientId}/monthly")
    public ResponseEntity<DataResult<List<BloodResult>>> retrieveMonthlyData(@PathVariable int patientId) {
        log.info("GET > retrieveMonthlyData");
        log.info("(Param) Patient Id : " + patientId);
        int oneMonthTotalMinutes = 60 * 24 * 30;
        List<BloodResult> bloodResultList = findAllBloodResultByPatientIdRequestedMinutes(patientId, oneMonthTotalMinutes).getBody().getData();
        bloodResultList = parseService.parseToMonthly(bloodResultList);
        String msg = "BloodResult List belongs to Patient ID " + patientId + " is retrieved for MONTHLY data. Size of List is : " + bloodResultList.size() + '.';
        DataResult<List<BloodResult>> dataResult = new SuccessDataResult<>(bloodResultList, msg);
        log.info(msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/bounds")
    public ResponseEntity<DataResult<Map<String, ItemRangeValue>>> getBloodResultAssessmentValue() {
        BloodResultBound bounds = new BloodResultBound();
        DataResult<Map<String, ItemRangeValue>> dataResult = new SuccessDataResult<>(bounds.getRangeMap());
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

}
