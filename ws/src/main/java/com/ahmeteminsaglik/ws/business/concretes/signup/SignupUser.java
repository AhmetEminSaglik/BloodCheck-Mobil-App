package com.ahmeteminsaglik.ws.business.concretes.signup;

import com.ahmeteminsaglik.ws.business.abstracts.singup.SignupValidationService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.business.concretes.login.SignupCredentialsValidation;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.exception.ApiRequestException;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.Result;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class SignupUser {
    private static final Logger log = LoggerFactory.getLogger(SignupUser.class);
    private final UserService service;
    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Autowired
    public SignupUser(UserService service) {
        this.service = service;
    }

    public DataResult<User> signup(User user) {
        log.info("signup user process is started.");
        SignupValidationService signupService = new SignupCredentialsValidation(service);
        Result result = signupService.validateSingupCredentials(user.getUsername());
        log.info("Signup Validation Result : " + result.getMessage());
        if (!result.isSuccess()) {
            log.info(result.getMessage());
            log.info("ApiRequestException will be thrown.");
            throw new ApiRequestException(HttpStatus.CONFLICT, result.getMessage());
        }
        user.setPassword("{bcrypt}" + passwordEncoder.encode(user.getPassword()));
        user = service.save(user);
        DataResult<User> dataResult = new SuccessDataResult<>(user, user.getClass().getSimpleName() + " is created successfully.");
        log.info(dataResult.getMessage());
        return dataResult;
    }
}
