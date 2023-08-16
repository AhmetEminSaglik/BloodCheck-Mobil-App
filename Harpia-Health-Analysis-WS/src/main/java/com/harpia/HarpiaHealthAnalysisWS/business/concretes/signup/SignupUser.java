package com.harpia.HarpiaHealthAnalysisWS.business.concretes.signup;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupValidationService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.login.SignupCredentialsValidation;
import com.harpia.HarpiaHealthAnalysisWS.controller.user.PatientController;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.exception.ApiRequestException;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
