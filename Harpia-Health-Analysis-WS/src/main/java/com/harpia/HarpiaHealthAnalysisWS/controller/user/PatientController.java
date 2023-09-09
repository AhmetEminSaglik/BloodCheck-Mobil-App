package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.token.FcmTokenService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.PatientService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.signup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.exception.response.FailedSendNotificationToDoctorException;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/patients")
@CrossOrigin
public class PatientController {
    private static CustomLog log = new CustomLog(PatientController.class);
    @Autowired
    private UserService userService;
    @Autowired
    private PatientService patientService;
    @Autowired
    FcmService fcmService;
    @Autowired
    FcmTokenService tokenService;

    @PostMapping()
    public ResponseEntity<DataResult<User>> savePatient(@RequestBody Patient inputPatient) {
        inputPatient.setRoleId(EnumUserRole.PATIENT.getId());
        SignupUser signupUser = new SignupUser(userService);
        DataResult<User> dataResult = signupUser.signup(inputPatient);


        String token = "";
        try {
            token = tokenService.findByUserId(inputPatient.getDoctorId()).getToken();
            log.info("Token : " + token);
            if (token != null) {
                FcmNotification fcmNotification = new FcmNotification();
                String msgTitle = "New Patient Is Assigned";
                String msgBody = inputPatient.getName() + " " + inputPatient.getLastname() + " is assigned to you";
                fcmNotification.setBody(msgBody);
                fcmNotification.setTitle(msgTitle);

                FcmData data = new FcmData();
                data.setMsgTitle(msgTitle);
                data.setMsg(msgBody);

                FcmMessage fcmMessage = fcmService.generateFcmMsg(token, fcmNotification, data);
                fcmMessage.getData().setShowNotification(true);
                fcmService.sendNotification(fcmMessage);
                log.info(" FCM MESSAGE IS SEND : " + fcmMessage);
            }
        } catch (Exception e) {
            log.error("Exception Occured : " + e.getMessage());

            if (dataResult.isSuccess() && token.isEmpty()) {
                String msg = FailedSendNotificationToDoctorException.customErrorMsg + " " + dataResult.getMessage();
                dataResult = new SuccessDataResult<>(dataResult.getData(), msg);
            }
            log.info(" FCM GONDERILEMEDI ERROR OCCURED " + e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    @GetMapping("/{id}")
    public ResponseEntity<DataResult<Patient>> findById(@PathVariable long id) {
        Patient patient = (Patient) userService.findById(id);
        DataResult<Patient> dataResult = new SuccessDataResult<>(patient, "Patient retrived Succesfully");
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping
    public ResponseEntity<DataResult<List<Patient>>> getPatientList() {
        List<User> userList = userService.findAllByRoleId(EnumUserRole.PATIENT.getId());
        String msg = "PatientList is retrived successfully";
        DataResult result = new SuccessDataResult(userList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @GetMapping("/{id}/doctors")
    public ResponseEntity<DataResult<Doctor>> findResponsibleDoctorByPatientId(@PathVariable long id) {
//        List<Patient> patientList = patientService.findAllPatientByDoctorId(id);
        DataResult<Doctor> result = null;
        try {
            log.info("Given Patient Id : " + id);
            Patient patient = patientService.findById(id);
            long doctorId = patient.getDoctorId();
            log.info("Found Doctor Id : " + doctorId);
            Doctor doctor = (Doctor) userService.findById(doctorId);
            log.info("Found Doctor Data : " + doctor);
            String msg = "Doctor (" + doctor.getId() + ") who is responsible with patient ID(" + id + ") is retrieved";
            result = new SuccessDataResult(doctor, msg);
        } catch (Exception e) {
            log.error("EXCEPTION OCCURED : " + e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @PutMapping()
    public ResponseEntity<DataResult<Patient>> updatePatient(@RequestBody Patient patient) {
        log.info("Update Patient");
        patient = (Patient) userService.save(patient);
        String msg = "Patient is updated";
        DataResult<Patient> result = new SuccessDataResult(patient, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
}
