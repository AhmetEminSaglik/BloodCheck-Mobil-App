package com.harpia.HarpiaHealthAnalysisWS.controller.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.login.LoginValidationService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.login.LoginCredentialsValidation;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.user.UserRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.LoginCredentials;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/users")
@CrossOrigin(origins = "http://localhost:8080")
public class UserController {
    private static CustomLog log = new CustomLog(UserController.class);
    @Autowired
    private UserService service;

    @GetMapping()
    public DataResult<List<User>> findAllUserList() {
        return new SuccessDataResult<>(service.findAll(), "All users retrived successfully");
    }

    @Autowired
    UserRepository repository;

    @GetMapping("/time/minutes/{min}")
    public DataResult<List<User>> findByLastCreatedMinusMinutes(@PathVariable int min) {
        LocalDateTime localDateTime = LocalDateTime.now().minusMinutes(min);
        return new SuccessDataResult<>(repository.findAllByCreatedAtAfter(localDateTime));
    }

    @GetMapping("/{id}")
    public DataResult<User> findById(@PathVariable long id) {
        User user = service.findById(id);
        return new SuccessDataResult<>(user, "User retrived Succesfully");
    }

    public User saveUser(User user) {
        user = service.save(user);
        return user;
    }

    @PostMapping("/login")
    public DataResult<User> login(@RequestBody LoginCredentials loginCreds) {
        LoginValidationService loginService = new LoginCredentialsValidation(service);
//        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//        loginCreds.setPassword(passwordEncoder.encode(loginCreds.getPassword()));
//        Base64.getDecoder().decode(loginCreds.getPassword());
//        List<User> userList=service.findAll();
//        passwordEncoder.matches()
        DataResult<User> result = loginService.validateLoginCredentials(loginCreds.getUsername(), loginCreds.getPassword());
        System.out.println(result.getData().getId().getClass().getSimpleName());
        return result;
    }

}

