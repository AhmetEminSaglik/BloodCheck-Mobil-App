package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.PatientService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.xml.crypto.Data;
import java.util.List;

@RestController
@RequestMapping("/doctors")
@CrossOrigin()
public class DoctorController {
    private static final Logger log = LoggerFactory.getLogger(DoctorController.class);
    @Autowired
    private UserService userService;

    @Autowired
    private PatientService patientService;

    @PostMapping()
    public ResponseEntity<DataResult<User>> saveDoctor(@RequestBody Doctor inputPersonel) {
        SignupUser signupUser = new SignupUser(userService);
        DataResult<User> dataResult = signupUser.signup(inputPersonel);
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    @GetMapping
    public ResponseEntity<DataResult<List<User>>> findAllDoctorlist() {
        List<User> doctorList = userService.findAllByRoleId(EnumUserRole.DOCTOR.getId());
        String msg = "Doctor list is retrieved successfully";
        DataResult<List<User>> dataResult = new SuccessDataResult<>(doctorList, msg);
        return ResponseEntity.ok().body(dataResult);
    }


    @GetMapping("/{id}")

    public DataResult<Doctor> findById(@PathVariable long id) {
        Doctor personnel = (Doctor) userService.findById(id);
        return new SuccessDataResult<>(personnel, "Healthcare Personnel retrived Succesfully");
    }

    @GetMapping("/{id}/patients")
    public ResponseEntity<DataResult<List<Patient>>> findPatientListOfDoctorId(@PathVariable long id) {
        List<Patient> patientList = patientService.findAllPatientByDoctorId(id);
        String msg = "Patient List belongs to Doctor ID " + id + " is retrived";
        DataResult<List<Patient>> result = new SuccessDataResult(patientList, msg);
        return ResponseEntity.status(HttpStatus.OK).body(result);

    }
}
