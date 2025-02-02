package com.ahmeteminsaglik.ws.controller.user;

import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.token.FcmTokenService;
import com.ahmeteminsaglik.ws.business.abstracts.user.PatientService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.business.concretes.signup.SignupUser;
import com.ahmeteminsaglik.ws.controller.timer.PatientTimerController;
import com.ahmeteminsaglik.ws.model.JwtAuthResponse;
import com.ahmeteminsaglik.ws.model.dto.ModelMapper;
import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import com.ahmeteminsaglik.ws.model.firebase.FcmData;
import com.ahmeteminsaglik.ws.model.firebase.FcmMessage;
import com.ahmeteminsaglik.ws.model.firebase.FcmNotification;
import com.ahmeteminsaglik.ws.model.timer.PatientTimer;
import com.ahmeteminsaglik.ws.model.users.Doctor;
import com.ahmeteminsaglik.ws.model.users.Patient;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.JwtUtil;
import com.ahmeteminsaglik.ws.utility.exception.response.FailedSendNotificationToDoctorException;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/patients")
@CrossOrigin
public class PatientController {
    private static final Logger log = LoggerFactory.getLogger(PatientController.class);
    @Autowired
    private UserService userService;
    @Autowired
    private PatientService patientService;
    @Autowired
    FcmService fcmService;
    @Autowired
    FcmTokenService tokenService;
    @Autowired
    PatientTimerController timerController;
    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping()
    public ResponseEntity<DataResult<User>> savePatient(@RequestBody Patient patient) {
        log.info("POST > savePatient ");
        patient.setRoleId(EnumAuthority.ROLE_PATIENT.getId());
        SignupUser signupUser = new SignupUser(userService);
        DataResult<User> dataResult = signupUser.signup(patient);
        patient = (Patient) dataResult.getData();
        log.info("Patient is signup successfully.");
        saveDefaultPatientTimer(patient.getId());
        String token = "";
        try {
            token = tokenService.findByUserId(patient.getDoctorId()).getToken();
            log.info("Token : " + token);
            if (token != null) {
                FcmNotification fcmNotification = new FcmNotification();
                String msgTitle = "New Patient Is Assigned";
                String msgBody = patient.getName() + " " + patient.getLastname() + " is assigned to you.";
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
            log.error("Exception OCCURRED : " + e.getMessage());

            if (dataResult.isSuccess() && token.isEmpty()) {
                String msg = FailedSendNotificationToDoctorException.customErrorMsg + " " + dataResult.getMessage();
                dataResult = new SuccessDataResult<>(dataResult.getData(), msg);
            }
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    @GetMapping("/{id}")
    public ResponseEntity<DataResult<Patient>> findById(@PathVariable long id) {
        log.info("GET > findById ");
        log.info("(Param) Patient Id : " + id);
        Patient patient = (Patient) userService.findById(id);
        DataResult<Patient> dataResult = new SuccessDataResult<>(patient, "Patient is retrieved Successfully.");
        log.info(dataResult.getMessage());
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping
    public ResponseEntity<DataResult<List<Patient>>> getPatientList() {
        log.info("GET > getPatientList ");
        List<Patient> patientList = patientService.findAll();
        String msg = "All Patients are retrieved Successfully. (Size: " + patientList.size() + ")";
        log.info(msg);
        DataResult<List<Patient>> dataResult = new SuccessDataResult<>(patientList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @GetMapping("/{id}/doctors")
    public ResponseEntity<DataResult<Doctor>> findResponsibleDoctorByPatientId(@PathVariable long id) {
        log.info("GET > findResponsibleDoctorByPatientId ");
        log.info("(Param) Patient Id : " + id);
        DataResult<Doctor> result = null;
        try {
            Patient patient = patientService.findById(id);
            long doctorId = patient.getDoctorId();
            log.info("Found Doctor Id : " + doctorId + " of patient.");
            Doctor doctor = (Doctor) userService.findById(doctorId);
            String msg = "Doctor (" + doctor.getId() + ") who is responsible with patient ID(" + id + ") is retrieved.";
            log.info(msg);
            result = new SuccessDataResult<>(doctor, msg);
        } catch (Exception e) {
            log.error("EXCEPTION OCCURRED : " + e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @PutMapping()
    public ResponseEntity<DataResult<JwtAuthResponse>> updatePatient(@RequestBody Patient newUser) {
        log.info("PUT > updatePatient ");

        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        Patient existedUser = (Patient) userService.findById(newUser.getId());

        if(newUser.getUsername()!=null&&!newUser.getUsername().isEmpty()){
        existedUser.setUsername(newUser.getUsername());
        }
        if(newUser.getName()!=null&&!newUser.getName().isEmpty()){
        existedUser.setName(newUser.getName());
        }
        if(newUser.getLastname()!=null&&!newUser.getLastname().isEmpty()){
        existedUser.setLastname(newUser.getLastname());
        }
        if (newUser.getPassword() != null && !newUser.getPassword().isEmpty()) {
            existedUser.setPassword("{bcrypt}" + passwordEncoder.encode(newUser.getPassword()));
        }

        newUser = (Patient) userService.save(existedUser);
        String msg = "Patient is updated";

        JwtAuthResponse response = new JwtAuthResponse();
        response.setAccessToken(jwtUtil.generateToken(newUser.getUsername()));
        DataResult<JwtAuthResponse> dataResult = new SuccessDataResult<>(response, msg);
        response.setUserDto(ModelMapper.convertToPatientDto(newUser));
        response.getUserDto().setToken(response.getAccessToken());

        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    private void saveDefaultPatientTimer(long patientId) {
        log.info("saveDefaultPatientTimer process is started.");
        PatientTimer patientTimer = new PatientTimer();
        patientTimer.setPatientId(patientId);
        timerController.savePatientTimer(patientTimer);
    }
}
