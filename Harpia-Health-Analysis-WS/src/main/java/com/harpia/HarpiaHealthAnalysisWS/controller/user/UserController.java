package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.login.LoginValidationService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.login.LoginCredentialsValidation;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.user.UserRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.LoginCredentials;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {
    private static CustomLog log = new CustomLog(UserController.class);
    @Autowired
    private UserService service;


    @GetMapping()
    public ResponseEntity<DataResult<List<User>>> findAllUserList() {
        DataResult<List<User>> dataResult = new SuccessDataResult<>(service.findAll(), "All users retrived successfully");
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);
    }

    @Autowired
    UserRepository repository;

    @GetMapping("/time/minutes/{min}")
    public ResponseEntity<DataResult<List<User>>> findByLastCreatedMinusMinutes(@PathVariable int min) {
        LocalDateTime localDateTime = LocalDateTime.now().minusMinutes(min);
        DataResult<List<User>> dataResult = new SuccessDataResult<>(repository.findAllByCreatedAtAfter(localDateTime));
        return ResponseEntity.status(HttpStatus.OK).body(dataResult);

    }

    @GetMapping("/{id}")
    public DataResult<User> findById(@PathVariable long id) {
        User user = service.findById(id);
        return new SuccessDataResult<>(user, "User retrived Succesfully");
    }

    @PostMapping("/login")
    public ResponseEntity<DataResult<User>> login(@RequestBody LoginCredentials loginCreds) {
        LoginValidationService loginService = new LoginCredentialsValidation(service);
//        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//        loginCreds.setPassword(passwordEncoder.encode(loginCreds.getPassword()));
//        Base64.getDecoder().decode(loginCreds.getPassword());
//        List<User> userList=service.findAll();
//        passwordEncoder.matches()
        DataResult<User> result = loginService.validateLoginCredentials(loginCreds.getUsername(), loginCreds.getPassword());
        System.out.println(result.getData().getId().getClass().getSimpleName());
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

}

