package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupValidationService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.login.SignupCredentialsValidation;
import com.harpia.HarpiaHealthAnalysisWS.model.HealthcarePersonnel;
import com.harpia.HarpiaHealthAnalysisWS.model.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.exception.ApiRequestException;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.ErrorDataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/patients")
@CrossOrigin
public class PatientController {
    private static final Logger log = LoggerFactory.getLogger(PatientController.class);

    @Autowired
    private UserService service;

    @PostMapping("save")
    public ResponseEntity<DataResult<User>> savePatient(@RequestBody Patient inputPatient) {
        SignupUser signupUser = new SignupUser(service);
        DataResult<User> dataResult = signupUser.signup(inputPatient);
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    @GetMapping("/{id}")
    public DataResult<Patient> findById(@PathVariable long id) {
        Patient patient = (Patient) service.findById(id);
        return new SuccessDataResult<>(patient, "Patient retrived Succesfully");
    }
}
