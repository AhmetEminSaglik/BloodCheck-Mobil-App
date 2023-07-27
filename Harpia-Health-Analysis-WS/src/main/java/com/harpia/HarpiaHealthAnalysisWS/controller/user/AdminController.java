package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Admin;
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
@RequestMapping("/admins")
@CrossOrigin
public class AdminController {
    protected static final Logger log = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private UserService service;

    @PostMapping("/save")
    public ResponseEntity<DataResult<User>> saveAdmin(@RequestBody Admin inputAdmin) {
        SignupUser signupUser = new SignupUser(service);
        DataResult<User> dataResult = signupUser.signup(inputAdmin);
        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
//        Admin admin = (Admin) service.save(inputAdmin);
//        return new SuccessDataResult<>(admin, "Admin Saved Successfuly");
    }

    @GetMapping("/{id}")
    public DataResult<Admin> findById(@PathVariable long id) {
        Admin admin = (Admin) service.findById(id);
        return new SuccessDataResult<>(admin, "Admin retrived Succesfully");
    }
}
