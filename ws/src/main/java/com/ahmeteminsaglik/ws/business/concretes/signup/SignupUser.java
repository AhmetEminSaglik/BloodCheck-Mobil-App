package com.ahmeteminsaglik.ws.business.concretes.signup;

import com.ahmeteminsaglik.ws.business.abstracts.singup.SignupValidationService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.business.concretes.login.SignupCredentialsValidation;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import com.ahmeteminsaglik.ws.utility.exception.ApiRequestException;
import com.ahmeteminsaglik.ws.utility.result.DataResult;
import com.ahmeteminsaglik.ws.utility.result.Result;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import org.springframework.http.HttpStatus;

public class SignupUser {
    private static CustomLog log = new CustomLog(SignupUser.class);
    private final UserService service;

    public SignupUser(UserService service) {
        this.service = service;
    }

    public DataResult<User> signup(User user) {
        SignupValidationService signupService = new SignupCredentialsValidation(service);
        Result result = signupService.validateSingupCredentials(user.getUsername());
        log.info("Signup Validation Result : " + result.getMessage());
        if (!result.isSuccess()) {
            throw new ApiRequestException(HttpStatus.CONFLICT, result.getMessage());
        }
        user = service.save(user);
        return new SuccessDataResult<>(user, user.getClass().getSimpleName() + " is created sucessfully.");
    }
}
