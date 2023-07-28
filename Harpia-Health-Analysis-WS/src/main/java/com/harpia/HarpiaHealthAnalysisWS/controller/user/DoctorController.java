package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/healthcare_personnels")
@CrossOrigin()
public class DoctorController {
    private static final Logger log = LoggerFactory.getLogger(DoctorController.class);
    @Autowired
    private UserService service;

    @PostMapping("/save")
    public ResponseEntity<DataResult<User>> saveHealthcarePersonnel(@RequestBody Doctor inputPersonel) {
        SignupUser signupUser = new SignupUser(service);
        DataResult<User> dataResult = signupUser.signup(inputPersonel);
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
    }

    @GetMapping("/{id}")
    public DataResult<Doctor> findById(@PathVariable long id) {
        Doctor personnel = (Doctor) service.findById(id);
        return new SuccessDataResult<>(personnel, "Healthcare Personnel retrived Succesfully");
    }
}
