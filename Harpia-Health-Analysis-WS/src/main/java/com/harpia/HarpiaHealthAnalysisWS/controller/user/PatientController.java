package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.PatientService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.signup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

    @PostMapping()
    public ResponseEntity<DataResult<User>> savePatient(@RequestBody Patient inputPatient) {
        inputPatient.setRoleId(EnumUserRole.PATIENT.getId());
        SignupUser signupUser = new SignupUser(userService);
        DataResult<User> dataResult = signupUser.signup(inputPatient);
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    @GetMapping("/{id}")
    public DataResult<Patient> findById(@PathVariable long id) {
        Patient patient = (Patient) userService.findById(id);
        return new SuccessDataResult<>(patient, "Patient retrived Succesfully");
    }

    @GetMapping
    public ResponseEntity<DataResult<List<Patient>>> getPatientList() {
        List<User> userList = userService.findAllByRoleId(EnumUserRole.PATIENT.getId());
        String msg = "PatientList is retrived successfully";
        DataResult result = new SuccessDataResult(userList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    @GetMapping("/{id}/doctors")
    public ResponseEntity<DataResult<List<Patient>>> findDoctorByPatientId(@PathVariable long id) {
//        List<Patient> patientList = patientService.findAllPatientByDoctorId(id);

        log.info("Given Patient Id : " + id);
        Patient patient = patientService.findById(id);
        long doctorId = patient.getDoctorId();
        log.info("Found Doctor Id : " + doctorId);
        String msg = "Doctor (" + doctorId + ") who is responsible with patient ID(" + id + ") is retrieved";
        DataResult<List<Patient>> result = new SuccessDataResult(doctorId, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
}
