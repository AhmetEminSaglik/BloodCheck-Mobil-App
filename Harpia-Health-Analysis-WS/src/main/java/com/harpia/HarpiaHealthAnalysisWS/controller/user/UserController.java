package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.login.LoginValidationService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupValidationService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.login.LoginCredentialsValidation;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.login.SignupCredentialsValidation;
import com.harpia.HarpiaHealthAnalysisWS.model.HealthcarePersonnel;
import com.harpia.HarpiaHealthAnalysisWS.model.LoginCredentials;
import com.harpia.HarpiaHealthAnalysisWS.model.User;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserService;
import com.harpia.HarpiaHealthAnalysisWS.model.UserRole;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import com.harpia.HarpiaHealthAnalysisWS.utility.exception.ApiRequestException;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/users")
@CrossOrigin(origins = "http://localhost:8080")
public class UserController {
    private static final Logger log = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService service;
    @Autowired
    private UserRoleService roleService;


    @GetMapping()
    public DataResult<List<User>> findAllUserList() {
        return new SuccessDataResult<>(service.findAll(), "All users retrived successfully");
    }

//    @PostMapping("/save")
//    public ResponseEntity<DataResult<User>> saveHealthcarePersonnel(@RequestBody User user) {
//        log.info("user : "+user);
//        log.info("user name  : "+user.getClass().getName());
//        SignupUser signupUser = new SignupUser(service);
//        DataResult<User> dataResult = signupUser.signup(user);
//        return ResponseEntity.status(HttpStatus.CREATED).body(dataResult);
//
////        HealthcarePersonnel personel = (HealthcarePersonnel) service.save(inputPersonel);
////        log.info("Healthcare Personnel is saved : ", personel);
////        return new SuccessDataResult<>(personel, "Healthcare Personnel is saved");
//    }

    @GetMapping("/{id}")
    public DataResult<User> findById(@PathVariable long id) {
        User user = service.findById(id);
        return new SuccessDataResult<>(user, "User retrived Succesfully");
    }

    @GetMapping("/roleid/{id}")
    public DataResult<List<User>> findByRoleId(@PathVariable int id) {
        List<User> userList = service.findAllByRoleId(id);

        System.out.println("----------------------------------");
        UserRole role = roleService.findById(id);
        String msg;
        if (role == null) {
            return new SuccessDataResult<>("Unknown User type is requested");
        }
        if (userList.isEmpty()) {
            msg = "Found no one in " + role.getRole() + " user type";
        } else {
            msg = role.getRole() + " list is retrived";
        }
        return new SuccessDataResult<>(userList, msg);
    }

    @PostMapping("/login")
    public DataResult<User> login(@RequestBody LoginCredentials loginCreds) {
        LoginValidationService loginService = new LoginCredentialsValidation(service);
        DataResult<User> result = loginService.validateLoginCredentials(loginCreds.getUsername(), loginCreds.getPassword());
        return result;
    }

    /*@PostMapping("/signup")
    public DataResult<User> signup(@RequestBody LoginCredentials loginCreds) {
        SignupValidationService signupService = new SignupCredentialsValidation(service);
        Result result = signupService.validateSingupCredentials(loginCreds.getUsername());
        if(!result.isSuccess()){
            throw new ApiRequestException(HttpStatus.CONFLICT, "Please change username");
        }
        DataResult<User> result = loginService.validateLoginCredentials(loginCreds.getUsername(), loginCreds.getPassword());
        return result;
    }*/
}

